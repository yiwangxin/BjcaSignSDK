//
//  BjcaSignManager.h
//  BjcaSignSDK
//
//  Created by szyx on 2021/5/10.
//

#import <Foundation/Foundation.h>
#import <YWXBjcaSignSDK/YWXBjcaSignManager.h>
#import <BjcaSignSDK/BjcaPublicConst.h>
NS_ASSUME_NONNULL_BEGIN

@protocol BjcaSignDelegate <NSObject>
//相关代理协议
-(void)BjcaFinished:(NSDictionary*)backParam;

@end

@interface BjcaSignManager : NSObject

#pragma mark - 初始化相关
// 代理对象
@property (nonatomic,weak) id<BjcaSignDelegate> bjcaSignDelegate;

/**
 单例对象

 @return BjcaSignManager的实例化对象
 */
+(BjcaSignManager *)bjcaShareBjcaSignManager;

/// SDK 初始化工作（3.7.0新增方法）删除了+(void)bjcaSetServerURL:(BjcaServerType)serverType;
/// @param clientId 厂商id
/// @param environment 环境枚举
- (void)startWithClientId:(NSString *)clientId
              environment:(BjcaServerType)environment;

/// 设置UI页面的导航栏字体颜色和背景颜色（3.7.0新增方法）
/// @param navigationBarTintColor 字体颜色
/// @param navigationBarBackgroundColor 背景颜色
- (void)setupUIForNavigationBarTintColor:(UIColor *)navigationBarTintColor
            navigationBarBackgroundColor:(UIColor *)navigationBarBackgroundColor;

#pragma mark - 证书相关

/// 证书下载
/// @param clientId 厂商的clientId
/// @param phoneNum 下载证书的手机号
/// @param viewCtrl 当前页的ViewCtrl
-(void)bjcaCertDown:(NSString*)clientId
           phoneNum:(NSString*)phoneNum
        curViewCtrl:(UIViewController*)viewCtrl;

/// 证书更新
/// @param clientId 厂商的clientId
/// @param viewCtrl 当前页的ViewCtrl
-(void)bjcaCertUpdate:(NSString*)clientId
          curViewCtrl:(UIViewController*)viewCtrl;

/// 证书密码重置
/// @param clientId 厂商的clientId
/// @param viewCtrl 当前页的ViewCtrl
-(void)bjcaCertReset:(NSString*)clientId
         curViewCtrl:(UIViewController*)viewCtrl;

/// 是否存在证书 YES存在，NO不存在
+ (BOOL)bjcaExistsCert;


/// 移除本地证书
+ (void)bjcaRemoveCert;

/// 打开证书详情页
/// @param clientId 第三方对应的clientId
/// @param viewCtrl 当前活跃的ctrl
/// @param navColor 导航栏颜色，可为nil
/// @param fontColor 导航栏字体颜色，可为nil
- (void)bjcaCertDetail:(NSString *)clientId
           curViewCtrl:(UIViewController*)viewCtrl
              navColor:(UIColor * _Nullable)navColor
          navFontColor:(UIColor * _Nullable)fontColor;

/// 获取用户信息
/// @param clientId 第三方对应的clientId
- (void)bjcaUserInfo:(NSString *)clientId;

#pragma mark - 签章设置

/// 获取签章Base64图片 存在/base64，不存在/nil
+ (NSString *)bjcaStampPic;

/// 签章配置
/// @param clientId 厂商的clientId
/// @param viewCtrl 当前页的ViewCtrl
/// @param navColor 导航栏颜色，可为nil
/// @param fontColor 导航栏颜色，可为nil
-(void)bjcaSetStamp:(NSString*)clientId
        curViewCtrl:(UIViewController*)viewCtrl
           navColor:(UIColor * _Nullable)navColor
       navFontColor:(UIColor * _Nullable)fontColor;

/// 批量签章配置
/// @param clientId 厂商的clientId
/// @param firmIdList 子厂商的clientId集合
/// @param viewCtrl 当前页的ViewCtrl
/// @param navColor 导航栏颜色，可为nil
/// @param fontColor 导航栏颜色，可为nil
-(void)bjcaSetStamp:(NSString *)clientId
         firmIdList:(NSArray *)firmIdList
        curViewCtrl:(UIViewController*)viewCtrl
           navColor:(UIColor * _Nullable)navColor
       navFontColor:(UIColor * _Nullable)fontColor;

#pragma mark - 签名相关

/// 批量签名
/// @param uniqueIds 批量处方的uniqueId数组
/// @param clientId 第三方对应的clientId
/// @param viewCtrl 当前页的ViewCtrl
- (void)bjcaBatchSignList:(NSMutableArray *)uniqueIds
             userClientId:(NSString *)clientId
              curViewCtrl:(UIViewController*)viewCtrl;

