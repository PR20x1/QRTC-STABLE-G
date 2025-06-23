#define OXORANY_USE_BIT_CAST

#import <UIKit/UIKit.h>
#include <unordered_map>
#include <CoreFoundation/CoreFoundation.h>
#include <limits>
#include <chrono>
#include <Foundation/Foundation.h>
#include <libgen.h>
#include <mach-o/dyld.h>
#include <mach-o/fat.h>
#include <mach-o/loader.h>
#include <mach/vm_page_size.h>
#include <unistd.h>
#include <array>
#include <deque>
#include <map>
#include <vector>

#include "LoadView/Includes.h"
#import "imgui/fontAwesome.h"
#import "Helper/DTTJailbreakDetection.h"
#import "imgui/oxorany.h"
#import "Draw/Draw.h"

#include "imgui/Recto.hpp"

#import "Utilities/Macros.h"
#import "Utilities/Obfuscate.h"
#import "Utilities/XORstring.h"

#import "Helper/Quaternion.hpp"
#import "Helper/Vector3.h"
#import "Helper/Vector2.h"
#import "Helper/Vector4.h"
#import "Helper/Matrix4x4.h"
#import "Helper/Unity.h"

#include "CheatState/CheatState.hpp"
#import "Hosts/NSObject+URL.h"

#pragma mark - MTKViewDelegate

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kScale  [UIScreen mainScreen].scale

// Example Function pointers
void* (*GetBoneTransform)(void* component, int boneID) = (void* (*)(void*, int))getRealOffset(0x107318B1C); // public Transform GetBoneTransform(HumanBodyBones humanBoneId) { } // 1 lista
bool (*Linecast)(Vector3, Vector3, long) = (bool (*)(Vector3, Vector3, long))getRealOffset(0x107372750); // public static bool Linecast(Vector3 start, Vector3 end, long layerMask) { } // 1 lista
int (*GetLayer)(void*) = (int (*)(void*))getRealOffset(0x107328C38); // public int get_layer() { } // 1 lista
void *(*GetMainCamera)() = (void *(*)())getRealOffset(0x107323900); // public static Camera get_main() { } // 1 lista
void *(*GetComponentTransform)(void *component) = (void *(*)(void *))getRealOffset(0x1073292D0); // public Transform get_transform() { } // 1 lista
void (*GetTransformPosition)(void *transform, Vector3 *out) = (void (*)(void *, Vector3 *))getRealOffset(0x10739E44C); // private void INTERNAL_get_position(out Vector3 value) { } // 1 lista
Matrix4x4 (*GetWorldToCameraMatrix)(void* camera) = (Matrix4x4(*)(void*))getRealOffset(0x1073231C4); // public Matrix4x4 get_worldToCameraMatrix() { } // 1 lista
Matrix4x4 (*GetProjectionMatrix)(void* camera) = (Matrix4x4(*)(void*))getRealOffset(0x1073232AC); // public Matrix4x4 get_projectionMatrix() { } // 1 lista
void* (*GetGameplayInstance)() = (void *(*)())getRealOffset(0x101E66C44); // public static BaseGame get_Game() { } // 1 lista
bool (*IsAlive)(void *info) = (bool (*)(void *))getRealOffset(0x10159C30C); // public override bool get_IsAlive() { } // 3 lista
bool (*IsRobot)(void *info) = (bool (*)(void *))getRealOffset(0x1020B51AC); // public bool get_IsRobot() { } // 1 lista
float (*GetHealth)(void *pawn) = (float (*)(void*))getRealOffset(0x101598A48); // public override float get_Health() { } // 4 lista
void* (*getLocalPawn)() = (void *(*)())getRealOffset(0x101E3A044); // public static Pawn get_LocalPawn() { }
bool (*GetIsFiring)(void *) = (bool (*)(void *))getRealOffset(0x101E9E214); // public bool GetIsFiring() { } // 1 lista
bool (*GetIsAiming)(void *) = (bool (*)(void *))getRealOffset(0x1015A5560); // public bool IsAiming() { } // 1 lista
Quaternion (*getAimRotation)(void*) = (Quaternion (*)(void*))getRealOffset(0x101598A80); // public virtual Quaternion get_AimRotation() { } // 1 lista
void (*setAimRotation)(void*, Quaternion) = (void (*)(void*, Quaternion))getRealOffset(0x1015AC4F0); // public virtual void SetAimRotation(Quaternion rotation) { } // 1 lista

@interface ImGuiDrawView () <MTKViewDelegate>
@property (nonatomic, strong) id <MTLDevice> device;
@property (nonatomic, strong) id <MTLCommandQueue> commandQueue;
@end


@implementation ImGuiDrawView
static bool MenDeal = false;
static bool StreamerMode = false;
static int totalEnemies = 0;
static float tDis = 0, tDistance = 0, markDistance, markDis;
Vector3 TargetPos;
static bool needAdjustAim = false;
static Vector2 markScreenPos;
ImFont* _espFont;
ImFont* _iconFont;

#pragma mark - Position Helpers

