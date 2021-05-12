//
//  AppDelegate.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/22.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MainTabBarController *tabbarController = [[MainTabBarController alloc] init];
    self.window.rootViewController = tabbarController;
    [self IQKeyBoard];
    return YES;
}

- (void)IQKeyBoard{
    //键盘
    [IQKeyboardManager sharedManager].enable = YES; //默认值为NO.
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;//不显示工具条
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;//点空白处收回
    //设置为文字
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"收起";
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = NO;
    UIColor *color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [IQKeyboardManager sharedManager].toolbarTintColor = color;
}

@end
