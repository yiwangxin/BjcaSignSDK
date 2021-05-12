//
//  YWXSignDataViewController.h
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/31.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWXBaseViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^ButtonClick)(NSArray *uniqueIDs);

@interface YWXSignDataViewController :YWXBaseViewController

@property (nonatomic,strong) NSString *clientId;

@property (nonatomic,strong) NSString *openId;

@property (nonatomic,copy) ButtonClick signButtonClickCallBack;

-(void)didClickSignButton:(NSArray *)uniqueIDs;



@end

NS_ASSUME_NONNULL_END
