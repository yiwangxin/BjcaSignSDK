//
//  YWXBjcaSignManager.h
//  BjcaSignSDK
//
//  Created by szyx on 2021/3/26.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YWXSignSDK/YWXSignSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWXBjcaSignManager : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/// 单例对象。
+ (instancetype)sharedManager;

#pragma mark - 初始化

/// SDK 初始化工作
/// @param clientId 厂商id
/// @param environment 环境枚举
- (void)startWithClientId:(NSString *)clientId
              environment:(YWXEnvironment)environment;

/// 设置UI页面的导航栏字体颜色和背景颜色
/// @param navigationBarTintColor 字体颜色
/// @param navigationBarBackgroundColor 背景颜色
- (void)setupUIForNavigationBarTintColor:(UIColor *)navigationBarTintColor
            navigationBarBackgroundColor:(UIColor *)navigationBarBackgroundColor;

#pragma mark - 证书相关

/// 本地证书是否存在。
@property (nonatomic, readonly, assign) BOOL existsCert;

/// 下载证书
/// @param phone 手机号
/// @param completion 回调
- (void)certDownWithPhone:(NSString *)phone
               completion:(nullable YWXCompletion)completion;

/// 更新证书
/// @param completion 回调
- (void)certUpdateWithCompletion:(nullable YWXCompletion)completion;

/// 重置证书
/// @param completion 回调
- (void)certResetPinWithCompletion:(nullable YWXCompletion)completion;

/// 下载证书
/// @param phone 手机号
/// @param firmId 子厂商id
/// @param completion 回调
- (void)certDownWithPhone:(NSString *)phone
                   firmId:(nullable NSString *)firmId
               completion:(nullable YWXCompletion)completion;

/// 更新证书
/// @param firmId 子厂商id
/// @param completion 回调
- (void)certUpdateWithFirmId:(nullable NSString *)firmId
                  completion:(nullable YWXCompletion)completion;

/// 重置证书
/// @param firmId 子厂商id
/// @param completion 回调
- (void)certResetPinWithFirmId:(nullable NSString *)firmId
                    completion:(nullable YWXCompletion)completion;

/// 打开证书详情
/// @param completion 回调
- (void)showCertDetailWithCompletion:(nullable YWXCompletion)completion;

/// 移除本地证书。
- (BOOL)clearCert;

/// 获取用户信息。
- (void)requestUserInfoWithCompletion:(nullable YWXCompletion)completion;

#pragma mark - 签章相关

/// 签章图片的 base64 字符串，如果签章不存在则为 nil。(医网信APP专用)
@property (nullable, nonatomic, readonly, copy) NSString *signatureBase64EncodedString;

/// 签章配置
/// @param completion 回调
- (void)drawStampWithCompletion:(nullable YWXCompletion)completion;

/// 批量签章配置
/// @param firmIds 子厂商列表
/// @param completion 回调
- (void)drawStampWithFirmIds:(nullable NSArray<NSString *> *)firmIds
                  completion:(nullable YWXCompletion)completion;

#pragma mark - 签名相关

/// 普通签名接口
/// @param uniqueIdList 签名数据
/// @param completion 回调
- (void)signWithUniqueIdList:(NSArray<NSString *> *)uniqueIdList
                  completion:(nullable YWXCompletion)completion;

/// 批量签名。(医网信APP专用)
/// @param uniqueIdList 签名数据的uniqueID数组
/// @param firmId 对应子厂商id
/// @param completion 回调
- (void)signWithFirmId:(NSString *)firmId
          uniqueIdList:(NSArray<NSString *> *)uniqueIdList
            completion:(nullable YWXCompletion)completion;

/// 协同签名（医网信APP专用）
/// @param uniqueIdList 签名数据的uniqueID数组
/// @param completion 回调
- (void)teamSignWithUniqueIdList:(NSArray<NSString *> *)uniqueIdList
                      completion:(nullable YWXCompletion)completion;

#pragma mark - 二维码

/// 对二维码信息进行识别处理
/// @param qrString 二维码字符串信息
/// @param completion 回调
- (void)qrDisposeWithString:(NSString *)qrString
                 completion:(nullable YWXCompletion)completion;

