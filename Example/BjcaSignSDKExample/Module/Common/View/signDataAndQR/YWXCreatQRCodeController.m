//
//  YWXCreatQRCodeController.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/4/6.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import "YWXCreatQRCodeController.h"
#import "YWXQRCodeViewController.h"
#import "YWXDemoNetManager.h"

#import "Masonry.h"

@interface YWXCreatQRCodeController ()

@property (nonatomic,strong) UILabel *openIdLabel;
//@property (nonatomic,strong) UITextField *openIdTextField;
@property (nonatomic,strong) UILabel *hisLabel;
@property (nonatomic,strong) UITextField *hisTextField;
@property (nonatomic,strong) UIButton *v2QrSignCodeButton;
@property (nonatomic,strong) UIButton *v3QrSignCodeButton;
@property (nonatomic,strong) UIButton *v2OauthLoginButton;
@property (nonatomic,strong) UIButton *v3OauthLoginButton;
@property (nonatomic,strong) UIButton *v2BindSignButton;
@property (nonatomic,strong) UIButton *v3BindSignButton;
@property (nonatomic,strong) UIButton *v2autoSignButton;
@property (nonatomic,strong) UIButton *v3autoSignButton;

@end

@implementation YWXCreatQRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)showQRCodeController:(NSString *)title
                  urlString:(NSString *)urlString
                base64Image:(NSString *)base64Image {
    YWXQRCodeViewController *qrCodeShowController = [[YWXQRCodeViewController alloc] init];
    qrCodeShowController.title = title;
    qrCodeShowController.urlString = urlString;
    qrCodeShowController.imageBase64 = base64Image;
    [self presentViewController:qrCodeShowController animated:YES completion:nil];
}


#pragma mark - 扫码签名
/// 获取v2签名二维码
-(void)getV2SignDataQrcode {
    [self getSignDataQRCode:@"v2"];
}

/// 获取v2签名二维码
-(void)getV3SignDataQrcode {
    [self getSignDataQRCode:@"v3"];
}

- (void)getSignDataQRCode:(NSString *)version {
    [self getClientToken:^(NSString * _Nonnull accessToken) {
        NSString *openId = [self openId];
        [self synSendData:accessToken clientId:self.currentClientId openId:openId version:version isPdf:NO success:^(NSString * _Nonnull uniqueId, NSString * _Nonnull authSignQRCode) {
            [self getSignQRCode:uniqueId version:version];
        } fail:^(NSString * _Nonnull errorMessage) {
            
        }];
    }];
}

/// 获取扫码签名二维码
-(void)getSignQRCode:(NSString *)uniqueId
             version:(NSString *)version {
    NSString *urlHeader = [YWXDemoNetManager sharedManager].urlHost;
    NSString *openId = [self openId];
    NSString *url = [NSString stringWithFormat:@"%@/am/%@/recipe/getSignQRCode?uniqueId=%@&openId=%@&clientId=%@&redirectUrl=%@",urlHeader,version,uniqueId,openId,self.currentClientId,@"http://www.baidu.com"];
    NSString *title = [NSString stringWithFormat:@"%@扫码签名二维码",version];
    [self showQRCodeController:title urlString:url base64Image:nil];
}

#pragma mark - 扫码oauth登录
/// 获取v2oauth登录二维码
-(void)getV2OauthLoginQrcode {
    [self getOauthLoginORcode:@"v2"];
}

/// 获取v3oauth登录二维码
-(void)getV3OauthLoginQrcode {
    [self getOauthLoginORcode:@"v3"];
}

-(void)getOauthLoginORcode:(NSString *)version {
    NSString *redirect_uri = @"http://www.baidu.com";
    NSString *urlpath = [NSString stringWithFormat:@"/am/%@/oauth2/cs/authorize?service=userService&response_type=code&redirect_uri=%@&client_id=%@",version,redirect_uri,self.currentClientId];
    [[YWXDemoNetManager sharedManager] getWithURLPath:urlpath parameters:@{} businessSuccess:^(NSString * _Nonnull status, NSString * _Nonnull message, id  _Nullable info) {
        NSString *imgBase64 = info[@"imgBase64"];
        NSString *title = [NSString stringWithFormat:@"%@oauth登录二维码",version];
        [self showQRCodeController:title urlString:nil base64Image:imgBase64];
    } failure:^(NSString * _Nonnull status, NSString * _Nonnull message, id  _Nullable info) {
        
    }];
}