Vector3 GetPlayerPosition(void *player) {
    if (!player || !GetComponentTransform || !GetTransformPosition) {
        return Vector3();
    }
    Vector3 location;
    void* transform = GetComponentTransform(player);
    if (!transform) {
        return Vector3();
    }
    GetTransformPosition(transform, &location);
    return location;
}

Vector3 GetTransformPositionInternal(void *transform) {
    if (!transform || !GetTransformPosition) {
        return Vector3();
    }
    Vector3 location;
    GetTransformPosition(transform, &location);
    return location;
}

Matrix4x4 GetWorldToCamera() {
    if (GetMainCamera && GetWorldToCameraMatrix && GetMainCamera() != nullptr) {
        return GetWorldToCameraMatrix(GetMainCamera());
    }
    return Matrix4x4();
}

Matrix4x4 GetProjectionMatrixInternal() {
    if (GetMainCamera && GetProjectionMatrix && GetMainCamera() != nullptr) {
        return GetProjectionMatrix(GetMainCamera());
    }
    return Matrix4x4();
}

#pragma mark - Visibility Check

bool IsEnemyVisible(void* enemyPawn, Vector3 localPlayerPos) {
    if (!enemyPawn || !GetLayer || !Linecast) {
        return false;
    }
    
    void* headBone = *(void**)((uint64_t)enemyPawn + 0x2F0); // protected Transform m_HeadBone 
    if (!headBone) return false;
    
    Vector3 enemyHeadPos = GetTransformPositionInternal(headBone);
    
    // Adjust positions slightly
    localPlayerPos.y += 0.5f;  // ~chest height
    enemyHeadPos.y -= 0.1f;    // slightly below head
    
    // Layer mask handling
    long layerMask = ~0; // Default to all layers
    int enemyLayer = GetLayer(enemyPawn);
    if (enemyLayer >= 0 && enemyLayer < 64) {
        layerMask &= ~(1 << enemyLayer); // Exclude enemy's layer
    }
    
    bool isVisible = !Linecast(localPlayerPos, enemyHeadPos, layerMask);
    
    // Update visibility color in CheatState
    CheatState::visibilityColor[0] = isVisible ? 0.0f : 1.0f; // R
    CheatState::visibilityColor[1] = isVisible ? 1.0f : 0.0f; // G
    CheatState::visibilityColor[2] = 0.0f; // B
    
    return isVisible;
}

#pragma mark - Projection Helpers

Vector4 GetViewCoords(Vector3 pos, Matrix4x4 modelViewMatrix) {
    Vector4 viewPos;
    viewPos.X = pos.x * modelViewMatrix[0][0] + pos.y * modelViewMatrix[1][0] + pos.z * modelViewMatrix[2][0] + modelViewMatrix[3][0];
    viewPos.Y = pos.x * modelViewMatrix[0][1] + pos.y * modelViewMatrix[1][1] + pos.z * modelViewMatrix[2][1] + modelViewMatrix[3][1];
    viewPos.Z = pos.x * modelViewMatrix[0][2] + pos.y * modelViewMatrix[1][2] + pos.z * modelViewMatrix[2][2] + modelViewMatrix[3][2];
    viewPos.W = pos.x * modelViewMatrix[0][3] + pos.y * modelViewMatrix[1][3] + pos.z * modelViewMatrix[2][3] + modelViewMatrix[3][3];
    return viewPos;
}

Vector4 GetClipCoords(Vector4 pos, Matrix4x4 projectionMatrix) {
    Vector4 clipPos;
    clipPos.X = pos.X * projectionMatrix[0][0] + pos.Y * projectionMatrix[1][0] + pos.Z * projectionMatrix[2][0] + pos.W * projectionMatrix[3][0];
    clipPos.Y = pos.X * projectionMatrix[0][1] + pos.Y * projectionMatrix[1][1] + pos.Z * projectionMatrix[2][1] + pos.W * projectionMatrix[3][1];
    clipPos.Z = pos.X * projectionMatrix[0][2] + pos.Y * projectionMatrix[1][2] + pos.Z * projectionMatrix[2][2] + pos.W * projectionMatrix[3][2];
    clipPos.W = pos.X * projectionMatrix[0][3] + pos.Y * projectionMatrix[1][3] + pos.Z * projectionMatrix[2][3] + pos.W * projectionMatrix[3][3];
    return clipPos;
}

Vector3 NormalizeCoords(Vector4 pos) {
    Vector3 normalized;
    normalized.x = pos.X / pos.W;
    normalized.y = pos.Y / pos.W;
    normalized.z = pos.Z / pos.W;
    return normalized;
}

Vector2 GetScreenCoords(Vector3 pos) {
    Vector2 screen;
    screen.X = (kWidth / 2.0 * pos.x) + (pos.x + kWidth / 2.0);
    screen.Y = -(kHeight / 2.0 * pos.y) + (pos.y + kHeight / 2.0);
    return screen;
}

