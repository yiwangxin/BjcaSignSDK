//
//  YWXBjcaSignSDKViewController.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/5/11.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import "YWXBjcaSignSDKViewController.h"
#import "YWXSignDataViewController.h"
#import "YWXQRCodeScanViewController.h"
#import "YWXCreatQRCodeController.h"
#import "YWXEnvironmentViewController.h"
#import "YWXUserInfoViewController.h"
#import <BjcaSignSDK/BjcaSignManager.h>

static NSString *KEnvironmentKeyName = @"serverType";
@interface YWXBjcaSignSDKViewController ()<BjcaSignDelegate>

@end

@implementation YWXBjcaSignSDKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BjcaSignManager.bjcaShareBjcaSignManager.bjcaSignDelegate = self;
    __weak typeof(self) weakSelf = self;
    [YWXEnvironmentViewController getCurrentEnviromentWithEnvironmentKeyName:KEnvironmentKeyName environmentChangeBlack:^(YWXDemoEnvironment currentEnvironment) {
        [weakSelf changeEnvironmentWith:currentEnvironment];
    }];
    
}

- (void)didSelectSignBusiness:(YWXSignBusinessModel *)signBusinessModel {
    
    switch (signBusinessModel.businessType) {
        case TestBusinessTypeCertDown:
            [self startCertDownLoad];
            break;
        case TestBusinessTypeUpdate:
            [self startUpdataCert];
            break;
        case TestBusinessTypeReset:
            [self startResetCert];
            break;
        case TestBusinessTypeCleanCert:
            [self cleanCert];
            break;
        case TestBusinessTypeUserInfo:
            [self showUserInfo];
            break;
        case TestBusinessTypeCertDetail:
            [self showCertDetail];
            break;
        case TestBusinessTypeStamp:
            [self setCertStampImage];
            break;
        case TestBusinessTypeSignList:
            [self showSignDataController];
            break;
        case TestBusinessTypeQrCode:
            [self showQRCodeScanViewController];
            break;
        case TestBusinessTypeQrCodeShow:
            [self showQRCodeCreatController];
            break;
        case TestBusinessTypeChangeService:
            [self showChangeServiceController];
            break;
        case TestBusinessTypeSignForSignAuto:
            [self openAutoSign:signBusinessModel.inputText];
            break;
        case TestBusinessTypeSignAutoInfo:
            [self getAutoSignInfo];
            break;
        case TestBusinessTypeStopSignAuto:
            [self quitAutoSign:signBusinessModel.inputText];
            break;
        
        case TestBusinessTypeFreePin:
            [self openFreePin:signBusinessModel.inputText];
            break;
        case TestBusinessTypeCleanFreePin:
            [self closeFreePin];
            break;
        case TestBusinessTypeFingerPin:
            [self openBiometricsStatus];
            break;
        case TestBusinessTypeFingerPinClose:
            [self closeBiometricsStatus];
            break;
        case TestBusinessTypeOpenGrantSign:
            [self grandSign];
            break;
        case TestBusinessTypeCloseGrantSign:
            [self closeGrandSign];
            break;
        
        case TestBusinessTypeLanguageChinese:
            [self changeLanguageToChinese];
            break;
        case TestBusinessTypeLanguageEnglish:
            [self changeLanguageToEnglish];
            break;
        case TestBusinessTypeLanguageSystem:
            [self changeLanguageToSystem];
            break;
        case TestBusinessTypeCertExist:
            [self checkIsExistCert];
            break;
        case TestBusinessTypeVersion:
            [self getSDKVersion];
            break;
        default:
            break;
    }
    
}