#pragma mark - 扫码绑定签名数据
/// 获取v2绑定签名二维码
-(void)getV2BindSignQrcode {
    [self getBindSignORcode:@"v2"];
}

/// 获取v2绑定签名二维码
-(void)getV3BindSignQrcode {
    [self getBindSignORcode:@"v3"];
}

-(void)getBindSignORcode:(NSString *)version {
    [self getClientToken:^(NSString * _Nonnull accessToken) {
        [self synSendData:accessToken
                 clientId:self.currentClientId
                   openId:@""
                  version:version
                    isPdf:NO
                  success:^(NSString * _Nonnull uniqueId, NSString * _Nonnull authSignQRCode) {
            NSString *title = [NSString stringWithFormat:@"%@绑定签名二维码",version];
            [self showQRCodeController:title urlString:nil base64Image:authSignQRCode];
        } fail:^(NSString * _Nonnull errorMessage) {
            
        }];
        

    }];
}

#pragma mark - 自动签名

/// 获取v2自动签名二维码
-(void)getV2AutoSignQrcode {
    [self getAutoSignQrcode:@"v2"];
}

/// 获取v3自动签名二维码
-(void)getV3AutoSignQrcode {
    [self getAutoSignQrcode:@"v3"];
}

-(void)getAutoSignQrcode:(NSString *)version {
    [self getClientToken:^(NSString * _Nonnull accessToken) {
        [self requestToOpenAutoSign:version
                        accessToken:accessToken];
    }];
}


-(NSDictionary *)getAutoSignPostDic:(NSString *)accessToken
                             openId:(NSString *)openId
                             sysTag:(NSString *)sysTag {
    if (openId == nil) {
        return @{};
    }
    NSDictionary *headDic = @{
        @"clientSecret" : self.secretIdTextField.text,
        @"accessToken" : accessToken,
        @"clientId" : self.currentClientId,
    };
    NSDictionary *bodyDic = @{
        @"openId" : openId,
        @"sysTag" : sysTag,
    };
    NSDictionary *dic = @{
        @"head": headDic,
        @"body": bodyDic,
    };
    return dic;
}

-(void)requestToOpenAutoSign:(NSString *)version accessToken:(NSString *)accessToken {
    NSString *openId = [self openId];
    NSString *sysTag = self.hisTextField.text;
    NSDictionary *parameters = [self getAutoSignPostDic:accessToken openId:openId sysTag:sysTag];
    NSString *urlpath = [NSString stringWithFormat:@"/am/%@/selfSign/request",version];
    __weak typeof(self) weakSelf = self;
    [[YWXDemoNetManager sharedManager] postJsonWithURLPath:urlpath parameters:parameters businessSuccess:^(NSString * _Nonnull status, NSString * _Nonnull message, id  _Nullable info) {
        NSString *imgBase64;
        if ([version isEqualToString:@"v2"]) {
            imgBase64 = info;
        } else {
            imgBase64 = info[@"imgBase64"];
        }
        NSString *title = [NSString stringWithFormat:@"%@开启自动签二维码",version];
        [weakSelf showQRCodeController:title urlString:nil base64Image:imgBase64];
    } failure:^(NSString * _Nonnull status, NSString * _Nonnull message, id  _Nullable info) {
        [weakSelf showAlertWith:@"error" code:status message:message info:info];
    }];
}


#pragma mark - UI布局

