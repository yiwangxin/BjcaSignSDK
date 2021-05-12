//
//  YWXDemoNetManager.h
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/31.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/// SDK 开发环境。
typedef NS_ENUM(NSUInteger, YWXDemoEnvironment) {
    /// 生产环境
    YWXDemoEnvironmentProduction,
    /// 集成环境
    YWXDemoEnvironmentAcceptance,
    /// 测试环境
    YWXDemoEnvironmentTesting,
    /// 开发环境
    YWXDemoEnvironmentDevelopment,
};

typedef void(^YWXDemoNetManagerCompletionBlock)(NSString * _Nonnull status, NSString * _Nonnull message, id _Nullable info);
NS_ASSUME_NONNULL_BEGIN

@interface YWXDemoNetManager : NSObject

@property(nonatomic, assign) YWXDemoEnvironment environment;

@property(nonatomic, strong, readonly) NSString *urlHost;

+ (instancetype)sharedManager;


- (void)getWithURLPath:(NSString *)URLPath
            parameters:(nullable id)parameters
       businessSuccess:(YWXDemoNetManagerCompletionBlock)success
               failure:(YWXDemoNetManagerCompletionBlock)failure;

- (void)postJsonWithURLPath:(NSString *)URLPath
            parameters:(nullable id)parameters
       businessSuccess:(YWXDemoNetManagerCompletionBlock)success
                    failure:(YWXDemoNetManagerCompletionBlock)failure;

@end

NS_ASSUME_NONNULL_END
