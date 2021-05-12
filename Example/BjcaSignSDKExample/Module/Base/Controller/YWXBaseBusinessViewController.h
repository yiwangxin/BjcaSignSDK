//
//  YWXBaseBusinessViewController.h
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/25.
//

#import <UIKit/UIKit.h>
#import "YWXClientIdInfoView.h"
#import "YWXSignBusinessFooterView.h"
#import "YWXSignBusinessGroupModel.h"
#import "YWXBaseViewController.h"
#import "YWXDemoNetManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface YWXBaseBusinessViewController : YWXBaseViewController

@property (nonatomic, strong) YWXClientIdInfoView *clientInfoView;

@property (nonatomic, strong) YWXSignBusinessFooterView *footerView;

@property (nonatomic,strong) NSArray *businessGroupModelArray;

@property (nonatomic,strong) NSString *clientId;

@property (nonatomic,strong) NSString *phoneNumber;

-(void)initData;

-(void)didSelectSignBusiness:(YWXSignBusinessModel *)signBusinessModel;

-(void)updateFooterInfoWithVersion:(NSString *)version
                       serviceType:(NSInteger)serviceType
                       isExistCert:(BOOL)isExistCert
                       sdkLanguage:(NSString *)sdkLanguage;

@end

NS_ASSUME_NONNULL_END
