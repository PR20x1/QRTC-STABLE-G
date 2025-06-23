#import <UIKit/UIKit.h>
#include "Includes.h"

@interface MenuLoad()
@property (nonatomic, strong) ImGuiDrawView *vna;
@property (nonatomic, strong) NSTimer *visibilityTimer; // Thêm timer để tự động ẩn button
- (ImGuiDrawView*) GetImGuiView;
@end

static MenuLoad *extraInfo;

UIButton* InvisibleMenuButton;
UIButton* VisibleMenuButton;
MenuInteraction* menuTouchView;
UITextField* hideRecordTextfield;
UIView* hideRecordView;
ImVec2 menuPos, menuSize;
bool isMenuOpen = false;

@interface MenuInteraction()
@end

@implementation MenuInteraction

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[extraInfo GetImGuiView] updateIOWithTouchEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[extraInfo GetImGuiView] updateIOWithTouchEvent:event];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[extraInfo GetImGuiView] updateIOWithTouchEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[extraInfo GetImGuiView] updateIOWithTouchEvent:event];
}

@end

@implementation MenuLoad

- (ImGuiDrawView*) GetImGuiView
{
    return _vna;
}

static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info)
{   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      
        extraInfo = [MenuLoad new];
        [extraInfo initTapGes]; 
    });
}

__attribute__((constructor)) static void initialize()
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDrop);
}

-(void)initTapGes {
    UIView* mainView = [UIApplication sharedApplication].windows[0].rootViewController.view;

    hideRecordTextfield = [[UITextField alloc] init];
    hideRecordView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    [hideRecordView setBackgroundColor:[UIColor clearColor]];
    [hideRecordView setUserInteractionEnabled:YES];
    hideRecordTextfield.secureTextEntry = true;
    [hideRecordView addSubview:hideRecordTextfield];

    CALayer *layer = hideRecordTextfield.layer;
    if ([layer.sublayers.firstObject.delegate isKindOfClass:[UIView class]]) {
        hideRecordView = (UIView *)layer.sublayers.firstObject.delegate;
    } else {
        hideRecordView = nil;
    }

    [[UIApplication sharedApplication].keyWindow addSubview:hideRecordView];

    if (!_vna) {
        ImGuiDrawView *vc = [[ImGuiDrawView alloc] init];
        _vna = vc;
    }

    [ImGuiDrawView showChange:false];
    [hideRecordView addSubview:_vna.view];

    menuTouchView = [[MenuInteraction alloc] initWithFrame:mainView.frame];
    [[UIApplication sharedApplication].windows[0].rootViewController.view addSubview:menuTouchView];

    VisibleMenuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    VisibleMenuButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 20 - 55, [UIScreen mainScreen].bounds.size.height - 50 - 55, 55, 55);
    VisibleMenuButton.backgroundColor = [UIColor clearColor];
    VisibleMenuButton.layer.cornerRadius = VisibleMenuButton.frame.size.width * 0.5f;
    VisibleMenuButton.clipsToBounds = YES;
    [hideRecordView addSubview:VisibleMenuButton];

    NSURL *iconURL = [NSURL URLWithString:@"https://pub-d436114e897b4161a1b9814e736e63c1.r2.dev/aovcheat.png"];
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
        dataTaskWithURL:iconURL
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (data && !error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *originalImage = [UIImage imageWithData:data];
                    if (originalImage) {
                        CGFloat targetSize = 28.0;
                        CGRect imageRect = CGRectMake(0, 0, targetSize, targetSize);

                        UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, 0.0);
                        [[UIBezierPath bezierPathWithRoundedRect:imageRect cornerRadius:targetSize/2] addClip];
                        [originalImage drawInRect:imageRect];
                        UIImage *circularImage = UIGraphicsGetImageFromCurrentImageContext();
                        UIGraphicsEndImageContext();

                        [VisibleMenuButton setBackgroundImage:circularImage forState:UIControlStateNormal];
                    }
                });
            }
    }];
    [downloadTask resume];

    // Invisible button để kéo/thao tác
    InvisibleMenuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    InvisibleMenuButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 20 - 55, [UIScreen mainScreen].bounds.size.height - 50 - 55, 55, 55);
    InvisibleMenuButton.backgroundColor = [UIColor clearColor];
    [InvisibleMenuButton addTarget:self action:@selector(buttonDragged:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [InvisibleMenuButton addTarget:self action:@selector(buttonTouchDown) forControlEvents:UIControlEventTouchDown];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu:)];
    [InvisibleMenuButton addGestureRecognizer:tapGestureRecognizer];

    [[UIApplication sharedApplication].windows[0].rootViewController.view addSubview:InvisibleMenuButton];
    
    // Thêm gesture recognizer cho toàn màn hình để hiện button khi cần
    UITapGestureRecognizer *screenTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenTapped:)];
    screenTapGesture.cancelsTouchesInView = NO;
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addGestureRecognizer:screenTapGesture];
    
    // Bắt đầu timer để tự động ẩn button
    [self resetIconVisibilityTimer];
}

-(void)showMenu:(UITapGestureRecognizer *)tapGestureRecognizer {
    if(tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [ImGuiDrawView showChange:![ImGuiDrawView isMenuShowing]];
        isMenuOpen = ![ImGuiDrawView isMenuShowing];
    }
    
    [self resetIconVisibilityTimer]; // Reset timer khi mở menu
}

- (void)buttonDragged:(UIButton *)button withEvent:(UIEvent *)event
{
    UITouch *touch = [[event touchesForView:button] anyObject];

    CGPoint previousLocation = [touch previousLocationInView:button];
    CGPoint location = [touch locationInView:button];
    CGFloat delta_x = location.x - previousLocation.x;
    CGFloat delta_y = location.y - previousLocation.y;

    button.center = CGPointMake(button.center.x + delta_x, button.center.y + delta_y);

    VisibleMenuButton.center = button.center;
    VisibleMenuButton.frame = button.frame;
    
    [self resetIconVisibilityTimer]; // Reset timer khi kéo button
}

// Thêm các phương thức mới để quản lý tự động ẩn button

- (void)resetIconVisibilityTimer {
    [self.visibilityTimer invalidate];
    
    // Đảm bảo button hiển thị rõ ràng
    VisibleMenuButton.alpha = 1.0;
    
    // Bắt đầu timer mới
    self.visibilityTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 
                                                           target:self 
                                                         selector:@selector(darkenButtons) 
                                                         userInfo:nil 
                                                          repeats:NO];
}

- (void)darkenButtons {
    // Làm mờ button dần dần
    [UIView animateWithDuration:0.5 animations:^{
        VisibleMenuButton.alpha = 0.5;
    }];
}

- (void)buttonTouchDown {
    // Hiển thị button rõ khi chạm vào
    [UIView animateWithDuration:0.2 animations:^{
        VisibleMenuButton.alpha = 1.0;
    }];
    [self resetIconVisibilityTimer];
}

- (void)screenTapped:(UITapGestureRecognizer *)gesture {
    // Kiểm tra xem tap có phải trên button không
    CGPoint location = [gesture locationInView:gesture.view];
    BOOL isTapOnButton = CGRectContainsPoint(InvisibleMenuButton.frame, location);
    
    // Nếu tap không phải trên button và button đang mờ thì hiện lại
    if (!isTapOnButton && VisibleMenuButton.alpha < 1.0) {
        [UIView animateWithDuration:0.3 animations:^{
            VisibleMenuButton.alpha = 1.0;
        }];
        [self resetIconVisibilityTimer];
    }
}

@end