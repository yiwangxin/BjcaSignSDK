//
//  YWXBaseViewController.h
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWXBaseViewController : UIViewController

/// 弹窗提醒
/// @param title 标题
/// @param code 状态码
/// @param message 信息
/// @param info 结果信息
-(void)showAlertWith:(NSString *)title code:(NSString *)code message:(NSString *)message info:(id)info;

-(void)showAlertWith:(NSString *)title
                code:(NSString *)code
             message:(NSString *)message
                info:(id)info
             confirm:(void (^ __nullable)(UIAlertAction *action))confirm;

- (UIImage *)ywx_imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
