//
//  YWXSignDataViewController.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/31.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import "YWXSignDataViewController.h"
#import "YWXDemoNetManager.h"
#import "YWXSignRandomInfo.h"

#import "Masonry.h"


@interface YWXSignDataViewController ()

@property (nonatomic,strong) UILabel *clientIdLabel;

@property (nonatomic,strong) UITextField *clientIdTextField;

@property (nonatomic,strong) UILabel *secretIdLabel;

@property (nonatomic,strong) UITextField *secretIdTextField;

@property (nonatomic,strong) UILabel *doctorIdLabel;

@property (nonatomic,strong) UITextField *doctroIdTextField;

@property (nonatomic,strong) UIButton *orderButton;

@property (nonatomic,strong) UIButton *orderPdfButton;

@property (nonatomic,strong) UILabel *orderNumTitleLabel;

@property (nonatomic,strong) UITextField *orderNumTextField;

@property (nonatomic,strong) UILabel *successLabel;

@property (nonatomic,strong) UIButton *signButton;

@property (nonatomic,strong) UIImageView *signImageView;

@property (nonatomic,strong) UITextView *uniqueIdTextView;


/// token
@property (nonatomic,strong) NSString *accessToken;

/// 待签数据
@property (nonatomic,strong) NSMutableArray *uniqueIdsArray;

/// 待同步的总数量
@property (nonatomic,assign) int waitSendDataSumCount;
/// 当前同步的数量
@property (nonatomic,assign) int currentSendCount;
/// 当前同步的数量
@property (nonatomic,assign) int currentSuccessSendCount;

@end

@implementation YWXSignDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    self.clientIdTextField.text = self.clientId;
    if ([self.clientId isEqualToString:@"2015112716143758"]) {
        self.secretIdTextField.text = @"111111";
        self.orderNumTextField.text = @"1";
        
    }
    
}

- (void)signBatch{
    
    [self.view endEditing:YES];
    if (_uniqueIdsArray.count <= 0) {
        [self showAlertWith:@"提示" code:@"-1" message:@"签名数据不能为空！" info:@{}];
        return;
    }
    if (self.signButtonClickCallBack) {
        self.signButtonClickCallBack(self.uniqueIdsArray);
    }
    [self didClickSignButton:self.uniqueIdsArray];
}

-(void)didClickSignButton:(NSArray *)uniqueIDs {
    
}

- (void)getUniqueIds:(UIButton *)button {
    if (YWXDemoNetManager.sharedManager.environment == YWXDemoEnvironmentProduction) {
        [self showAlertWith:@"提示" code:@"-1" message:@"当前环境是线上正式环境，会产生脏数据，不建议同步！！！" info:@{}];
        return;
    }
    if (self.currentClientId.length <= 0) {
        [self showAlertWith:@"提示" code:@"-1" message:@"ClientId为空" info:@{}];
        return;
    }
    if (self.secretIdTextField.text.length <= 0) {
        [self showAlertWith:@"提示" code:@"-1" message:@"secretId为空" info:@{}];
        return;
    }
    if (self.orderNumTextField.text.length <= 0) {
        [self showAlertWith:@"提示" code:@"-1" message:@"请输入同步数量" info:@{}];
        return;
    }
    self.successLabel.text = [NSString stringWithFormat:@"已同步0条待签数据到医网信"];
    self.uniqueIdTextView.text = [NSString stringWithFormat:@"无"];
    self.signImageView.image = nil;
    BOOL isPdf = button.tag == 1001 ? YES : NO;
    if (self.accessToken.length > 0) {
        [self beginSynSendData:self.accessToken isPdf:isPdf];
    } else {
        [self getClientToken:isPdf];
    }
    
}

