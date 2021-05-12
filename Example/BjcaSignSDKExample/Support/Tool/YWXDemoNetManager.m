//
//  YWXDemoNetManager.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/31.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import "YWXDemoNetManager.h"
#import "AFNetworking.h"

@interface YWXDemoNetManager ()

@property(nonatomic, strong) AFHTTPSessionManager *sessionManager;

//@property(nonatomic, strong) NSString *urlHost;

@end

@implementation YWXDemoNetManager

-(void)setEnvironment:(YWXDemoEnvironment)environment {
    _environment = environment;
    switch (environment) {
        case YWXDemoEnvironmentProduction:
            _urlHost = @"https://www.51trust.com";
            break;
        case YWXDemoEnvironmentAcceptance:
            _urlHost = @"http://test.51trust.com";
            break;
        case YWXDemoEnvironmentTesting:
            _urlHost = @"http://beta.51trust.com";
            break;
        case YWXDemoEnvironmentDevelopment:
            _urlHost = @"http://dev.51trust.com";
            break;
    }
}

+ (instancetype)sharedManager {
    static YWXDemoNetManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
        manager.sessionManager = [AFHTTPSessionManager manager];
    });
    return manager;
}

- (void)getWithURLPath:(NSString *)URLPath
            parameters:(nullable id)parameters
       businessSuccess:(YWXDemoNetManagerCompletionBlock)success
               failure:(YWXDemoNetManagerCompletionBlock)failure {
    NSString *urlString = [NSString stringWithFormat:@"%@%@",self.urlHost,URLPath];
    self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [self.sessionManager GET:urlString parameters:parameters headers:[self commonHeaders] progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"0"]) {
            success(@"0",@"success",responseObject[@"data"]);
        } else {
            failure(responseObject[@"status"],responseObject[@"message"],nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
        NSString *errorMessage = [NSString stringWithFormat:@"%@",error.localizedDescription];
        failure(errorCode,errorMessage,nil);
    }];
    
}

- (void)postWithURLPath:(NSString *)URLPath
            parameters:(nullable id)parameters
       businessSuccess:(YWXDemoNetManagerCompletionBlock)success
               failure:(YWXDemoNetManagerCompletionBlock)failure {
    NSString *urlString = [NSString stringWithFormat:@"%@%@",self.urlHost,URLPath];
    self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [self.sessionManager POST:urlString parameters:parameters headers:[self commonHeaders] progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"0"]) {
            success(@"0",@"success",responseObject[@"data"]);
        } else {
            failure(responseObject[@"status"],responseObject[@"message"],nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
        NSString *errorMessage = [NSString stringWithFormat:@"%@",error.localizedDescription];
        failure(errorCode,errorMessage,nil);
    }];
    
}

- (void)postJsonWithURLPath:(NSString *)URLPath
            parameters:(nullable id)parameters
       businessSuccess:(YWXDemoNetManagerCompletionBlock)success
               failure:(YWXDemoNetManagerCompletionBlock)failure {
    NSString *urlString = [NSString stringWithFormat:@"%@%@",self.urlHost,URLPath];
    self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.sessionManager POST:urlString parameters:parameters headers:[self commonHeaders] progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"0"]) {
            success(@"0",@"success",responseObject[@"data"]);
        } else {
            failure(responseObject[@"status"],responseObject[@"message"],nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
        NSString *errorMessage = [NSString stringWithFormat:@"%@",error.localizedDescription];
        failure(errorCode,errorMessage,nil);
    }];
    
}


-(NSDictionary<NSString *, NSString *> *)commonHeaders {
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
//    [headerDic setValue:[YWXDeviceUtils deviceModelName] forKey:YWX_BJCA_Header_phoneModel]; // iPhone 7
//    [headerDic setValue:[YWXDeviceUtils getSDKVersion] forKey:YWX_BJCA_Header_version]; // 1.0.0
//    [headerDic setValue:[YWXDeviceUtils getDeviceOSVersion] forKey:YWX_BJCA_Header_phoneOSVersion]; // 系统版本号 iOS 13
//    [headerDic setValue:[YWXDeviceUtils getDeviceTypeForYWX] forKey:YWX_BJCA_Header_deviceType]; // 医网信后台处理iOS类型  11
//    [headerDic setValue:[YWXDeviceUtils getDeviceUUID] forKey:YWX_BJCA_Header_deviceId]; // 设备的UUID
//    [headerDic setValue:[YWXDeviceUtils getDeviceBrand] forKey:YWX_BJCA_Header_phoneBrand]; // 设备品牌 iphone
//    [headerDic setValue:self.clientId forKey:YWX_BJCA_Header_clientId]; // 厂商id
//    [headerDic setValue:[YWXBjcaSignNetManager getTimeStamp] forKey:YWX_BJCA_Header_timeStamp]; // 当前请求毫秒时间戳
//    [headerDic setValue:[YWXBjcaSignNetManager parameterSign] forKey:YWX_BJCA_Header_sign]; // 参数签名
////    [headerDic setValue:userID forHTTPHeaderField:YWX_BJCA_Header_];//用户id
////#TODO - SSSS
    return [headerDic copy];
}

@end
