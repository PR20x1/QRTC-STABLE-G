#include <stdio.h>
#include <string.h>
#include <dlfcn.h>
#include <mach-o/dyld.h>
#include <sys/sysctl.h>
#include <sys/types.h>
#include <unistd.h>
#include <pwd.h>
#include <objc/runtime.h>
#include <mach/mach.h>
#include <TargetConditionals.h>
#include <CommonCrypto/CommonDigest.h>
#include <Security/Security.h>
#include "fishhook.h"

// ======================== MD5 Hash Spoofing ========================
static unsigned char* fake_CC_MD5(const void *data, CC_LONG len, unsigned char *md) {
    static const unsigned char dummy_hash[CC_MD5_DIGEST_LENGTH] = {
        0xAB, 0xAB, 0xAB, 0xAB, 0xCD, 0xCD, 0xCD, 0xCD,
        0xEF, 0xEF, 0xEF, 0xEF, 0x00, 0x00, 0x00, 0x00
    };
    memcpy(md, dummy_hash, CC_MD5_DIGEST_LENGTH);
    return md;
}

// ======================== Anti-Debugging ========================
static int (*orig_ptrace)(int _request, pid_t _pid, caddr_t _addr, int _data);
int fake_ptrace(int _request, pid_t _pid, caddr_t _addr, int _data) {
    return 0;
}

static int (*orig_sysctl)(int *name, u_int namelen, void *oldp, size_t *oldlenp, void *newp, size_t newlen);
int fake_sysctl(int *name, u_int namelen, void *oldp, size_t *oldlenp, void *newp, size_t newlen) {
    if (namelen == 4 && name[0] == CTL_KERN && name[1] == KERN_PROC && name[2] == KERN_PROC_PID) {
        struct kinfo_proc *info = (struct kinfo_proc *)oldp;
        size_t origSize = *oldlenp;
        int res = orig_sysctl(name, namelen, oldp, oldlenp, newp, newlen);
        if (res == 0 && oldp != NULL && *oldlenp >= sizeof(struct kinfo_proc)) {
            info->kp_proc.p_flag &= ~P_TRACED;
        }
        *oldlenp = origSize;
        return res;
    }
    return orig_sysctl(name, namelen, oldp, oldlenp, newp, newlen);
}

static kern_return_t (*orig_task_info)(task_t task, task_flavor_t flavor, task_info_t task_info_out, mach_msg_type_number_t *task_info_outCnt);
kern_return_t fake_task_info(task_t task, task_flavor_t flavor, task_info_t out, mach_msg_type_number_t *outCnt) {
    kern_return_t res = orig_task_info(task, flavor, out, outCnt);
    if (res == KERN_SUCCESS && flavor == TASK_DYLD_INFO) {
        memset(out, 0, sizeof(struct task_dyld_info));
    }
    return res;
}

// ======================== Dylib Injection Protection ========================
const char* blockedLibs[] = {
    "frida", "gadget", "libimobile", "libhooker", "substrate",
    "iosipadl.dylib", "TweakInject.dylib", NULL
};

static void* (*orig_dlopen)(const char* path, int mode);
void* fake_dlopen(const char* path, int mode) {
    if (path) {
        for (int i = 0; blockedLibs[i]; i++) {
            if (strstr(path, blockedLibs[i])) {
                return NULL;
            }
        }
    }
    return orig_dlopen(path, mode);
}

// ======================== Objective-C Class Hiding ========================
const char* blockedClasses[] = {
    "ModController", "LicenseManager", "LicenseViewController", NULL
};

static Class (*orig_objc_getClass)(const char* name);
Class fake_objc_getClass(const char* name) {
    for (int i = 0; blockedClasses[i]; i++) {
        if (strcmp(name, blockedClasses[i]) == 0) {
            return nil;
        }
    }
    return orig_objc_getClass(name);
}

// ======================== Environment Checks ========================
static char* (*orig_getenv)(const char *name);
char* fake_getenv(const char *name) {
    if (name && (strstr(name, "DYLD_") || strstr(name, "LD_") || strstr(name, "DEBUG"))) {
        return NULL;
    }
    return orig_getenv(name);
}

static int (*orig_isatty)(int fd);
int fake_isatty(int fd) {
    return 0;
}

static struct passwd* (*orig_getpwuid)(uid_t uid);
struct passwd* fake_getpwuid(uid_t uid) {
    static struct passwd fake_pw;
    static char fake_name[] = "ios_user";
    static char fake_dir[] = "/var/mobile";

    struct passwd* pw = orig_getpwuid(uid);
    if (pw) {
        memcpy(&fake_pw, pw, sizeof(struct passwd));
        fake_pw.pw_name = fake_name;
        fake_pw.pw_dir = fake_dir;
        return &fake_pw;
    }
    return NULL;
}