/// 获取token
/// @param isPdf 是否是pdf
- (void)getClientToken:(BOOL)isPdf {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:self.clientIdTextField.text forKey:@"clientId"];
    [dic setObject:self.secretIdTextField.text forKey:@"appSecret"];
    [[YWXDemoNetManager sharedManager] getWithURLPath:@"/device/v3/server/oauth/getAccessToken" parameters:dic businessSuccess:^(NSString * _Nonnull status, NSString * _Nonnull message, id  _Nullable info) {
        NSString *accessToken = info[@"accessToken"];
        self.accessToken = accessToken;
        [self beginSynSendData:self.accessToken isPdf:isPdf];
    } failure:^(NSString * _Nonnull status, NSString * _Nonnull message, id  _Nullable info) {
        NSLog(@"status:%@ message:%@",status,message);
        [self showAlertWith:@"获取token失败" code:status message:message info:info];
    }];
    
}

/// 开始同步数据
/// @param accessToken token
-(void)beginSynSendData:(NSString *)accessToken isPdf:(BOOL)isPdf{
    self.uniqueIdsArray = [[NSMutableArray alloc]init];
    self.currentSuccessSendCount = 0;
    self.currentSendCount = 0;
    if (self.doctroIdTextField.text) {
        for (int i=0; i < self.waitSendDataSumCount; i++) {
            [self synSendData:accessToken clientId:self.currentClientId isPdf:isPdf];
        }
    }
}

/// 同步数据
/// @param accessToken 请求token
/// @param clientId 厂商id
- (void)synSendData:(NSString *)accessToken clientId:(NSString *)clientId isPdf:(BOOL)isPdf {
    
    NSDictionary *dic = [YWXSignRandomInfo getRandomRecipeDic:accessToken openId:self.openId clientId:clientId isPdf:isPdf];
    self.currentSendCount++;
    [[YWXDemoNetManager sharedManager] postJsonWithURLPath:@"/am/v3/recipe/syn" parameters:dic businessSuccess:^(NSString * _Nonnull status, NSString * _Nonnull message, id  _Nullable info) {
        self.currentSuccessSendCount++;
        NSString *uniqueId = info[@"uniqueId"];
        [self.uniqueIdsArray addObject:uniqueId];
        if (self.currentSendCount == self.waitSendDataSumCount) {
            self.successLabel.text = [NSString stringWithFormat:@"已同步%d/%d条待签数据到医网信",self.currentSuccessSendCount, self.waitSendDataSumCount];
            NSMutableString *uniqueIdText = [NSMutableString string];
            for (int i = 0; i<self.uniqueIdsArray.count; i++) {
                NSString *uniqueId = self.uniqueIdsArray[i];
                [uniqueIdText appendFormat:@"%@\n",uniqueId];
            }
            self.uniqueIdTextView.text = [uniqueIdText copy];
        }
    } failure:^(NSString * _Nonnull status, NSString * _Nonnull message, id  _Nullable info) {
        NSLog(@"status:%@ message:%@",status,message);
        if (self.currentSendCount == self.waitSendDataSumCount) {
            self.successLabel.text = [NSString stringWithFormat:@"已同步%d/%d条待签数据到医网信",self.currentSuccessSendCount, self.waitSendDataSumCount];
            NSMutableString *uniqueIdText = [NSMutableString string];
            for (int i = 0; i<self.uniqueIdsArray.count; i++) {
                NSString *uniqueId = self.uniqueIdsArray[i];
                [uniqueIdText appendFormat:@"%@\n",uniqueId];
            }
            self.uniqueIdTextView.text = [uniqueIdText copy];
        }
        [self showAlertWith:@"提示" code:status message:message info:info];
    }];
    
    
}

