//
//  YWXDeviceUtils.h
//  YWXSignFoundation
//
//  Created by szyx on 2021/3/29.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWXDeviceUtils : NSObject


/// 获取当前设备的操作系统名称
+ (NSString *)getDeviceOSName;

/// 获取当前设备的品牌
+ (NSString *)getDeviceBrand;

/// 获取当前设备的对应到医网信的类型11
+ (NSString *)getDeviceTypeForYWX;

/// 获取当前SDK的版本号
+ (NSString *)getSDKVersion;

/// 获取当前设备的操作系统版本号
+ (NSString *)getDeviceOSVersion;

/// 获取设备UUID
+ (NSString*)getDeviceUUID;

// 获取设备型号然后手动转化为对应名称
+ (NSString *)deviceModelName;

@end

NS_ASSUME_NONNULL_END
