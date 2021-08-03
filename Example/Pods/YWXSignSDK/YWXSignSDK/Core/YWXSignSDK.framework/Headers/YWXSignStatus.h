//
//  YWXSignStatus.h
//  YWXSignSDK
//
//  Created by Weipeng Qi on 2021/3/23.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// SDK 开发环境。
typedef NS_ENUM(NSUInteger, YWXEnvironment) {
    /// 生产环境
    YWXEnvironmentPublic,
    /// 集成环境
    YWXEnvironmentTest,
    /// 测试环境
    YWXEnvironmentBeta,
    /// 开发环境
    YWXEnvironmentDev,
};

/// 状态码。
typedef NSString *YWXSignStatusCode NS_EXTENSIBLE_STRING_ENUM;
typedef YWXSignStatusCode YWXSignResponseCode;
typedef void(^YWXCompletion)(YWXSignStatusCode status, NSString *message, id _Nullable data);

/// 成功
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeSuccess; // 0
/// 证书不存在
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeCertificateDoesNotExist; // 1001
/// 签章不存在
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeSignatureDoesNotExist; // 1002
/// 参数为空，请检查参数（检查 clientID 是否为空）
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeParameterNull; // 1003
/// 缺少必要的权限（读取设备信息）
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeInsufficientPermissions; // 1004
/// 超过批量签名上限，批量签名上限为100条
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeSignDataCountError; // 1006
/// 证书未过期，无需更新
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeCertificateIsNotExpired; // 1007
/// 免密保存时间不合法（免密时间应为1-60天，请检查后重试）
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeFreePinDayIllegal; // 1008
/// 手机未开启生物识别功能，请检查设置后重试
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeBiometricNotEnabled; // 1010
/// ⼿机号格式不正确，请检查后重试
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeInvalidPhoneNumberFormat; // 1009
/// 重置密码成功
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeResetPasswordSuccess; // 1013
/// 您不能操作其他用户的数据
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeCantSignOtherUserData; // 1015
/// 网络异常
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeNetworkError; // 2001
/// 当前二维码业务医网信无法处理
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeQRCodeError; // @"2002";
/// ⽤户取消操作
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeCancel; // 3000
/// 连续验证识别错误，识别功能被锁定
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeBiometricLockoutError; // 0x14100402
/// 用户Touch ID验证失败
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeTouchIDVerifyError; //0x14100403
/// 用户Face ID验证失败
FOUNDATION_EXPORT YWXSignStatusCode const YWXSignStatusCodeFaceIDVerifyError;  //0x14100404
/// 手机号格式不正确
FOUNDATION_EXPORT YWXSignResponseCode const YWXSignResponseCodeInvalidPhoneNumberFormat; // 017x001
/// 账号不存在，请检查!
FOUNDATION_EXPORT YWXSignResponseCode const YWXSignResponseCodeUserDoesNotExist; // 017x003


NS_ASSUME_NONNULL_END
