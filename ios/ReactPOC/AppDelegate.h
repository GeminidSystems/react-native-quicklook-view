#import <React/RCTBridgeDelegate.h>
#import <UIKit/UIKit.h>

#import <MobileRTC/MobileRTC.h>

#define kSDKDomain @"zoom.us"

@interface AppDelegate : UIResponder <UIApplicationDelegate, RCTBridgeDelegate, MobileRTCAuthDelegate>

@property (nonatomic, strong) UIWindow *window;

@end
