//
//  YWXSignBusinessGroupModel.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/25.
//

#import "YWXSignBusinessGroupModel.h"

@implementation YWXSignBusinessGroupModel

- (instancetype)initWithTitle:(NSString *)title businessTypeArray:(NSArray *)businessTypeArray
{
    self = [super init];
    if (self) {
        self.titleString = title;
        NSMutableArray *modelArray = [NSMutableArray array];
        for (int i = 0; i < businessTypeArray.count; i++) {
            NSNumber *type = businessTypeArray[i];
            YWXSignBusinessModel *model = [self getBusinessModelWithBusinessType:type];
            [modelArray addObject:model];
        }
        self.businessModelArray = modelArray;
    }
    return self;
}

+(NSArray *)businessGroupModelArray {
    
    NSArray *certBusinessArray = @[@(TestBusinessTypeCertDown),@(TestBusinessTypeUpdate),@(TestBusinessTypeReset),@(TestBusinessTypeStamp),@(TestBusinessTypeClippingStamp)];
    NSArray *signBusinessArray = @[@(TestBusinessTypeSignList),@(TestBusinessTypeQrCode),@(TestBusinessTypeQrCodeShow)];
    NSArray *autoSignBusinessArray = @[@(TestBusinessTypeSignForSignAuto),@(TestBusinessTypeSignAutoInfo),@(TestBusinessTypeStopSignAuto)];
    NSArray *infoBusinessArray = @[@(TestBusinessTypeUserInfo),@(TestBusinessTypeCertDetail)];
    NSArray *configBusinessArray = @[@(TestBusinessTypeFreePin),@(TestBusinessTypeCleanFreePin),@(TestBusinessTypeFingerPin),@(TestBusinessTypeFingerPinClose),@(TestBusinessTypeCleanCert),@(TestBusinessTypeVersion),@(TestBusinessTypeCertExist),@(TestBusinessTypeChangeService),@(TestBusinessTypeLanguageSystem),@(TestBusinessTypeLanguageChinese),@(TestBusinessTypeLanguageEnglish)];
    NSArray *GrantBusinessArray = @[@(TestBusinessTypeOpenGrantSign),@(TestBusinessTypeCloseGrantSign)];
    
    YWXSignBusinessGroupModel *certGroupModel = [[YWXSignBusinessGroupModel alloc] initWithTitle:@"下证" businessTypeArray:certBusinessArray];
    YWXSignBusinessGroupModel *signGroupModel = [[YWXSignBusinessGroupModel alloc] initWithTitle:@"签名" businessTypeArray:signBusinessArray];
    YWXSignBusinessGroupModel *autosignGroupModel = [[YWXSignBusinessGroupModel alloc] initWithTitle:@"自动签名" businessTypeArray:autoSignBusinessArray];
    YWXSignBusinessGroupModel *infoGroupModel = [[YWXSignBusinessGroupModel alloc] initWithTitle:@"证书信息" businessTypeArray:infoBusinessArray];
    YWXSignBusinessGroupModel *configGroupModel = [[YWXSignBusinessGroupModel alloc] initWithTitle:@"配置" businessTypeArray:configBusinessArray];
    YWXSignBusinessGroupModel *grantGroupModel = [[YWXSignBusinessGroupModel alloc] initWithTitle:@"授权签名" businessTypeArray:GrantBusinessArray];
    return @[certGroupModel,signGroupModel,autosignGroupModel,infoGroupModel,configGroupModel,grantGroupModel];
}

-(YWXSignBusinessModel *)getBusinessModelWithBusinessType:(NSNumber *)type {
    YWXSignBusinessType businessType = type.integerValue;
    NSString *title = @"";
    NSString *placeholder = @"";
    switch (businessType) {
        case TestBusinessTypeCertDown:
            title = @"下载证书";
            break;
        case TestBusinessTypeUpdate:
            title = @"证书更新";
            break;
        case TestBusinessTypeReset:
            title = @"证书密码重置";
            break;
        case TestBusinessTypeStamp:
            title = @"签章设置";
            break;
        case TestBusinessTypeClippingStamp:
            title = @"签章剪裁";
            break;
        case TestBusinessTypeSignList:
            title = @"批量签名";
            break;
        case TestBusinessTypeQrCode:
            title = @"二维码扫码";
            break;
        case TestBusinessTypeQrCodeShow:
            title = @"二维码创建";
            break;
        case TestBusinessTypeUserInfo:
            title = @"获取用户信息";
            break;
        case TestBusinessTypeCertDetail:
            title = @"证书详情页";
            break;
        case TestBusinessTypeFreePin:
            title = @"开启免密签名";
            placeholder = @"请输入免密天数1-60";
            break;
        case TestBusinessTypeCleanFreePin:
            title = @"清除免密状态";
            break;
        case TestBusinessTypeFingerPin:
            title = @"开启指纹签名";
            break;
        case TestBusinessTypeFingerPinClose:
            title = @"关闭指纹签名";
            break;
        case TestBusinessTypeSignForSignAuto:
            title = @"开启自动签";
            placeholder = @"请输入sysTag";
            break;
        case TestBusinessTypeSignAutoInfo:
            title = @"获取自动签信息";
            break;
        case TestBusinessTypeStopSignAuto:
            title = @"退出自动签";
            placeholder = @"请输入sysTag";
            break;
        case TestBusinessTypeOpenGrantSign:
            title = @"开启授权签名";
            break;
        case TestBusinessTypeCloseGrantSign:
            title = @"关闭授权签名";
            break;
        case TestBusinessTypeChangeService:
            title = @"切换环境";
            break;
        case TestBusinessTypeVersion:
            title = @"版本号";
            break;
        case TestBusinessTypeCleanCert:
            title = @"清除证书";
            break;
         case TestBusinessTypeLanguageChinese:
            title = @"中文语言";
            break;
        case TestBusinessTypeLanguageEnglish:
            title = @"英文语言";
            break;
        case TestBusinessTypeLanguageSystem:
            title = @"系统语言";
            break;
        case TestBusinessTypeCertExist:
            title = @"证书是否存在";
            break;
        default:
            break;
    }
    YWXSignBusinessModel *model = [[YWXSignBusinessModel alloc] init];
    model.businessType = businessType;
    model.titleString = title;
    model.placeholder = placeholder;
    return model;
}

@end


#pragma mark - YWXSignBusinessModel

@implementation YWXSignBusinessModel



@end