#pragma mark - SDK代理
- (void)BjcaFinished:(NSDictionary *)backParam{
    [self updateInfo];
    NSLog(@"返回结果\n%@",backParam);
    BjcaBusinessType business = [backParam[@"businessType"] integerValue];
    NSString *title = @"";
    switch (business) {
        case BjcaBusinessCertDown:{
            title = @"证书下载业务";
            break;
        }
        case BjcaBusinessCertUpdate: {
            title = @"证书更新业务";
            break;
        }
        case BjcaBusinessCertReset: {
            title = @"证书密码重置业务";
            break;
        }
        case BjcaBusinessStamp: {
            title = @"设置签章业务";
            break;
        }
        case BjcaBusinessSignList: {
            title = @"签名业务";
            break;
        }
        case BjcaBusinessQrCode: {
            title = @"二维码业务";
            break;
        }
        case BjcaBusinessUserInfo: {
            title = @"证书信息业务";
            break;
        }
        case BjcaBusinessFreePin: {
            title = @"免密签名业务";
            break;
        }
        case BjcaBusinessCertDetail: {
            title = @"证书详情业务";
            break;
        }
        case BjcaBusinessFingerPin: {
            title = @"指纹签名业务开启成功";
            break;
        }
        case BjcaBusinessFingerPinClose: {
            title = @"指纹关闭";
            break;
        }
        case BjcaSignForSignAuto: {
           title = @"开启自动签状态";
           break;
        }
        case BjcaSignAutoInfo: {
             title = @"获取自动签状态";
             break;
        }
        case BjcaStopSignAuto: {
             title = @"停止自动签状态";
             break;
        }
        case BjcaBusinessAutomationSign: {
            title = @"自动签";
            break;
        }
        case BjcaOpenGrantSign: {
            title = @"开启授权签";
            break;
        }
    }
    NSString *status = backParam[@"status"];
    NSString *message = backParam[@"message"];
    id data = backParam[@"data"];
    if (business == BjcaBusinessUserInfo && [status isEqualToString:@"0"]) {
        YWXUserInfoViewController *userInfoController = [[YWXUserInfoViewController alloc] init];
        userInfoController.openId = BjcaSignManager.bjcaOpenId;
        userInfoController.freePin = BjcaSignManager.bjcaExistsFreePin;
        userInfoController.userInfoDictionary = data;
        userInfoController.stampImageBase64 = BjcaSignManager.bjcaStampPic;
        [self.navigationController pushViewController:userInfoController animated:YES];
    }
    [self showAlertWith:title code:status message:message info:data];
}
#pragma mark - 证书下证

- (void)startCertDownLoad {
    [BjcaSignManager.bjcaShareBjcaSignManager bjcaCertDown:self.clientId
                                                  phoneNum:self.phoneNumber
                                               curViewCtrl:self];
}

- (void)startUpdataCert {
    [BjcaSignManager.bjcaShareBjcaSignManager bjcaCertUpdate:self.clientId
                                                 curViewCtrl:self];
}

- (void)startResetCert {
    [BjcaSignManager.bjcaShareBjcaSignManager bjcaCertReset:self.clientId
                                                curViewCtrl:self];
}


-(void)cleanCert {
    [BjcaSignManager bjcaRemoveCert];
    [self showAlertWith:@"清除证书" code:@"0" message:@"success" info:@{}];
    [self updateInfo];
}

#pragma mark - 签章设置

-(void)setCertStampImage {
    [BjcaSignManager.bjcaShareBjcaSignManager bjcaSetStamp:self.clientId
                                               curViewCtrl:self
                                                  navColor:UIColor.redColor
                                              navFontColor:UIColor.yellowColor];
}

#pragma mark - 签名

-(void)showSignDataController {
    YWXSignDataViewController *signDataController = [[YWXSignDataViewController alloc] init];
    signDataController.clientId = self.clientId;
    signDataController.openId = BjcaSignManager.bjcaOpenId;
    __weak typeof(self) weakSelf = self;
    signDataController.signButtonClickCallBack = ^(NSArray * uniqueIDs) {
        [BjcaSignManager.bjcaShareBjcaSignManager bjcaBatchSignList:[NSMutableArray arrayWithArray:uniqueIDs]
                                                       userClientId:self.clientId
                                                        curViewCtrl:weakSelf];
    };
    [self.navigationController pushViewController:signDataController animated:YES];
}

#pragma mark - 二维码
/// 进行二维码扫描
-(void)showQRCodeScanViewController {
    __weak typeof(self) weakSelf = self;
    [YWXQRCodeScanViewController showQRCodeScanWith:self scanCompletion:^(NSString * _Nonnull result) {
        NSLog(@"qrcode string:%@",result);
        /// sdk 二维码页面
        [BjcaSignManager.bjcaShareBjcaSignManager bjcaQrSign:result
                                                userClientId:weakSelf.clientId
                                                 curViewCtrl:weakSelf];
    }];
    
}