-(void)initView {
    [super initView];
    [self.contentView addSubview:self.openIdLabel];
    [self.contentView addSubview:self.openIdTextField];
    [self.contentView addSubview:self.hisLabel];
    [self.contentView addSubview:self.hisTextField];
    [self.contentView addSubview:self.v2QrSignCodeButton];
    [self.contentView addSubview:self.v3QrSignCodeButton];
    [self.contentView addSubview:self.v2OauthLoginButton];
    [self.contentView addSubview:self.v3OauthLoginButton];
    [self.contentView addSubview:self.v2BindSignButton];
    [self.contentView addSubview:self.v3BindSignButton];
    [self.contentView addSubview:self.v2autoSignButton];
    [self.contentView addSubview:self.v3autoSignButton];
    
    [self.openIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.secretIdTextField.mas_bottom).offset(20);
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(20);
        make.width.offset(100);
        make.height.offset(30);
    }];
    [self.openIdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.openIdLabel.mas_centerY);
        make.leading.mas_equalTo(self.openIdLabel.mas_trailing).offset(10);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-10);
        make.height.offset(30);
    }];
    [self.hisLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.openIdTextField.mas_bottom).offset(20);
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(20);
        make.width.offset(100);
        make.height.offset(30);
    }];
    [self.hisTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.hisLabel.mas_centerY);
        make.leading.mas_equalTo(self.hisLabel.mas_trailing).offset(10);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-10);
        make.height.offset(30);
    }];
    [self.v2QrSignCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hisTextField.mas_bottom).offset(20);
        make.leading.equalTo(self.contentView.mas_leading).offset(20);
        make.trailing.equalTo(self.v3QrSignCodeButton.mas_leading).offset(-20);
        make.height.offset(30);
    }];
    [self.v3QrSignCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.v2QrSignCodeButton.mas_top);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-20);
        make.width.equalTo(self.v2QrSignCodeButton.mas_width);
        make.height.equalTo(self.v2QrSignCodeButton.mas_height);
    }];
    [self.v2OauthLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.v2QrSignCodeButton.mas_bottom).offset(20);
        make.leading.equalTo(self.v2QrSignCodeButton.mas_leading);
        make.trailing.equalTo(self.v2QrSignCodeButton.mas_trailing);
        make.height.equalTo(self.v2QrSignCodeButton.mas_height);
    }];
    [self.v3OauthLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.v2OauthLoginButton.mas_top);
        make.leading.equalTo(self.v3QrSignCodeButton.mas_leading);
        make.trailing.equalTo(self.v3QrSignCodeButton.mas_trailing);
        make.height.equalTo(self.v2OauthLoginButton.mas_height);
    }];
    [self.v2BindSignButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.v2OauthLoginButton.mas_bottom).offset(20);
        make.leading.equalTo(self.v2QrSignCodeButton.mas_leading);
        make.trailing.equalTo(self.v2QrSignCodeButton.mas_trailing);
        make.height.equalTo(self.v2QrSignCodeButton.mas_height);
    }];
    [self.v3BindSignButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.v2BindSignButton.mas_top);
        make.leading.equalTo(self.v3QrSignCodeButton.mas_leading);
        make.trailing.equalTo(self.v3QrSignCodeButton.mas_trailing);
        make.height.equalTo(self.v2OauthLoginButton.mas_height);
    }];
    [self.v2autoSignButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.v2BindSignButton.mas_bottom).offset(20);
        make.leading.equalTo(self.v2QrSignCodeButton.mas_leading);
        make.trailing.equalTo(self.v2QrSignCodeButton.mas_trailing);
        make.height.equalTo(self.v2QrSignCodeButton.mas_height);
    }];
    [self.v3autoSignButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.v2autoSignButton.mas_top);
        make.leading.equalTo(self.v3QrSignCodeButton.mas_leading);
        make.trailing.equalTo(self.v3QrSignCodeButton.mas_trailing);
        make.height.equalTo(self.v2OauthLoginButton.mas_height);
    }];
}

-(NSString *)openId {
    if (self.openIdTextField.text.length > 0) {
        return self.openIdTextField.text;
    } else {
        return @"";
    }
}

- (UILabel *)openIdLabel {
    if (_openIdLabel == nil) {
        _openIdLabel = [[UILabel alloc] init];
        _openIdLabel.textColor = [UIColor blackColor];
        _openIdLabel.text = @"openId:";
    }
    return _openIdLabel;
}

