//
//  YWXNetworkManager.h
//  YWXSignFoundation
//
//  Created by Weipeng Qi on 2021/3/24.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWXNetworkManager : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)sharedManager;

// GET

- (void)getWithURLString:(NSString *)URLString success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

- (void)getWithURLString:(NSString *)URLString parameters:(nullable id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

- (void)getWithURLString:(NSString *)URLString parameters:(nullable id)parameters headers:(nullable NSDictionary<NSString *, NSString *> *)headers success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// POST

- (void)postWithURLString:(NSString *)URLString parameters:(nullable id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

- (void)postWithURLString:(NSString *)URLString parameters:(nullable id)parameters headers:(nullable NSDictionary<NSString *, NSString *> *)headers success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

- (void)postJSONWithURLString:(NSString *)URLString parameters:(nullable id)parameters headers:(nullable NSDictionary<NSString *, NSString *> *)headers success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

- (void)postJsonWithURLString:(NSString *)URLString parameters:(id)parameters headers:(NSDictionary<NSString *,NSString *> *)headers progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure;

@end

NS_ASSUME_NONNULL_END
