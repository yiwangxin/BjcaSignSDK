//
//  YWXProgressHUD.h
//  YWXSignFoundation
//
//  Created by Weipeng Qi on 2021/3/25.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^YWXProgressHUDCompletionBlock)(void);

@interface YWXProgressHUD : NSObject

#pragma mark - HUD 加在顶层控制器的 View

/// 在当前最顶控制器的 view 上显示纯文字提示，自动消失。
/// @param status 提示文字。
+ (void)showStatus:(NSString *)status;

/// 在当前最顶控制器的 view 上显示纯文字提示，自动消失。
/// @param status 提示文字。
/// @param completionBlock 消失后回调。
+ (void)showStatus:(NSString *)status completionBlock:(nullable YWXProgressHUDCompletionBlock)completionBlock;

/// 在当前最顶控制器的 view 上显示成功图标加提示文字，自动消失。
/// @param status 提示文字。
+ (void)showSuccessWithStatus:(NSString *)status;

/// 在当前最顶控制器的 view 上显示成功图标加提示文字，自动消失。
/// @param status 提示文字。
/// @param completionBlock 消失后回调。
+ (void)showSuccessWithStatus:(NSString *)status completionBlock:(nullable YWXProgressHUDCompletionBlock)completionBlock;

/// 在当前最顶控制器的 view 上显示错误图标加提示文字，自动消失。
/// @param status 提示文字。
+ (void)showErrorWithStatus:(NSString *)status;

/// 在当前最顶控制器的 view 上显示错误图标加提示文字，自动消失。
/// @param status 提示文字。
/// @param completionBlock 消失后回调。
+ (void)showErrorWithStatus:(NSString *)status completionBlock:(nullable YWXProgressHUDCompletionBlock)completionBlock;

#pragma mark - HUD 加在指定 View

/// 在某个 view 中显示提示文字，自动消失。
/// @param status 提示文字。
/// @param view view。
/// @param completionBlock 消失后回调。
+ (void)showStatus:(NSString *)status inView:(UIView *)view completionBlock:(nullable YWXProgressHUDCompletionBlock)completionBlock;

/// 在某个 view 中显示成功加提示文字。自动消失。
/// @param status 提示文字。
/// @param view view。
/// @param completionBlock 消失后回调。
+ (void)showSuccessWithStatus:(NSString *)status inView:(UIView *)view completionBlock:(nullable YWXProgressHUDCompletionBlock)completionBlock;


/// 在某个 view 中显示错误加提示文字，自动消失。
/// @param status 提示文字。
/// @param view view。
/// @param completionBlock 消失后回调。
+ (void)showErrorWithStatus:(NSString *)status inView:(UIView *)view completionBlock:(nullable YWXProgressHUDCompletionBlock)completionBlock;

#pragma mark - 自定义

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/// 类方法，在 view 中显示 HUD。
/// @param view UIView 对象。
+ (instancetype)showInView:(UIView *)view hasBackground:(BOOL)hasBackground;

/// 类方法，隐藏 view 中的 HUD，这个 HUD 之后会从 view 上移除。
/// @param view UIView 对象。
+ (BOOL)hideForView:(UIView *)view;

/// 对象方法，隐藏 view 中的 HUD，这个 HUD 之后会从 view 上移除。
- (void)hide;

@end

NS_ASSUME_NONNULL_END
