//
//  YWXSignDataBaseController.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/4/6.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import "YWXSignDataBaseController.h"
#import "YWXDemoNetManager.h"
#import "YWXSignRandomInfo.h"

#import "Masonry.h"

@interface YWXSignDataBaseController ()

@end

@implementation YWXSignDataBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    if (self.clientId) {
        self.clientIdTextField.text = self.clientId;
    }
    if ([self.clientId isEqualToString:@"2015112716143758"]) {
        self.secretIdTextField.text = @"111111";
    }
}

/// 获取token
/// @param success 成功
- (void)getClientToken:(void(^)(NSString * accessToken))success {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:self.clientIdTextField.text forKey:@"clientId"];
    [dic setObject:self.secretIdTextField.text forKey:@"appSecret"];
    [[YWXDemoNetManager sharedManager] getWithURLPath:@"/device/v3/server/oauth/getAccessToken" parameters:dic businessSuccess:^(NSString * _Nonnull status, NSString * _Nonnull message, id  _Nullable info) {
        NSString *accessToken = info[@"accessToken"];
        success(accessToken);
    } failure:^(NSString * _Nonnull status, NSString * _Nonnull message, id  _Nullable info) {
        NSLog(@"status:%@ message:%@",status,message);
    }];
    
}

- (void)synSendData:(NSString *)accessToken
           clientId:(NSString *)clientId
             openId:(NSString *)openId
            version:(NSString *)version
              isPdf:(BOOL)isPdf
            success:(void(^)(NSString *uniqueId, NSString *authSignQRCode))success
               fail:(void(^)(NSString * errorMessage))fail {
    
    NSDictionary *parameters = [YWXSignRandomInfo getRandomRecipeDic:accessToken
                                                              openId:openId
                                                            clientId:clientId
                                                               isPdf:isPdf];
    NSString *urlPath = [NSString stringWithFormat:@"/am/%@/recipe/syn",version];
    [[YWXDemoNetManager sharedManager] postJsonWithURLPath:urlPath
                                                parameters:parameters
                                           businessSuccess:^(NSString * _Nonnull status, NSString * _Nonnull message, id  _Nullable info) {
        NSString *uniqueId = info[@"uniqueId"];
        NSString *authSignQRCode = info[@"authSignQRCode"];
        success(uniqueId,authSignQRCode);
    } failure:^(NSString * _Nonnull status, NSString * _Nonnull message, id  _Nullable info) {
        NSLog(@"status:%@ message:%@",status,message);
    }];
}


- (UIImage *)ywx_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //开启图片上下文
    UIGraphicsBeginImageContext(rect.size);
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置颜色
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //设置rect
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //上下文使用完毕,关闭上下文
    UIGraphicsEndImageContext();
    //返回image
    return image;
}


- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.clientIdLabel];
    [self.contentView addSubview:self.clientIdTextField];
    [self.contentView addSubview:self.secretIdLabel];
    [self.contentView addSubview:self.secretIdTextField];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.equalTo(self.view);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.bottom.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    [self.clientIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_top).offset(20);
        make.leading.mas_equalTo(self.scrollView.mas_leading).offset(20);
        make.width.offset(100);
        make.height.offset(30);
    }];
    [self.clientIdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.clientIdLabel.mas_centerY);
        make.leading.mas_equalTo(self.clientIdLabel.mas_trailing).offset(10);
        make.trailing.mas_equalTo(self.scrollView.mas_trailing).offset(-10);
        make.height.offset(30);
    }];
    [self.secretIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.clientIdLabel.mas_bottom).offset(20);
        make.leading.mas_equalTo(self.scrollView.mas_leading).offset(20);
        make.width.offset(100);
        make.height.offset(30);
    }];
    [self.secretIdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.secretIdLabel.mas_centerY);
        make.leading.mas_equalTo(self.secretIdLabel.mas_trailing).offset(10);
        make.trailing.mas_equalTo(self.scrollView.mas_trailing).offset(-10);
        make.height.offset(30);
    }];

}


/// 当前的ClientId
- (NSString *)currentClientId {
    return self.clientIdTextField.text;
}

- (UIView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIView alloc] init];
    }
    return _scrollView;
}

-(UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UILabel *)clientIdLabel {
    if (_clientIdLabel == nil) {
        _clientIdLabel = [[UILabel alloc] init];
        _clientIdLabel.textColor = [UIColor blackColor];
        _clientIdLabel.text = @"clientId:";
    }
    return _clientIdLabel;
}

- (UITextField *)clientIdTextField {
    if (_clientIdTextField == nil) {
        _clientIdTextField = [[UITextField alloc]init];
        _clientIdTextField.borderStyle = UITextBorderStyleRoundedRect;
        _clientIdTextField.placeholder = @"请输入厂商clientId";
    }
    return _clientIdTextField;
}

- (UILabel *)secretIdLabel {
    if (_secretIdLabel == nil) {
        _secretIdLabel = [[UILabel alloc] init];
        _secretIdLabel.textColor = [UIColor blackColor];
        _secretIdLabel.text = @"secretId:";
    }
    return _secretIdLabel;
}

- (UITextField *)secretIdTextField {
    if (_secretIdTextField == nil) {
        _secretIdTextField = [[UITextField alloc]init];
        _secretIdTextField.borderStyle = UITextBorderStyleRoundedRect;
        _secretIdTextField.placeholder = @"请输入厂商secretId";
        
    }
    return _secretIdTextField;
}


@end
