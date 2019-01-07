//
//  BjcaSignManager.h
//  BjcaSignSDK
//
//  Created by 吴兴 on 2018/11/19.
//  Copyright © 2018 szyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BjcaPublicConst.h"

NS_ASSUME_NONNULL_BEGIN
@protocol BjcaSignDelegate <NSObject>
//相关代理协议
-(void)BjcaFinished:(NSDictionary*)backParam;

@end

@interface BjcaSignManager : NSObject

#pragma mark - 初始化相关
//回调对象
@property (nonatomic,weak) id<BjcaSignDelegate> bjcaSignDelegate;


/**
 初始化

 @return BjcaSignManager的实例化对象
 */
+(BjcaSignManager *)bjcaShareBjcaSignManager;

/**
 设置环境

 @param serverType 环境枚举
 */
+(void)bjcaSetServerURL:(BjcaServerType)serverType;

#pragma mark - 证书相关
/**
 证书下载

 @param clientId 厂商的clientId
 @param phoneNum 下载证书的手机号
 @param viewCtrl 当前页的ViewCtrl
 */
-(void)bjcaCertDown:(NSString*)clientId phoneNum:(NSString*)phoneNum curViewCtrl:(UIViewController*)viewCtrl;

/**
 证书更新
 
 @param clientId 厂商的clientId
 @param viewCtrl 当前页的ViewCtrl
 */
-(void)bjcaCertUpdate:(NSString*)clientId curViewCtrl:(UIViewController*)viewCtrl;

/**
 证书密码重置
 
 @param clientId 厂商的clientId
 @param viewCtrl 当前页的ViewCtrl
 */
-(void)bjcaCertReset:(NSString*)clientId curViewCtrl:(UIViewController*)viewCtrl;

/**
 签章配置

 @param clientId 厂商的clientId
 @param viewCtrl 当前页的ViewCtrl
 @param navColor 导航栏颜色，可为nil
 @param fontColor 导航栏颜色，可为nil
 */
-(void)bjcaSetStamp:(NSString*)clientId curViewCtrl:(UIViewController*)viewCtrl navColor:(UIColor * _Nullable)navColor navFontColor:(UIColor * _Nullable)fontColor;

#pragma mark - 签名相关


/**
 批量签名

 @param uniqueIds 批量处方的uniqueId数组
 @param clientId 第三方对应的clientId
 @param viewCtrl 当前页的ViewCtrl
 */
- (void)bjcaBatchSignList:(NSMutableArray *)uniqueIds userClientId:(NSString *)clientId curViewCtrl:(UIViewController*)viewCtrl;


/**
 二维码扫码字符串签名

 @param qrString 二维码扫码解析得到的字符串
 @param clientId 第三方对应的clientId
 @param viewCtrl 当前页的ViewCtrl
 */
- (void)bjcaQrSign:(NSString *)qrString userClientId:(NSString *)clientId curViewCtrl:(UIViewController*)viewCtrl;


/**
 开启免密签名

 @param time 免密时间
 */
- (void)bjcaFreePinSign:(int)time clientId:(NSString *)clientId curViewCtrl:(UIViewController*)viewCtrl;

#pragma mark 用户信息相关
/**
 获取用户信息

 @param clientId 第三方对应的clientId
 */
- (void)bjcaUserInfo:(NSString *)clientId;



/**
  打开证书详情页

 @param clientId 第三方对应的clientId
 @param viewCtrl 当前活跃的ctrl
 @param navColor 导航栏颜色，可为nil
 @param fontColor 导航栏字体颜色，可为nil
 */
- (void)bjcaCertDetail:(NSString *)clientId curViewCtrl:(UIViewController*)viewCtrl navColor:(UIColor * _Nullable)navColor navFontColor:(UIColor * _Nullable)fontColor;
#pragma mark - 工具类

/**
 获取当前环境地址

 @return 地址
 @note  本接口仅用于demo，需要获取当前环境，请使用下面的获取枚举接口
 */
+ (NSString*)bjcaAddress;

/**
 获取当前环境枚举

 @return 环境枚举
 */
+ (BjcaServerType)bjcaServerType;

/**
 是否存在证书

 @return BOOL型，YES存在，NO不存在
 */
+ (BOOL)bjcaExistsCert;


/**
 获取签章Base64

 @return 存在/base64，不存在/nil
 */
+ (NSString *)bjcaStampPic;


/**
 获取openId

 @return openId
 @note 若证书不存在则返回nil
 */
+ (NSString *)bjcaOpenId;


/**
 获取当前版本号

 @return version
 */
+ (NSString *)bjcaVersion;


/**
 移除本地证书
 */
+ (void)bjcaRemoveCert;


/**
 当前是否处于免密状态

 @return BOOL YES，免密/NO，非免密
 
 */
+ (BOOL)bjcaExistsFreePin;


/**
 清除免密状态
 */
+ (void)bjcaRemovePin;
@end

NS_ASSUME_NONNULL_END