/// 跳转到二维码创建页面
-(void)showQRCodeCreatController {
    YWXCreatQRCodeController *controller = [[YWXCreatQRCodeController alloc] init];
    controller.clientId = self.clientId;
    controller.openIdTextField.text = BjcaSignManager.bjcaOpenId;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - 自动签
/// 开启自动签
-(void)openAutoSign:(NSString *)sysTag {
    __weak typeof(self) weakSelf = self;
    [BjcaSignManager.bjcaShareBjcaSignManager signForSignAuto:self.clientId
                                                       sysTag:sysTag
                                                  curViewCtrl:weakSelf];
}


/// 获取自动签信息
-(void)getAutoSignInfo {
    [BjcaSignManager.bjcaShareBjcaSignManager signAutoInfo:self.clientId];
}

/// 退出自动签
-(void)quitAutoSign:(NSString *)sysTag {
    [BjcaSignManager.bjcaShareBjcaSignManager stopSignAuto:self.clientId
                                                    sysTag:sysTag];
}

#pragma mark - 签名配置
/// 开启免密
-(void)openFreePin:(NSString *)days {
    __weak typeof(self) weakSelf = self;
    int day = [days intValue];
    [BjcaSignManager.bjcaShareBjcaSignManager bjcaFreePinSign:day
                                                     clientId:self.clientId
                                                  curViewCtrl:weakSelf];
}

/// 关闭免密
-(void)closeFreePin {
    [BjcaSignManager bjcaRemovePin];
}

/// 开启生物识别
-(void)openBiometricsStatus {
    __weak typeof(self) weakSelf = self;
    [BjcaSignManager.bjcaShareBjcaSignManager bjcaFingerSign:weakSelf];
}

-(void)closeBiometricsStatus {
    __weak typeof(self) weakSelf = self;
    [BjcaSignManager.bjcaShareBjcaSignManager bjcaFingerSignClose:weakSelf];
}

#pragma mark - 用户信息
/// 获取用户信息
-(void)showUserInfo {
    [BjcaSignManager.bjcaShareBjcaSignManager bjcaUserInfo:self.clientId];
}

-(void)showCertDetail {
    __weak typeof(self) weakSelf = self;
    [BjcaSignManager.bjcaShareBjcaSignManager bjcaCertDetail:self.clientId
                                                 curViewCtrl:weakSelf
                                                    navColor:UIColor.redColor
                                                navFontColor:UIColor.yellowColor];
}

-(void)grandSign {

}

-(void)closeGrandSign {

}

- (void)changeLanguageToChinese {
    [BjcaSignManager bjcaSetAppLanguage:@"zh"];
    [self updateInfo];
    [self showAlertWith:@"切换SDK显示语言为中文" code:@"0" message:@"success" info:@{}];
}

- (void)changeLanguageToEnglish {
    [BjcaSignManager bjcaSetAppLanguage:@"en"];
    [self updateInfo];
    [self showAlertWith:@"切换SDK显示语言为英文" code:@"0" message:@"success" info:@{}];
}

- (void)changeLanguageToSystem {
    [BjcaSignManager bjcaSetAppLanguage:@""];
    [self updateInfo];
    [self showAlertWith:@"切换SDK显示语言为系统语言" code:@"0" message:@"success" info:@{}];
}

- (void)getSDKVersion {
    NSString *versionString = [BjcaSignManager bjcaVersion];
    [self showAlertWith:@"当前SDK版本" code:@"0" message:versionString info:@{}];
}

- (void)checkIsExistCert {
    BOOL isCertificateExist = [BjcaSignManager bjcaExistsCert];
    NSString *message = [NSString stringWithFormat:@"证书：%@",isCertificateExist == YES ? @"存在" : @"不存在"];
    [self showAlertWith:@"是否存在证书" code:@"0" message:message info:@{}];
}

-(void)showChangeServiceController {
    YWXEnvironmentViewController *envControler = [[YWXEnvironmentViewController alloc] init];
    envControler.environmentKeyName = KEnvironmentKeyName;
    __weak typeof(self) weakSelf = self;
    envControler.environmentChangeBlack = ^(YWXDemoEnvironment currentEnvironment) {
        [weakSelf changeEnvironmentWith:currentEnvironment];
    };
    [self.navigationController pushViewController:envControler animated:YES];
}

- (void)updateInfo {
    NSString *version = BjcaSignManager.bjcaVersion;
    BjcaServerType environment = BjcaSignManager.bjcaServerType;
    BOOL isExistCert = BjcaSignManager.bjcaExistsCert;
    NSString *sdkLanguage = BjcaSignManager.bjcaAppLanguage;
    [self updateFooterInfoWithVersion:version
                          serviceType:environment
                          isExistCert:isExistCert
                          sdkLanguage:sdkLanguage];
}

- (void)changeEnvironmentWith:(YWXDemoEnvironment)currentEnvironment {
    BjcaServerType environment;
    switch (currentEnvironment) {
        case YWXDemoEnvironmentProduction:
            environment = BjcaPublic;
            break;
        case YWXDemoEnvironmentAcceptance:
            environment = BjcaIntegrate;
            break;
        case YWXDemoEnvironmentTesting:
            environment = BjcaTest;
            break;
        case YWXDemoEnvironmentDevelopment:
            environment = BjcaDev;
            break;
    }
    [BjcaSignManager.bjcaShareBjcaSignManager startWithClientId:self.clientInfoView.clientId
                                                    environment:environment];
    YWXDemoNetManager.sharedManager.environment = currentEnvironment;
    [self updateInfo];
}

@end
