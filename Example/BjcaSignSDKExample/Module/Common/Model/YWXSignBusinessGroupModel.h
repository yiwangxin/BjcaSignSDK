//
//  YWXSignBusinessGroupModel.h
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/25.
//

#import <Foundation/Foundation.h>
//#import "YWXSignBusinessModel.h"
NS_ASSUME_NONNULL_BEGIN

//用户希望执行的业务
typedef NS_ENUM(NSInteger, YWXSignBusinessType) {
    // 证书下载
    TestBusinessTypeCertDown,
    // 证书更新
    TestBusinessTypeUpdate,
    // 证书密码重置
    TestBusinessTypeReset,
    // 修改签章
    TestBusinessTypeStamp,
    // 修改签章
    TestBusinessTypeClippingStamp,
    // 批量签名
    TestBusinessTypeSignList,
    // 二维码业务
    TestBusinessTypeQrCode,
    // 二维码演示业务
    TestBusinessTypeQrCodeShow,
    // 免密开启
    TestBusinessTypeFreePin,
    // 清除免密
    TestBusinessTypeCleanFreePin,
    // 用户信息
    TestBusinessTypeUserInfo,
    // 查看证书详情
    TestBusinessTypeCertDetail,
    // 开启指纹
    TestBusinessTypeFingerPin,
    // 关闭指纹
    TestBusinessTypeFingerPinClose,
    // 开启自动签名
    TestBusinessTypeSignForSignAuto,
    // 获取自动签名状态
    TestBusinessTypeSignAutoInfo,
    // 停止自动签名状态
    TestBusinessTypeStopSignAuto,
    // 开启授权签名
    TestBusinessTypeOpenGrantSign,
    // 关闭授权签名
    TestBusinessTypeCloseGrantSign,
    // 切换环境
    TestBusinessTypeChangeService,
    // 版本号
    TestBusinessTypeVersion,
    // 清除证书
    TestBusinessTypeCleanCert,
    // 中文语言
    TestBusinessTypeLanguageChinese,
    // 英文语言
    TestBusinessTypeLanguageEnglish,
    // 系统语言
    TestBusinessTypeLanguageSystem,
    // 证书存在
    TestBusinessTypeCertExist,
    
};


@interface YWXSignBusinessGroupModel : NSObject

@property (nonatomic, copy) NSString *titleString;

@property (nonatomic, copy) NSArray *businessModelArray;

@property (nonatomic, assign) BOOL isShow;

+(NSArray *)businessGroupModelArray;

@end

#pragma mark - YWXSignBusinessModel

@interface YWXSignBusinessModel : NSObject

@property (nonatomic, copy) NSString *titleString;

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, copy) NSString *inputText;

@property (nonatomic, assign) YWXSignBusinessType businessType;

@end

NS_ASSUME_NONNULL_END