-(void)initUI {
    [self.view addSubview:self.clientIdLabel];
    [self.view addSubview:self.clientIdTextField];
    [self.view addSubview:self.secretIdLabel];
    [self.view addSubview:self.secretIdTextField];
    [self.view addSubview:self.orderNumTitleLabel];
    [self.view addSubview:self.orderNumTextField];
    [self.view addSubview:self.orderButton];
    [self.view addSubview:self.orderPdfButton];
    [self.view addSubview:self.successLabel];
    [self.view addSubview:self.signButton];
    [self.view addSubview:self.signImageView];
    [self.view addSubview:self.uniqueIdTextView];
    
    [self.clientIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        make.leading.mas_equalTo(self.view.mas_leading).offset(20);
        make.width.offset(100);
        make.height.offset(30);
    }];
    [self.clientIdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.clientIdLabel.mas_centerY);
        make.leading.mas_equalTo(self.clientIdLabel.mas_trailing).offset(10);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-10);
        make.height.offset(30);
    }];
    [self.secretIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.clientIdLabel.mas_bottom).offset(20);
        make.leading.mas_equalTo(self.view.mas_leading).offset(20);
        make.width.offset(100);
        make.height.offset(30);
    }];
    [self.secretIdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.secretIdLabel.mas_centerY);
        make.leading.mas_equalTo(self.secretIdLabel.mas_trailing).offset(10);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-10);
        make.height.offset(30);
    }];
    [self.orderNumTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.secretIdLabel.mas_bottom).offset(20);
        make.leading.mas_equalTo(self.secretIdLabel.mas_leading);
    }];
    [self.orderNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.orderNumTitleLabel.mas_centerY);
        make.leading.mas_equalTo(self.secretIdTextField.mas_leading);
        make.trailing.mas_equalTo(self.secretIdTextField.mas_trailing);
        make.height.offset(30);
    }];
    [self.orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderNumTitleLabel.mas_bottom).offset(20);
        make.leading.mas_equalTo(self.view.mas_leading).offset(20);
        make.width.mas_equalTo(self.orderPdfButton.mas_width);
        make.height.offset(30);
    }];
    [self.orderPdfButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.orderButton.mas_centerY);
        make.leading.mas_equalTo(self.orderButton.mas_trailing).offset(10);
        make.width.mas_equalTo(self.orderButton.mas_width);
        make.height.mas_equalTo(self.orderButton.mas_height);
    }];
    [self.successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderButton.mas_bottom).offset(20);
        make.leading.mas_equalTo(self.view.mas_leading).offset(20);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-20);
        make.height.offset(30);
    }];
    [self.signButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.successLabel.mas_bottom).offset(20);
        make.leading.mas_equalTo(self.view.mas_leading).offset(20);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-20);
        make.height.offset(30);
    }];
    [self.signImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signButton.mas_bottom).offset(20);
        make.leading.mas_equalTo(self.view.mas_leading).offset(30);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-30);
        make.height.offset(100);
    }];
    [self.uniqueIdTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signImageView.mas_bottom).offset(20);
        make.leading.mas_equalTo(self.view.mas_leading).offset(30);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-30);
        make.height.offset(120);
    }];
}

/// 当前的ClientId
- (NSString *)currentClientId {
    return self.clientIdTextField.text;
}