#pragma mark - 自动签

/// 开启自动签名
/// @param sysTag 开启自动签名的系统标识名（需和服务端保持一致）
/// @param completion 回调
- (void)signForStartSignAutoWithSysTag:(NSString *)sysTag
                            completion:(nullable YWXCompletion)completion;

/// 关闭自动签名
/// @param sysTag 开启自动签名的系统标识名（需和服务端保持一致）
/// @param completion 回调
- (void)stopSignAutoWithSysTag:(NSString *)sysTag
                    completion:(nullable YWXCompletion)completion;


/// 开启自动签名(医网信APP专用)
/// @param firmId 子厂商id
/// @param sysTag 开启自动签名的系统标识名（需和服务端保持一致）
/// @param completion 回调
- (void)signForStartSignAutoWithFirmId:(NSString *)firmId
                                sysTag:(NSString *)sysTag
                            completion:(nullable YWXCompletion)completion;

/// 关闭自动签名
/// @param firmId 子厂商id
/// @param sysTag sysTag
/// @param completion 回调
- (void)stopSignAutoWithFirmId:(NSString *)firmId
                        sysTag:(NSString *)sysTag
                    completion:(nullable YWXCompletion)completion;

/// 获取自动签名信息
/// @param completion 回调
- (void)signAutoInfoWithCompletion:(nullable YWXCompletion)completion;

#pragma mark - 免密

/// 开启免密签名
/// @param days 单位天（1-60）
/// @param completion 回调
- (void)keepPinWithDays:(NSInteger)days
             completion:(nullable YWXCompletion)completion;

/// 关闭免密签名。
- (void)clearPin;

/// 当前是否处于免密状态
@property (nonatomic, readonly, assign) BOOL isPinExempt;

#pragma mark - 生物识别设置

/// 开启生物识别
/// @param completion 回调
- (void)startBiometricAuthenticationForSignWithCompletion:(nullable YWXCompletion)completion;

/// 关闭生物识别
/// @param completion 回调
- (void)stopBiometricAuthenticationForSignWithCompletion:(nullable YWXCompletion)completion;

/// 签名的  Touch ID / Face ID 是否开启。
@property (nonatomic, readonly, assign) BOOL isBiometricAuthenticationEnabled;

#pragma mark - 授权签名

/// 开启授权签名
/// @param firmId 子厂商id
/// @param grantedUserId 指定授权用户的id
/// @param hours 单位小时
/// @param completion 回调
- (void)grantSignAuthorizationToFirmId:(NSString *)firmId
                         grantedUserId:(NSString *)grantedUserId
                                 hours:(NSInteger)hours
                            completion:(nullable YWXCompletion)completion;

/// 关闭授权签名
/// @param firmId 子厂商id
/// @param grantUniqueId 授权唯一标识id
/// @param completion 回调
- (void)stopGrantSignAuthorizationToFirmId:(NSString *)firmId
                             grantUniqueId:(NSString *)grantUniqueId
                                completion:(nullable YWXCompletion)completion;

#pragma mark - 配置

/// SDK 当前的开发环境。
@property (nonatomic, readonly, assign) YWXEnvironment currentEnvironment;

/// SDK 当前开发环境的 URL 地址。
@property (nonatomic, readonly, copy) NSString *currentEnvironmentURL;

/// 当前版本号。
@property (nonatomic, readonly, copy) NSString *versionString;

/// 当前显示的语言。
@property (nonatomic, readonly, copy) NSString *currentLanguage;

/// 用户的 openID，证书不存在时为 nil。
@property (nullable, nonatomic, readonly, copy) NSString *openId;

/// 修改界面语言(医网信APP专用)
/// @param language 语言字符串 zh-Hans中文en英文
- (void)changePreferredLanguage:(NSString *)language;

/// 展示键盘输入页面
/// @param completion 键盘完成回调
- (void)showPinWindowWithCompletion:(nullable YWXCompletion)completion;

@end

NS_ASSUME_NONNULL_END
