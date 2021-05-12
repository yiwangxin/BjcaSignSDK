//
//  YWXUserInfoViewController.h
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/4/7.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import "YWXBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YWXUserInfoViewController : YWXBaseViewController

@property(nonatomic, strong) NSString *openId;

@property(nonatomic, assign) BOOL freePin;

@property(nonatomic, copy) NSDictionary *userInfoDictionary;

@property(nonatomic, copy) NSString *stampImageBase64;

@end

NS_ASSUME_NONNULL_END