-(int)waitSendDataSumCount {
    return [self.orderNumTextField.text intValue];
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

/// 医师证件号id
- (UILabel *)doctorIdLabel {
    if (_doctorIdLabel == nil) {
        _doctorIdLabel = [[UILabel alloc] init];
        _doctorIdLabel.textColor = [UIColor blackColor];
        _doctorIdLabel.text = @"医师证件号:";
    }
    return _doctorIdLabel;
}

/// 医师证件号id输入视图
- (UITextField *)doctroIdTextField {
    if (_doctroIdTextField == nil) {
        _doctroIdTextField = [[UITextField alloc]init];
        _doctroIdTextField.borderStyle = UITextBorderStyleRoundedRect;
        _doctroIdTextField.placeholder = @"请输入医师证件号";
//        if (self.doctorModel.DoctorId) {
//            _doctroIdTextField.text = self.doctorModel.DoctorId;
//        }
    }
    return _doctroIdTextField;
}

-(UIButton *)orderButton {
    if (_orderButton == nil) {
        _orderButton = [[UIButton alloc] init];
        [_orderButton setTitle:@"点击同步处方数据" forState:UIControlStateNormal];
        _orderButton.tintColor = [UIColor whiteColor];
        _orderButton.titleLabel.font = [UIFont systemFontOfSize:15];
        UIImage *normalImage = [self ywx_imageWithColor:[UIColor colorWithRed:24/255.0 green:171/255.0 blue:251/255.0 alpha:1.0]];
        [_orderButton setBackgroundImage:normalImage forState:UIControlStateNormal];
        UIImage *highlightedImage = [self ywx_imageWithColor:[UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1.0]];
        [_orderButton setBackgroundImage:highlightedImage forState:UIControlStateDisabled];
        [_orderButton addTarget:self action:@selector(getUniqueIds:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderButton;
}

-(UIButton *)orderPdfButton {
    if (_orderPdfButton == nil) {
        _orderPdfButton = [[UIButton alloc] init];
        _orderPdfButton.tag = 1001;
        [_orderPdfButton setTitle:@"点击同步pdf数据" forState:UIControlStateNormal];
        _orderPdfButton.tintColor = [UIColor whiteColor];
        _orderPdfButton.titleLabel.font = [UIFont systemFontOfSize:15];
        UIImage *normalImage = [self ywx_imageWithColor:[UIColor colorWithRed:24/255.0 green:171/255.0 blue:251/255.0 alpha:1.0]];
        [_orderPdfButton setBackgroundImage:normalImage forState:UIControlStateNormal];
        UIImage *highlightedImage = [self ywx_imageWithColor:[UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1.0]];
        [_orderPdfButton setBackgroundImage:highlightedImage forState:UIControlStateDisabled];
        [_orderPdfButton addTarget:self action:@selector(getUniqueIds:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderPdfButton;
}

- (UILabel *)orderNumTitleLabel {
    if (_orderNumTitleLabel == nil) {
        _orderNumTitleLabel = [[UILabel alloc]init];
        _orderNumTitleLabel.textColor = [UIColor blackColor];
        _orderNumTitleLabel.text = @"同步数量：";
    }
    return _orderNumTitleLabel;
}

- (UITextField *)orderNumTextField {
    if (_orderNumTextField == nil) {
        _orderNumTextField = [[UITextField alloc]init];
        _orderNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        _orderNumTextField.borderStyle = UITextBorderStyleRoundedRect;
        _orderNumTextField.placeholder = @"请输入同步订单数量(条)";
    }
    return _orderNumTextField;
}

- (UILabel *)successLabel {
    if (_successLabel == nil) {
        _successLabel = [[UILabel alloc]init];
        _successLabel.textColor = [UIColor grayColor];
        _successLabel.text = @"无";
    }
    return _successLabel;
}

- (UIButton *)signButton {
    if (_signButton == nil) {
        _signButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_signButton setTitle:@"批量签名" forState:UIControlStateNormal];
        _signButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

        _signButton.titleLabel.font = [UIFont systemFontOfSize:16];
        UIImage *normalImage1 = [self ywx_imageWithColor:[UIColor colorWithRed:24/255.0 green:171/255.0 blue:251/255.0 alpha:1.0]];
        [_signButton setBackgroundImage:normalImage1 forState:UIControlStateNormal];
        UIImage *highlightedImage1 = [self ywx_imageWithColor:[UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1.0]];
        [_signButton setBackgroundImage:highlightedImage1 forState:UIControlStateDisabled];
        [_signButton addTarget:self action:@selector(signBatch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signButton;
}

- (UIImageView *)signImageView {
    if (_signImageView == nil) {
        _signImageView = [[UIImageView alloc]init];
        _signImageView.contentMode = UIViewContentModeScaleAspectFit;
        _signImageView.layer.borderWidth = 1;
        _signImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _signImageView.backgroundColor = [UIColor redColor];
    }
    return _signImageView;
}


-(UITextView *)uniqueIdTextView {
    if (_uniqueIdTextView == nil) {
        _uniqueIdTextView = [[UITextView alloc] init];
        _signImageView.layer.borderWidth = 1;
        _signImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _signImageView.backgroundColor = [UIColor whiteColor];
    }
    return _uniqueIdTextView;
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

@end
