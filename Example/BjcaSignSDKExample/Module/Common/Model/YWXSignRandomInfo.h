//
//  YWXSignRandomInfo.h
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/31.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWXSignRandomInfo : NSObject

+ (NSDictionary *)getRandomRecipeDic:(NSString *)accessToken
                              openId:(NSString *)openId
                            clientId:(NSString *)clientId
                               isPdf:(BOOL)isPDF;

@end

NS_ASSUME_NONNULL_END