// ======================== Signature Checks Bypass ========================
static int (*orig_csops)(pid_t pid, unsigned int ops, void *useraddr, size_t usersize);
int fake_csops(pid_t pid, unsigned int ops, void *useraddr, size_t usersize) {
    if (ops == 0x1000007) { // CS_OPS_STATUS
        if (useraddr && usersize >= sizeof(int)) {
            *(int *)useraddr = 0;
            return 0;
        }
    }
    return orig_csops(pid, ops, useraddr, usersize);
}

static OSStatus (*orig_SecCodeCopySelf)(SecCSFlags flags, SecCodeRef *selfRef);
OSStatus fake_SecCodeCopySelf(SecCSFlags flags, SecCodeRef *selfRef) {
    return -1;
}

static OSStatus (*orig_SecCodeCopySigningInformation)(SecStaticCodeRef code, SecCSFlags flags, CFDictionaryRef *information);
OSStatus fake_SecCodeCopySigningInformation(SecStaticCodeRef code, SecCSFlags flags, CFDictionaryRef *information) {
    return -1;
}

// ======================== Dylib Hiding ========================
const char* blockedDylibs[] = {
    "iosipadl.dylib", "libsubstrate.dylib", "TweakInject.dylib",
    "FridaGadget.dylib", "CydiaSubstrate", "SubstrateLoader",
    "libhooker", "libblackjack.dylib", NULL
};

static const char* (*orig_dyld_get_image_name)(uint32_t index);
const char* fake_dyld_get_image_name(uint32_t index) {
    const char* name = orig_dyld_get_image_name(index);
    if (!name) return name;

    for (int i = 0; blockedDylibs[i]; i++) {
        if (strstr(name, blockedDylibs[i])) {
            return "";
        }
    }
    return name;
}

static uint32_t (*orig_dyld_image_count)(void);
uint32_t fake_dyld_image_count(void) {
    uint32_t count = orig_dyld_image_count();
    uint32_t hidden = 0;

    for (uint32_t i = 0; i < count; i++) {
        const char* name = orig_dyld_get_image_name(i);
        if (name) {
            for (int j = 0; blockedDylibs[j]; j++) {
                if (strstr(name, blockedDylibs[j])) {
                    hidden++;
                    break;
                }
            }
        }
    }
    return count - hidden;
}

static int (*orig_dladdr)(const void *addr, Dl_info *info);
int fake_dladdr(const void *addr, Dl_info *info) {
    int result = orig_dladdr(addr, info);
    if (result && info && info->dli_fname) {
        for (int i = 0; blockedDylibs[i]; i++) {
            if (strstr(info->dli_fname, blockedDylibs[i])) {
                info->dli_fname = "";
                break;
            }
        }
    }
    return result;
}

// ======================== Apply All Hooks ========================
__attribute__((constructor)) static void setup_hooks() {
    struct rebinding rebindings[] = {
        // MD5 Spoofing
        {"CC_MD5", (void *)fake_CC_MD5, (void **)&orig_CC_MD5},
        
        // Anti-Debug
        {"ptrace", (void *)fake_ptrace, (void **)&orig_ptrace},
        {"sysctl", (void *)fake_sysctl, (void **)&orig_sysctl},
        {"task_info", (void *)fake_task_info, (void **)&orig_task_info},
        
        // Dylib Injection Protection
        {"dlopen", (void *)fake_dlopen, (void **)&orig_dlopen},
        
        // ObjC Class Hiding
        {"objc_getClass", (void *)fake_objc_getClass, (void **)&orig_objc_getClass},
        
        // Env Checks
        {"getenv", (void *)fake_getenv, (void **)&orig_getenv},
        {"isatty", (void *)fake_isatty, (void **)&orig_isatty},
        {"getpwuid", (void *)fake_getpwuid, (void **)&orig_getpwuid},
        
        // Signature Checks
        {"csops", (void *)fake_csops, (void **)&orig_csops},
        {"SecCodeCopySelf", (void *)fake_SecCodeCopySelf, (void **)&orig_SecCodeCopySelf},
        {"SecCodeCopySigningInformation", (void *)fake_SecCodeCopySigningInformation, (void **)&orig_SecCodeCopySigningInformation},
        
        // Dylib Hiding
        {"_dyld_get_image_name", (void *)fake_dyld_get_image_name, (void **)&orig_dyld_get_image_name},
        {"_dyld_image_count", (void *)fake_dyld_image_count, (void **)&orig_dyld_image_count},
        {"dladdr", (void *)fake_dladdr, (void **)&orig_dladdr}
    };
    
    rebind_symbols(rebindings, sizeof(rebindings)/sizeof(rebindings[0]));
}
