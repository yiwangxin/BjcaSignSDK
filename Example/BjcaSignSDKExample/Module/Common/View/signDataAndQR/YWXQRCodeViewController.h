//
//  YWXQRCodeViewController.h
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/4/6.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWXQRCodeViewController : UIViewController

@property (nonatomic,strong) NSString *urlString;

@property (nonatomic,strong) NSString *imageBase64;

@end

NS_ASSUME_NONNULL_END