NSString* GetEnemyName(float distance, void* enemyInfo) {
    _monoString *m_NickName = *(_monoString **)((uint64_t)enemyInfo + 0x150); // protected string m_nickName
    NSString *nameEnemy = m_NickName->toNSString();
    bool isRobot = IsRobot ? IsRobot(enemyInfo) : false;
    
    if (isRobot || nameEnemy.length == 0) {
        return @"AI";
    }
    return nameEnemy;
}

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    _device = MTLCreateSystemDefaultDevice();
    _commandQueue = [_device newCommandQueue];

    if (!self.device) {
        abort();
    }

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO();

    ImGui::StyleColorsDark();

    ImFontConfig config;
    ImFontConfig icons_config;
    config.FontDataOwnedByAtlas = false;
    icons_config.MergeMode = true;
    icons_config.PixelSnapH = true;
    icons_config.OversampleH = 2;
    icons_config.OversampleV = 2;

    static const ImWchar icons_ranges[] = { 0xf000, 0xf3ff, 0 };

    NSString *fontPath = nssoxorany("/System/Library/Fonts/Core/AvenirNext.ttc");

    _espFont = io.Fonts->AddFontFromFileTTF(fontPath.UTF8String, 30.f, &config, io.Fonts->GetGlyphRangesVietnamese());

    _iconFont = io.Fonts->AddFontFromMemoryCompressedTTF(font_awesome_data, font_awesome_size, 25.0f, &icons_config, icons_ranges);

    _iconFont->FontSize = 5;
    io.FontGlobalScale = 0.5f;

    ImGui_ImplMetal_Init(_device);
    return self;
}

+ (void)showChange:(BOOL)open {
    MenDeal = open;
}

+ (BOOL)isMenuShowing {
    return MenDeal;
}

- (MTKView *)mtkView {
    return (MTKView *)self.view;
}

