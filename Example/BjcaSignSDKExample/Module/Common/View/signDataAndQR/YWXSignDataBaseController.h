//
//  YWXSignDataBaseController.h
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/4/6.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWXBaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface YWXSignDataBaseController : YWXBaseViewController

@property (nonatomic,strong) NSString *clientId;

@property (nonatomic,strong,readonly) NSString *currentClientId;

@property (nonatomic,strong) UIView *scrollView;

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) UILabel *clientIdLabel;

@property (nonatomic,strong) UITextField *clientIdTextField;

@property (nonatomic,strong) UILabel *secretIdLabel;

@property (nonatomic,strong) UITextField *secretIdTextField;

- (void)initView;

/// 获取token
/// @param success 成功
- (void)getClientToken:(void(^)(NSString * accessToken))success;

- (void)synSendData:(NSString *)accessToken
           clientId:(NSString *)clientId
             openId:(NSString *)openId
            version:(NSString *)version
              isPdf:(BOOL)isPdf
            success:(void(^)(NSString *uniqueId, NSString *authSignQRCode))success
               fail:(void(^)(NSString * errorMessage))fail;

- (UIImage *)ywx_imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
