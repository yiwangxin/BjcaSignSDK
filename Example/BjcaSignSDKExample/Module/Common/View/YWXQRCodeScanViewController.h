//
//  YWXQRCodeScanViewController.h
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/4/6.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^YWXQRCodeScanCompletion)(NSString *result);
@interface YWXQRCodeScanViewController : UIViewController

+(void)showQRCodeScanWith:(UIViewController *)currentController scanCompletion:(YWXQRCodeScanCompletion)scanCompletion;

@end

NS_ASSUME_NONNULL_END