- (UITextField *)openIdTextField {
    if (_openIdTextField == nil) {
        _openIdTextField = [[UITextField alloc]init];
        _openIdTextField.borderStyle = UITextBorderStyleRoundedRect;
        _openIdTextField.placeholder = @"请输入openId(不填则使用本机下证用户)";
        
    }
    return _openIdTextField;
}

- (UILabel *)hisLabel{
    if (_hisLabel == nil) {
        _hisLabel = [[UILabel alloc] init];
        _hisLabel.textColor = [UIColor blackColor];
        _hisLabel.text = @"his";
    }
    return _hisLabel;
}

- (UITextField *)hisTextField {
    if (_hisTextField == nil) {
        _hisTextField = [[UITextField alloc] init];
        _hisTextField.borderStyle = UITextBorderStyleRoundedRect;
        _hisTextField.placeholder = @"请输入自动签名的sysTag";
        _hisTextField.text = @"his";
    }
    return _hisTextField;
}

- (UIButton *)v2QrSignCodeButton {
    if (_v2QrSignCodeButton == nil) {
        _v2QrSignCodeButton = [self creatActionButton:@"V2扫码签名"];
        [_v2QrSignCodeButton addTarget:self action:@selector(getV2SignDataQrcode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _v2QrSignCodeButton;
}

- (UIButton *)v3QrSignCodeButton {
    if (_v3QrSignCodeButton == nil) {
        _v3QrSignCodeButton = [self creatActionButton:@"V3扫码签名"];
        [_v3QrSignCodeButton addTarget:self action:@selector(getV3SignDataQrcode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _v3QrSignCodeButton;
}

-(UIButton *)v2OauthLoginButton {
    if (_v2OauthLoginButton == nil) {
        _v2OauthLoginButton = [self creatActionButton:@"V2Oauth登录"];
        [_v2OauthLoginButton addTarget:self action:@selector(getV2OauthLoginQrcode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _v2OauthLoginButton;
}

-(UIButton *)v3OauthLoginButton {
    if (_v3OauthLoginButton == nil) {
        _v3OauthLoginButton = [self creatActionButton:@"V3Oauth登录"];
        [_v3OauthLoginButton addTarget:self action:@selector(getV3OauthLoginQrcode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _v3OauthLoginButton;
}

-(UIButton *)v2BindSignButton {
    if (_v2BindSignButton == nil) {
        _v2BindSignButton = [self creatActionButton:@"V2绑定认领签名"];
        [_v2BindSignButton addTarget:self action:@selector(getV2BindSignQrcode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _v2BindSignButton;
}

-(UIButton *)v3BindSignButton {
    if (_v3BindSignButton == nil) {
        _v3BindSignButton = [self creatActionButton:@"V3绑定认领签名"];
        [_v3BindSignButton addTarget:self action:@selector(getV3BindSignQrcode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _v3BindSignButton;
}

-(UIButton *)v2autoSignButton {
    if (_v2autoSignButton == nil) {
        _v2autoSignButton = [self creatActionButton:@"V2自动签名"];
        [_v2autoSignButton addTarget:self action:@selector(getV2AutoSignQrcode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _v2autoSignButton;
}

-(UIButton *)v3autoSignButton {
    if (_v3autoSignButton == nil) {
        _v3autoSignButton = [self creatActionButton:@"V3自动签名"];
        [_v3autoSignButton addTarget:self action:@selector(getV3AutoSignQrcode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _v3autoSignButton;
}

- (UIButton *)creatActionButton:(NSString *)title {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    UIImage *normalImage1 = [self ywx_imageWithColor:[UIColor colorWithRed:24/255.0 green:171/255.0 blue:251/255.0 alpha:1.0]];
    [button setBackgroundImage:normalImage1 forState:UIControlStateNormal];
    UIImage *highlightedImage1 = [self ywx_imageWithColor:[UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1.0]];
    [button setBackgroundImage:highlightedImage1 forState:UIControlStateDisabled];
    return button;
}


@end