/// 根据签名流水号签名(厂商不可用)
/// @param firmId 子厂商id
/// @param uniqueIds 批量处方的uniqueId数组
/// @param clientId 厂商id
/// @param viewCtrl 当前页的ViewCtrl
-(void)signWithFirmId:(NSString *)firmId
            uniqueIds:(NSMutableArray *)uniqueIds
         userClientId:(NSString *)clientId
          curViewCtrl:(UIViewController*)viewCtrl;

#pragma mark - 二维码

/// 二维码扫码字符串签名
/// @param qrString 二维码扫码解析得到的字符串
/// @param clientId 第三方对应的clientId
/// @param viewCtrl 当前页的ViewCtrl
- (void)bjcaQrSign:(NSString *)qrString
      userClientId:(NSString *)clientId
       curViewCtrl:(UIViewController*)viewCtrl;

#pragma mark - 自动签名

/// 请求开启自动签名
/// @param clientId 厂商的clientId
/// @param sysTag 服务端同步待签数据携带 sysTag，该条订单会 在服务端通过个人托管证书完成签名
/// @param viewCtrl 当前页的ViewCtrl
- (void)signForSignAuto:(NSString *)clientId
                 sysTag:(NSString*)sysTag
            curViewCtrl:(UIViewController*)viewCtrl;

/// 停止自动签名
/// @param clientId 厂商的clientId
/// @param sysTag 服务端同步待签数据携带 sysTag，该条订单会 在服务端通过个人托管证书完成签名
- (void)stopSignAuto:(NSString *)clientId  sysTag:(NSString*)sysTag;

/// 获取自动签名状态
/// @param clientId 厂商的clientId
- (void)signAutoInfo:(NSString *)clientId;

/// 请求开启自动签名(医网信APP专用)
/// @param firmId 子厂商id
/// @param clientId 厂商的clientId
/// @param sysTag 服务端同步待签数据携带 sysTag，该条订单会 在服务端通过个人托管证书完成签名
/// @param viewCtrl 当前页的ViewCtrl
-(void)signForSignAutoWithFirmId:(NSString *)firmId
                        clientId:(NSString *)clientId
                          sysTag:(NSString*)sysTag
                     curViewCtrl:(UIViewController*)viewCtrl;

/// 停止自动签名(医网信APP专用)
/// @param firmId 子厂商id
/// @param clientId 厂商的clientId
/// @param sysTag 服务端同步待签数据携带 sysTag，该条订单会 在服务端通过个人托管证书完成签名
- (void)stopSignAutoWithFirmId:(NSString *)firmId
                      clientId:(NSString *)clientId
                        sysTag:(NSString*)sysTag;

#pragma mark - 便捷签名配置

/// 获取当前指纹签名开关状态 YES 开启,NO 关闭
+ (BOOL)bjcaFingerState;

/// 开启生物识别签名Touch ID Face ID
/// @param viewCtrl 当前控制器
- (void)bjcaFingerSign:(UIViewController*)viewCtrl;

/// 关闭生物识别签名
/// @param viewCtrl 当前控制器
- (void)bjcaFingerSignClose:(UIViewController*)viewCtrl;

/// 当前是否处于免密状态 YES 免密, NO 非免密
+ (BOOL)bjcaExistsFreePin;

/// 开启免密签名
/// @param time 免密时间单位：天（1-60目前支持）
/// @param clientId 厂商id
/// @param viewCtrl 当前页面控制器
- (void)bjcaFreePinSign:(int)time
               clientId:(NSString *)clientId
            curViewCtrl:(UIViewController*)viewCtrl;

/// 清除免密状态
+ (void)bjcaRemovePin;

#pragma mark - 授权签名

/// 开启授权签名
/// @param clientId 厂商id
/// @param firmId 厂商id
/// @param grantedUserId 被授权医生用户id
/// @param timeOut 授权时间单位小时
- (void)startGrantSign:(NSString *)clientId
                firmId:(NSString*)firmId
         grantedUserId:(NSString *)grantedUserId
               timeOut:(int)timeOut
 currentViewController:(UIViewController*)currentViewController;

#pragma mark - 基础信息

/// 获取当前环境枚举
+ (BjcaServerType)bjcaServerType;

/// 获取当前环境地址 本接口仅用于demo，需要获取当前环境，请使用上面的获取枚举接口
+ (NSString*)bjcaAddress;

/// 获取当前版本号
+ (NSString *)bjcaVersion;

/// app显示的语言（目前仅支持中文zh和英文en除中文外其他显示en,传空字符串则根据系统语言）
+ (NSString *)bjcaAppLanguage;

/// 获取openId (若证书不存在则返回nil)
+ (NSString *)bjcaOpenId;

/// 设置app显示的语言
/// @param appLanguage app显示的语言（目前仅支持中文zh和英文en除中文外其他显示en,传空字符串则根据系统语言）
+ (void)bjcaSetAppLanguage:(NSString *)appLanguage;


@end

NS_ASSUME_NONNULL_END
