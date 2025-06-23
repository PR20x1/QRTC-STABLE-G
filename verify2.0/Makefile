ARCHS = arm64
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1
IGNORE_WARNINGS = 1

TARGET = iphone:clang:latest:14.5

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = imgui

SECURITY_SRC = $(wildcard Helper/*.m) $(wildcard Security/oxorany/*.cpp)
LOADVIEW_SRC = $(wildcard LoadView/*.mm) $(wildcard LoadView/*.m) 
IMGUI_SRC = $(wildcard imgui/*.cpp) $(wildcard imgui/*.mm) $(wildcard Hook/*.c) $(wildcard Hook/*.m)
KITTYMEMORY_SRC = $(wildcard KittyMemory/*.cpp)

$(TWEAK_NAME)_CCFLAGS = -std=c++17 -fno-rtti -fno-exceptions -DNDEBUG -Wall -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value -Wno-unused-function -fvisibility=hidden -fexceptions
ADDITIONAL_CFLAGS += -DOBFUSCATE_STRINGS
ADDITIONAL_CFLAGS += -D_FORTIFY_SOURCE=2 -fstack-protector-all
ADDITIONAL_CFLAGS += -fvisibility=hidden -ffunction-sections -fdata-sections
ADDITIONAL_CFLAGS += -Wno-unused-function
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wall -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value -Wno-unused-function -fvisibility=hidden
$(TWEAK_NAME)_LDFLAGS = Hook/libdobby_fixed.a KittyMemory/Deps/Keystone/libs-ios/arm64/libkeystone.a

ifeq ($(IGNORE_WARNINGS),1)
  $(TWEAK_NAME)_CFLAGS += -w
  $(TWEAK_NAME)_CCFLAGS += -w
endif

$(TWEAK_NAME)_FILES = Tweak.xm ImGuiDrawView.mm $(SECURITY_SRC) $(LOADVIEW_SRC) $(IMGUI_SRC) $(KITTYMEMORY_SRC) CheatState/CheatState.cpp

$(TWEAK_NAME)_FRAMEWORKS = UIKit MetalKit Foundation Security QuartzCore CoreGraphics CoreText AVFoundation Accelerate GLKit SystemConfiguration GameController UIKit SafariServices Accelerate Foundation QuartzCore CoreGraphics AudioToolbox CoreText Metal MobileCoreServices Security SystemConfiguration IOKit CoreTelephony CoreImage CFNetwork AdSupport AVFoundation

include $(THEOS_MAKE_PATH)/tweak.mk