- (void)loadView {
    CGFloat w = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width;
    CGFloat h = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height;
    self.view = [[MTKView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mtkView.device = self.device;
    if (!self.mtkView.device) {
        return;
    }
    
    self.mtkView.delegate = self;
    self.mtkView.preferredFramesPerSecond = UIScreen.mainScreen.maximumFramesPerSecond;
    self.mtkView.clearColor = MTLClearColorMake(0, 0, 0, 0);
    self.mtkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.mtkView.clipsToBounds = YES;
}

- (void)drawInMTKView:(MTKView*)view {
    hideRecordTextfield.secureTextEntry = StreamerMode;

    ImGuiIO& io = ImGui::GetIO();
    io.DisplaySize.x = view.bounds.size.width;
    io.DisplaySize.y = view.bounds.size.height;
    
    CGFloat framebufferScale = view.window.screen.scale ?: UIScreen.mainScreen.scale;
    io.DisplayFramebufferScale = ImVec2(framebufferScale, framebufferScale);
    
    static CFTimeInterval realLastTime = 0;
    CFTimeInterval realNow = CACurrentMediaTime();
    CFTimeInterval realDelta = realLastTime > 0 ? (realNow - realLastTime) : (1.0 / 60.0);
    realLastTime = realNow;
    io.Framerate = 1.0f / realDelta;
    io.DeltaTime = 1.0f / 60.0f;
    
    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
    
    if (MenDeal == true) {
        [self.view setUserInteractionEnabled:YES];
        [self.view.superview setUserInteractionEnabled:YES];
        [menuTouchView setUserInteractionEnabled:YES];
    } else if (MenDeal == false) {
        [self.view setUserInteractionEnabled:NO];
        [self.view.superview setUserInteractionEnabled:NO];
        [menuTouchView setUserInteractionEnabled:NO];
    }

    MTLRenderPassDescriptor* renderPassDescriptor = view.currentRenderPassDescriptor;
    if (renderPassDescriptor != nil) {
        id <MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        [renderEncoder pushDebugGroup:nssoxorany("ImGui Jane")];

        ImGui_ImplMetal_NewFrame(renderPassDescriptor);
        ImGui::NewFrame();
        if (CheatState::show_esp) {
        [self renderESP];
    }
    
    if (CheatState::enable_aimbot) {
        [self renderAimbotVisuals];
    }
    
    if (CheatState::enable_circleFov) {
        ImVec2 center = ImVec2(kWidth / 2, kHeight / 2);
        ImGui::GetBackgroundDrawList()->AddCircle(
            center, 
            CheatState::circleSizeValue, 
            IM_COL32(160, 0, 210, 255), 
            0, 
            1.5f
        );
    }

        if (MenDeal) {
            ImGui::SetNextWindowSize(ImVec2(420, 330), ImGuiCond_FirstUseEver);
            ImGui::SetNextWindowPos(ImVec2((kWidth - 420) / 2, (kHeight - 330) / 2), ImGuiCond_FirstUseEver);
            
            if (ImGui::Begin("Call of Duty Cheat VNG - Anhvu99er.com", &MenDeal, ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoCollapse)) {
                if (ImGui::BeginTabBar("MainTabs")) {
                    // Tab Chính với icon
                    if (ImGui::BeginTabItem(ICON_FA_HOME " Menu Chính")) {
                        
                        // ESP Section
                        if (ImGui::CollapsingHeader(ICON_FA_EYE " ESP", ImGuiTreeNodeFlags_DefaultOpen)) {
                            ImGui::Checkbox("Enable ESP", &CheatState::show_esp);  
                            ImGui::Indent(15);
                            ImGui::Checkbox("Enable Box", &CheatState::show_espboxes);  ImGui::SameLine(150);
                            ImGui::Checkbox("Enable Line", &CheatState::show_esplines);
                            ImGui::Checkbox("Enable Name", &CheatState::show_esp_name); ImGui::SameLine(150);
                            ImGui::Checkbox("Show Health", &CheatState::show_esp_health);   ImGui::SameLine();
                            ImGui::Checkbox("Show Distance", &CheatState::show_esp_distance);
                            ImGui::Unindent(15);
                        }
                        
                        // Aimbot Section
                        if (ImGui::CollapsingHeader(ICON_FA_CROSSHAIRS " Aimbot")) {
                            ImGui::Checkbox("Enable Aimbot", &CheatState::enable_aimbot);  ImGui::SameLine(200);
                            ImGui::Checkbox("Vẽ FOV", &CheatState::enable_circleFov);
                            ImGui::SliderInt("Fov size", &CheatState::circleSizeValue, 0, 360, "%d px");
                            ImGui::Indent(15);
                            
                            ImGui::Combo("Mục tiêu", &CheatState::aim_target, "Gần nhất\0Trong FOV\0");
                            ImGui::SetNextItemWidth(100); 
                            ImGui::Combo("Vị trí ngắm", &CheatState::aim_location, "Đầu\0Ngực\0Chân\0");    ImGui::SameLine();
                            ImGui::SetNextItemWidth(100);
                            ImGui::Combo("Kích hoạt", &CheatState::aim_trigger, "Luôn luôn\0Khi bắn\0Khi ngắm\0");
                            ImGui::Unindent(15);
                        }
                        
                        // Other Features
                        if (ImGui::CollapsingHeader(ICON_FA_COG " Other Features")) {
                            ImGui::Checkbox("LiveStream", &StreamerMode);
 
                        }
                        
                        ImGui::EndTabItem();
                    }
                    
                    // Tab Misc với icon
                    /* if (ImGui::BeginTabItem(ICON_FA_PUZZLE_PIECE " Misc")) {
                        ImGui::Text("Tính năng khác");
                        ImGui::Separator();
                        
                        // Visuals
                        if (ImGui::CollapsingHeader(ICON_FA_PAINT_BRUSH " Visuals", ImGuiTreeNodeFlags_DefaultOpen)) {
                            static bool noFog = false;
                            ImGui::Checkbox("No Fog", &noFog);
                            
                            static bool fullBright = false;
                            ImGui::Checkbox("Full Bright", &fullBright);
                            
                            static bool crosshair = false;
                            ImGui::Checkbox("Crosshair", &crosshair);
                            
                            static float fovChanger = 90.0f;
                            ImGui::SliderFloat("FOV", &fovChanger, 60.0f, 120.0f, "%.0f");
                        }
                        
                        // Player Mods
                        if (ImGui::CollapsingHeader(ICON_FA_USER " Player Mods")) {
                            static bool godMode = false;
                            ImGui::Checkbox("God Mode", &godMode);
                            
                            static bool infiniteAmmo = false;
                            ImGui::Checkbox("Infinite Ammo", &infiniteAmmo);
                            
                            static bool noFallDamage = false;
                            ImGui::Checkbox("No Fall Damage", &noFallDamage);
                            
                            static bool jumpHack = false;
                            ImGui::Checkbox("Jump Hack", &jumpHack);
                        }
                        
                        // Teleport
                        if (ImGui::CollapsingHeader(ICON_FA_LOCATION_ARROW " Teleport")) {
                            if (ImGui::Button("Save Position")) {
                                // Save current position
                            }
                            ImGui::SameLine();
                            if (ImGui::Button("Load Position")) {
                                // Load saved position
                            }
                            
                            static float teleportX = 0.0f;
                            static float teleportY = 0.0f;
                            static float teleportZ = 0.0f;
                            
                            ImGui::InputFloat("X", &teleportX);
                            ImGui::InputFloat("Y", &teleportY);
                            ImGui::InputFloat("Z", &teleportZ);
                            
                            if (ImGui::Button("Teleport")) {
                                // Teleport to coordinates
                            }
                        }
                        
                        ImGui::EndTabItem();
                    }
                    
                    // Tab Settings với icon
                    if (ImGui::BeginTabItem(ICON_FA_WRENCH " Setting")) {
                        ImGui::Text("Cài đặt");
                        ImGui::Separator();
                        
                        // General Settings
                        if (ImGui::CollapsingHeader(ICON_FA_SLIDERS_H " General", ImGuiTreeNodeFlags_DefaultOpen)) {
                            ImGui::Checkbox("Streamer Mode", &StreamerMode);
                            
                            static float globalScale = 0.5f;
                            if (ImGui::SliderFloat("UI Scale", &globalScale, 0.3f, 1.0f, "%.2f")) {
                                ImGui::GetIO().FontGlobalScale = globalScale;
                            }
                            
                            static bool showFPS = true;
                            ImGui::Checkbox("Show FPS", &showFPS);
                            
                            static bool menuAnimation = true;
                            ImGui::Checkbox("Menu Animation", &menuAnimation);
                        }
                        
                        // Color Settings
                        if (ImGui::CollapsingHeader(ICON_FA_PALETTE " Colors")) {
                            static float espColor[3] = { 1.0f, 0.0f, 0.0f };
                            ImGui::ColorEdit3("ESP Color", espColor);
                            
                            static float aimbotColor[3] = { 0.0f, 1.0f, 0.0f };
                            ImGui::ColorEdit3("Aimbot Color", aimbotColor);
                            
                            static float menuColor[3] = { 0.2f, 0.3f, 0.8f };
                            ImGui::ColorEdit3("Menu Accent", menuColor);
                        }
                        
                        // Key Bindings
                        if (ImGui::CollapsingHeader(ICON_FA_KEYBOARD " Key Bindings")) {
                            ImGui::Text("Menu Toggle: Home");
                            ImGui::Text("Aimbot Toggle: Insert");
                            ImGui::Text("ESP Toggle: Delete");
                            
                            if (ImGui::Button("Reset All Settings")) {
                                // Reset to defaults
                            }
                        }
                        
                        // Info
                        if (ImGui::CollapsingHeader(ICON_FA_INFO_CIRCLE " Info")) {
                            ImGui::Text("Version: 1.0.0");
                            ImGui::Text("Build: Debug");
                            ImGui::Text("Author: YourName");
                            ImGui::Separator();
                            ImGui::Text("FPS: %.1f", ImGui::GetIO().Framerate);
                            ImGui::Text("Frame time: %.3f ms", 1000.0f / ImGui::GetIO().Framerate);
                        }
                        
                        ImGui::EndTabItem();
                    } */
                    
                    ImGui::EndTabBar();
                }
            }
            ImGui::End();
        }

        ImGui::Render();
        ImDrawData* draw_data = ImGui::GetDrawData();
        ImGui_ImplMetal_RenderDrawData(draw_data, commandBuffer, renderEncoder);

        [renderEncoder popDebugGroup];
        [renderEncoder endEncoding];

        [commandBuffer presentDrawable:view.currentDrawable];
    }
    [commandBuffer commit];
}

- (void)mtkView:(MTKView*)view drawableSizeWillChange:(CGSize)size {
    
}
- (void)updateIOWithTouchEvent:(UIEvent *)event
{
    UITouch *anyTouch = event.allTouches.anyObject;
    CGPoint touchLocation = [anyTouch locationInView:self.view];
    ImGuiIO &io = ImGui::GetIO();
    io.MousePos = ImVec2(touchLocation.x, touchLocation.y);

    BOOL hasActiveTouch = NO;
    for (UITouch *touch in event.allTouches)
    {
        if (touch.phase != UITouchPhaseEnded && touch.phase != UITouchPhaseCancelled)
        {
            hasActiveTouch = YES;
            break;
        }
    }
    io.MouseDown[0] = hasActiveTouch;
}

ImDrawList* getDrawList() {
    ImDrawList *drawList;
    drawList = ImGui::GetBackgroundDrawList();
    return drawList;
}

- (void)renderESP {
    if (!GetGameplayInstance) return;
    
    auto gameInstance = GetGameplayInstance();
    if (!gameInstance) return;
    
    CheatState::player_count = 0;
    CheatState::bot_count = 0;
    
    void *localPawn = getLocalPawn();
    if (!localPawn) return;
    
    Matrix4x4 viewMatrix = GetWorldToCamera();
    Matrix4x4 projectionMatrix = GetProjectionMatrixInternal();
    Vector3 localPlayerPosition = GetPlayerPosition(localPawn);
    
    monoList<void **> *enemyList = *(monoList<void **>**)((uint64_t)gameInstance + 0x168); // private readonly PawnList EnemyPawns
    if (!enemyList) return;
    
    int enemyCount = enemyList->getSize();
    for (int i = 0; i < enemyCount; i++) {
        void* enemyPawn = enemyList->getItems()[i];
        if (!enemyPawn) continue;
        
        void* enemyInfo = *(void **)((uint64_t)enemyPawn + 0x598); // protected PlayerInfo m_PlayerInfo // 2 lista
        if (!enemyInfo) continue;
        
        bool isRobot = IsRobot ? IsRobot(enemyInfo) : false;
        if (isRobot) {
            CheatState::bot_count++;
        } else {
            CheatState::player_count++;
        }
        
        if (!IsAlive(enemyPawn)) continue;
        
        Vector3 enemyPositionWorld = GetPlayerPosition(enemyPawn);
        Vector4 enemyPositionView = GetViewCoords(enemyPositionWorld, viewMatrix);
        Vector4 enemyPositionClip = GetClipCoords(enemyPositionView, projectionMatrix);
        
        if (enemyPositionClip.Z < 0.1f) continue;
        
        Vector3 enemyPositionNormalized = NormalizeCoords(enemyPositionClip);
        Vector2 enemyPositionScreen = GetScreenCoords(enemyPositionNormalized);
        
        void* headBone = *(void **)((uint64_t)enemyPawn + 0x2F0); // protected Transform m_HeadBone 
        if (!headBone) continue;
        
        Vector3 enemyHeadPositionWorld = GetTransformPositionInternal(headBone);
        Vector4 enemyHeadPositionView = GetViewCoords(enemyHeadPositionWorld, viewMatrix);
        Vector4 enemyHeadPositionClip = GetClipCoords(enemyHeadPositionView, projectionMatrix);
        enemyHeadPositionClip.Y = enemyHeadPositionClip.Y + 0.5f;
        Vector3 enemyHeadPositionNormalized = NormalizeCoords(enemyHeadPositionClip);
        Vector2 enemyHeadPositionScreen = GetScreenCoords(enemyHeadPositionNormalized);
        
        bool isVisible = IsEnemyVisible(enemyPawn, localPlayerPosition);
        float distance = Vector3::Distance(localPlayerPosition, enemyPositionWorld);
        
        if (distance > CheatState::distanceValue) continue;
        
        // Calculate box dimensions
        float boxHeight = float(enemyPositionScreen.Y - enemyHeadPositionScreen.Y);
        Recto rect = Recto(
            (enemyHeadPositionScreen.X - (boxHeight * 0.45f / 2)), 
            enemyHeadPositionScreen.Y, 
            boxHeight * 0.45f, 
            boxHeight
        );
        
        // Adjust colors based on visibility
        ImColor visibleColor = ImColor(
            isVisible ? CheatState::colorLines[0] : CheatState::colorLines[0] * 0.5f,
            isVisible ? CheatState::colorLines[1] : CheatState::colorLines[1] * 0.5f,
            isVisible ? CheatState::colorLines[2] : CheatState::colorLines[2] * 0.5f
        );
        
        // Draw ESP elements
        if (CheatState::show_esplines) {
            ImVec2 startLine, endLine;
            ImColor lineColor = ImColor(200, 200, 200, 100);
            float lineThickness = 0.4f;
            
            if (CheatState::line_position == 0) {
                // Line from top center of screen
                startLine = ImVec2(kWidth / 2, 0);
                endLine = ImVec2(enemyHeadPositionScreen.X, enemyHeadPositionScreen.Y);
            } else {
                // Line from bottom center of screen
                startLine = ImVec2(kWidth / 2, kHeight);
                endLine = ImVec2(enemyPositionScreen.X, enemyPositionScreen.Y);
            }
            
            ImGui::GetForegroundDrawList()->AddLine(startLine, endLine, lineColor, lineThickness);
        }
        
        if (CheatState::show_espboxes) {
            if (CheatState::box_style == 0) {
                // Rectangle box
                ImGui::GetBackgroundDrawList()->AddRect(
                    ImVec2(rect.x, rect.y),
                    ImVec2(rect.get_max_width(), rect.get_max_height()),
                    ImColor(CheatState::colorBoxes[0], CheatState::colorBoxes[1], CheatState::colorBoxes[2]),
                    0.0f,
                    0,
                    1.5f
                );
            } else {
                // Corner box
                float cornerSize = std::min(rect.w, rect.h) * 0.25f;
                float lineThickness = 2.0f;
                ImColor boxColor = ImColor(CheatState::colorBoxes[0], CheatState::colorBoxes[1], CheatState::colorBoxes[2]);
                
                // Top left
                ImGui::GetBackgroundDrawList()->AddLine(
                    ImVec2(rect.x, rect.y + cornerSize), 
                    ImVec2(rect.x, rect.y), 
                    boxColor, lineThickness);
                ImGui::GetBackgroundDrawList()->AddLine(
                    ImVec2(rect.x, rect.y), 
                    ImVec2(rect.x + cornerSize, rect.y), 
                    boxColor, lineThickness);
                
                // Top right
                ImGui::GetBackgroundDrawList()->AddLine(
                    ImVec2(rect.get_max_width() - cornerSize, rect.y), 
                    ImVec2(rect.get_max_width(), rect.y), 
                    boxColor, lineThickness);
                ImGui::GetBackgroundDrawList()->AddLine(
                    ImVec2(rect.get_max_width(), rect.y), 
                    ImVec2(rect.get_max_width(), rect.y + cornerSize), 
                    boxColor, lineThickness);
                
                // Bottom left
                ImGui::GetBackgroundDrawList()->AddLine(
                    ImVec2(rect.x, rect.get_max_height() - cornerSize), 
                    ImVec2(rect.x, rect.get_max_height()), 
                    boxColor, lineThickness);
                ImGui::GetBackgroundDrawList()->AddLine(
                    ImVec2(rect.x, rect.get_max_height()), 
                    ImVec2(rect.x + cornerSize, rect.get_max_height()), 
                    boxColor, lineThickness);
                
                // Bottom right
                ImGui::GetBackgroundDrawList()->AddLine(
                    ImVec2(rect.get_max_width() - cornerSize, rect.get_max_height()), 
                    ImVec2(rect.get_max_width(), rect.get_max_height()), 
                    boxColor, lineThickness);
                ImGui::GetBackgroundDrawList()->AddLine(
                    ImVec2(rect.get_max_width(), rect.get_max_height()), 
                    ImVec2(rect.get_max_width(), rect.get_max_height() - cornerSize), 
                    boxColor, lineThickness);
                
                if (CheatState::filled_box) {
                    ImGui::GetBackgroundDrawList()->AddRectFilled(
                        ImVec2(rect.x, rect.y), 
                        ImVec2(rect.get_max_width(), rect.get_max_height()),
                        ImColor(
                            CheatState::boxFillColor[0], 
                            CheatState::boxFillColor[1], 
                            CheatState::boxFillColor[2], 
                            CheatState::boxFillColor[3] * (isVisible ? 1.0f : 0.5f)
                        )
                    );
                }
            }
        }
        
        if (CheatState::show_esp_health) {
            float health = GetHealth(enemyPawn);
            float maxHealth = *(float *)((uint64_t)enemyPawn + 0x78 + 0x38); // private AttackableTargetInfo m_AttackableInfo->protected float m_MaxHealth
            
            drawHealth(rect, health, maxHealth);
        }
        
        if (CheatState::show_esp_name) {
            NSString *enemyName = GetEnemyName(distance, enemyInfo);
            ImVec2 textPos = ImVec2(
                rect.x + (rect.w / 2) - (ImGui::CalcTextSize(enemyName.UTF8String).x / 2), 
                rect.y - 10
            );
            ImGui::GetBackgroundDrawList()->AddText(
                textPos, 
                ImColor(CheatState::colorName[0], CheatState::colorName[1], CheatState::colorName[2]), 
                enemyName.UTF8String
            );
        }
        
        if (CheatState::show_esp_distance) {
            NSString *distanceText = [NSString stringWithFormat:@"%.1fm", distance];
            ImVec2 textPos = ImVec2(
                rect.x + (rect.w / 2) - (ImGui::CalcTextSize(distanceText.UTF8String).x / 2), 
                rect.y + rect.h + 5
            );
            ImGui::GetBackgroundDrawList()->AddText(
                textPos, 
                ImColor(CheatState::colorDistance[0], CheatState::colorDistance[1], CheatState::colorDistance[2]), 
                distanceText.UTF8String
            );
        }
    }
}

- (void)renderAimbotVisuals {
    if (!CheatState::enable_aimbot) return;
    
    void* localPawn = getLocalPawn();
    if (!localPawn) return;
    
    Matrix4x4 viewMatrix = GetWorldToCamera();
    Matrix4x4 projectionMatrix = GetProjectionMatrixInternal();
    Vector3 localPlayerPosition = GetPlayerPosition(localPawn);
    
    void* gameInstance = GetGameplayInstance();
    if (!gameInstance) return;
    
    monoList<void **> *enemyList = *(monoList<void **>**)((uint64_t)gameInstance + 0x168); // private readonly PawnList EnemyPawns
    if (!enemyList) return;
    
    float closestDistance = std::numeric_limits<float>::infinity();
    float closestFovDistance = std::numeric_limits<float>::infinity();
    void* bestTarget = nullptr;
    Vector3 bestTargetPosition;
    Vector2 bestScreenPos;
    
    int enemyCount = enemyList->getSize();
    for (int i = 0; i < enemyCount; i++) {
        void* enemyPawn = enemyList->getItems()[i];
        if (!enemyPawn) continue;
        
        if (!IsAlive(enemyPawn)) continue;
        
        float health = GetHealth(enemyPawn);
        if (health <= 0) continue;
        
        Vector3 enemyPosition = GetPlayerPosition(enemyPawn);
        float distance = Vector3::Distance(localPlayerPosition, enemyPosition);
        
        if (distance > CheatState::max_distance) continue;
        
        void* targetBone = *(void **)((uint64_t)enemyPawn + 0x2F0); // protected Transform m_HeadBone 
        if (!targetBone) continue;
        
        Vector3 bonePosition = GetTransformPositionInternal(targetBone);
        
        // Adjust aim position based on setting
        if (CheatState::aim_location == 1) {
            bonePosition.y -= 0.2f; // Chest
        } else if (CheatState::aim_location == 2) {
            bonePosition.y -= 0.4f; // Legs/waist
        }
        
        Vector4 targetPosView = GetViewCoords(bonePosition, viewMatrix);
        Vector4 targetPosClip = GetClipCoords(targetPosView, projectionMatrix);
        
        if (targetPosClip.Z < 0.1f) continue;
        
        Vector3 targetPosNorm = NormalizeCoords(targetPosClip);
        Vector2 targetScreenPos = GetScreenCoords(targetPosNorm);
        
        if (targetScreenPos.X < 0 || targetScreenPos.X > kWidth ||
            targetScreenPos.Y < 0 || targetScreenPos.Y > kHeight) {
            continue;
        }
        
        float centerX = kWidth / 2.0f;
        float centerY = kHeight / 2.0f;
        float dx = targetScreenPos.X - centerX;
        float dy = targetScreenPos.Y - centerY;
        float fovDistance = sqrt(dx * dx + dy * dy);
        
        bool selectTarget = false;
        
        if (CheatState::aim_target == 0) {
            if (distance < closestDistance) {
                closestDistance = distance;
                selectTarget = true;
            }
        } else if (CheatState::aim_target == 1) {
            if (fovDistance <= CheatState::circleSizeValue) {
                if (fovDistance < closestFovDistance) {
                    closestFovDistance = fovDistance;
                    selectTarget = true;
                }
            }
        }
        
        if (selectTarget) {
            bestTarget = enemyPawn;
            bestTargetPosition = bonePosition;
            closestDistance = distance;
            bestScreenPos = targetScreenPos;
        }
    }
    
    if (bestTarget) {
        if (CheatState::aim_visual_style == 0) {
            // Circle
            ImGui::GetForegroundDrawList()->AddCircle(
                ImVec2(bestScreenPos.X, bestScreenPos.Y), 
                5.0f,
                ImColor(255, 0, 0, 200), 
                12, 
                2.0f
            );
        } else {
            // Line
            ImGui::GetForegroundDrawList()->AddLine(
                ImVec2(kWidth / 2, kHeight / 2),
                ImVec2(bestScreenPos.X, bestScreenPos.Y),
                ImColor(255, 0, 0, 200),
                1.5f
            );
        }
        
        // Handle aiming logic
        [self handleAimingToTarget:bestTarget position:bestTargetPosition localPawn:localPawn distance:closestDistance];
    }
}

- (void)handleAimingToTarget:(void*)target position:(Vector3)targetPos localPawn:(void*)localPawn distance:(float)distance {
    bool shouldAim = true;
    
    // Check activation conditions
    if (CheatState::aim_trigger == 1) {
        shouldAim = GetIsFiring(localPawn);
    } else if (CheatState::aim_trigger == 2) {
        shouldAim = GetIsAiming(localPawn);
    }
    
    if (!shouldAim) return;
    
    static Vector3 lastTargetPosition = Vector3(0, 0, 0);
    static bool wasTargeting = false;
    static float lastShotTime = 0.0f;
    static int burstCounter = 0;
    
    float currentTime = ImGui::GetTime();
    bool isFiring = GetIsFiring(localPawn);
    
    // Update burst counter
    if (isFiring) {
        if (currentTime - lastShotTime > 0.1f) {
            burstCounter++;
            lastShotTime = currentTime;
        }
    } else {
        if (currentTime - lastShotTime > 0.5f) {
            burstCounter = 0;
        }
    }
    
    // Get camera position
    void* mainCamera = GetMainCamera();
    if (!mainCamera) return;
    void* mainView = GetComponentTransform(mainCamera);
    if (!mainView) return;
    Vector3 cameraPosition = GetTransformPositionInternal(mainView);
    
    // Predict target position
    Vector3 predictedPosition = targetPos;
    
    if (wasTargeting && Vector3::Distance(lastTargetPosition, Vector3(0,0,0)) > 0.1f) {
        Vector3 targetVelocity;
        targetVelocity.x = targetPos.x - lastTargetPosition.x;
        targetVelocity.y = targetPos.y - lastTargetPosition.y;
        targetVelocity.z = targetPos.z - lastTargetPosition.z;
        
        float predictionFactor = 0.02f * (distance / 10.0f);
        predictionFactor = std::min(predictionFactor, 0.10f);
        
        predictedPosition.x = targetPos.x + (targetVelocity.x * predictionFactor);
        predictedPosition.y = targetPos.y + (targetVelocity.y * predictionFactor);
        predictedPosition.z = targetPos.z + (targetVelocity.z * predictionFactor);
    }
    
    lastTargetPosition = targetPos;
    wasTargeting = true;
    
    // Calculate aim direction
    Vector3 aimDirection;
    aimDirection.x = predictedPosition.x - cameraPosition.x;
    aimDirection.y = predictedPosition.y - cameraPosition.y;
    aimDirection.z = predictedPosition.z - cameraPosition.z;
    
    // Apply recoil compensation
    float recoilCompensation = CheatState::recoil_amount * 0.01f;
    if (shouldAim) {
        float verticalRecoil = std::min(burstCounter * recoilCompensation, recoilCompensation * 10);
        aimDirection.y -= verticalRecoil;
        
        if (burstCounter > 5) {
            float horizontalCompensation = -0.01f * recoilCompensation;
            aimDirection.x += horizontalCompensation;
        }
    }
    
    // Calculate target rotation
    Quaternion targetAim = Quaternion::LookRotation(aimDirection, Vector3::Up());
    Quaternion currentAim = getAimRotation(localPawn);
    
    // Adjust aim speed based on distance and health
    float aimSpeed = CheatState::aim_speed * 0.01f;
    float distanceFactor = 1.0f - (distance / CheatState::max_distance * 0.5f);
    float health = GetHealth(target);
    float healthFactor = 1.0f - (health / 100.0f * 0.3f);
    
    aimSpeed *= (1.0f + (distanceFactor + healthFactor) * 0.4f);
    aimSpeed = std::min(std::max(aimSpeed, 0.01f), 0.9f);
    
    // Smoothly interpolate to target rotation
    Quaternion finalAim = Quaternion::Slerp(currentAim, targetAim, aimSpeed);
    
    // Apply additional recoil compensation for burst fire
    if (burstCounter > 3) {
        Vector3 forward = finalAim * Vector3::Forward();
        forward.x -= 0.005f * burstCounter * recoilCompensation;
        finalAim = Quaternion::LookRotation(forward, Vector3::Up());
    }
    
    // Set the final aim rotation
    setAimRotation(localPawn, finalAim);
}

@end
