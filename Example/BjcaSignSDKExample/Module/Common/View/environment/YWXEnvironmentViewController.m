//
//  YWXEnvironmentViewController.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/4/13.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import "YWXEnvironmentViewController.h"
#import "Masonry.h"

@interface YWXEnvironmentViewController ()

@property(nonatomic, assign) YWXDemoEnvironment currentEnvironment;

@property(nonatomic, strong) UILabel *currentInfoLabel;

@property(nonatomic, strong) UIButton *currentSelectedEnvironmentButton;

@property(nonatomic, strong) UIButton *confirmButton;



@end

@implementation YWXEnvironmentViewController

+(void)getCurrentEnviromentWithEnvironmentKeyName:(NSString *)environmentKeyName environmentChangeBlack:(EnvironmentChangeClick)environmentChangeBlack {
    YWXDemoEnvironment currentEnvironment = [self getCurrentEnviromentWithEnvironmentKeyName:environmentKeyName];
    if (environmentChangeBlack) {
        environmentChangeBlack(currentEnvironment);
    }
}

+(YWXDemoEnvironment)getCurrentEnviromentWithEnvironmentKeyName:(NSString *)environmentKeyName {
    NSNumber *type = [[NSUserDefaults standardUserDefaults] objectForKey:environmentKeyName];
    YWXDemoEnvironment currentEnvironment = [type integerValue];
    if (type) {
        currentEnvironment = [type integerValue];
    } else {
        currentEnvironment = YWXDemoEnvironmentDevelopment;
    }
    return currentEnvironment;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.environmentKeyName == nil) {
        self.environmentKeyName = @"serverType";
    }
    self.currentEnvironment = [YWXEnvironmentViewController getCurrentEnviromentWithEnvironmentKeyName:self.environmentKeyName];
    [self initUI];
    
    NSString *currentInfo = @"";
    switch (self.currentEnvironment) {
        case YWXDemoEnvironmentProduction:
            currentInfo = @"生产环境";
            break;
        case YWXDemoEnvironmentAcceptance:
            currentInfo = @"集成环境";
            break;
        case YWXDemoEnvironmentTesting:
            currentInfo = @"测试环境";
            break;
        case YWXDemoEnvironmentDevelopment:
            currentInfo = @"开发环境";
            break;
    }
    self.currentInfoLabel.text = [NSString stringWithFormat:@"当前环境：%@",currentInfo];
}

-(void)initUI {
    self.title = @"切换环境";
    UIButton *productButton = [self creatEnviromentButton:YWXDemoEnvironmentProduction];
    UIButton *acceptanceButton = [self creatEnviromentButton:YWXDemoEnvironmentAcceptance];
    UIButton *testButton = [self creatEnviromentButton:YWXDemoEnvironmentTesting];
    UIButton *devButton = [self creatEnviromentButton:YWXDemoEnvironmentDevelopment];
    [self.view addSubview:self.currentInfoLabel];
    [self.view addSubview:productButton];
    [self.view addSubview:acceptanceButton];
    [self.view addSubview:testButton];
    [self.view addSubview:devButton];
    [self.view addSubview:self.confirmButton];
    [self.currentInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(10);
            make.leading.equalTo(self.view.mas_leading).offset(20);
            make.trailing.equalTo(self.view.mas_trailing).offset(-20);
    }];
    [productButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.currentInfoLabel.mas_bottom).offset(10);
        make.leading.equalTo(self.view.mas_leading).offset(20);
        make.trailing.equalTo(self.view.mas_trailing).offset(-20);
        make.height.mas_offset(40);
    }];
    [acceptanceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(productButton.mas_bottom).offset(20);
        make.leading.equalTo(productButton.mas_leading);
        make.trailing.equalTo(productButton.mas_trailing);
        make.height.equalTo(productButton.mas_height);
    }];
    [testButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(acceptanceButton.mas_bottom).offset(20);
        make.leading.equalTo(productButton.mas_leading);
        make.trailing.equalTo(productButton.mas_trailing);
        make.height.equalTo(productButton.mas_height);
    }];
    [devButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(testButton.mas_bottom).offset(20);
        make.leading.equalTo(productButton.mas_leading);
        make.trailing.equalTo(productButton.mas_trailing);
        make.height.equalTo(productButton.mas_height);
    }];

    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(devButton.mas_bottom).offset(40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_offset(200);
        make.height.mas_offset(50);
    }];
    
}

-(UIButton *)creatEnviromentButton:(YWXDemoEnvironment)environmentType {
    NSString *title = @"";
    switch (environmentType) {
        case YWXDemoEnvironmentProduction:
            title = @"生产环境";
            break;
        case YWXDemoEnvironmentAcceptance:
            title = @"集成环境";
            break;
        case YWXDemoEnvironmentTesting:
            title = @"测试环境";
            break;
        case YWXDemoEnvironmentDevelopment:
            title = @"开发环境";
            break;
    }
    UIButton *enviromentButton = [[UIButton alloc] init];
    enviromentButton.tag = environmentType;
    UIImage *normalImage = [UIImage imageNamed:@"environment_normal"];
    UIImage *selectImage = [UIImage imageNamed:@"Environment_selected"];
    [enviromentButton setImage:normalImage forState:UIControlStateNormal];
    [enviromentButton setImage:selectImage forState:UIControlStateSelected];
    [enviromentButton setTitle:title forState:UIControlStateNormal];
    [enviromentButton addTarget:self action:@selector(didClickEnviromentButton:) forControlEvents:UIControlEventTouchUpInside];
    [enviromentButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [enviromentButton setTitleColor:UIColor.redColor forState:UIControlStateSelected];
    enviromentButton.titleLabel.textColor = [UIColor blackColor];
    enviromentButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    if (self.currentEnvironment == environmentType) {
        enviromentButton.selected = YES;
        self.currentSelectedEnvironmentButton = enviromentButton;
    } else {
        enviromentButton.selected = NO;
    }
    return enviromentButton;
    
}

-(void)didClickEnviromentButton:(UIButton *)button {
    NSInteger environmentType = button.tag;
    self.currentEnvironment = environmentType;
    self.currentSelectedEnvironmentButton.selected = NO;
    button.selected = YES;
    self.currentSelectedEnvironmentButton = button;
}

-(void)didClickChangeEnviromentButton:(UIButton *)button {
    NSInteger environmentType = self.currentSelectedEnvironmentButton.tag;
    [[NSUserDefaults standardUserDefaults] setObject:@(environmentType) forKey:self.environmentKeyName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (self.environmentChangeBlack) {
        self.environmentChangeBlack(self.currentEnvironment);
    }
    [self showAlertWith:@"切换环境" code:@"0" message:@"成功" info:@{} confirm:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

-(UILabel *)currentInfoLabel {
    if (_currentInfoLabel == nil) {
        _currentInfoLabel = [[UILabel alloc] init];
        _currentInfoLabel.textColor = [UIColor redColor];
        _currentInfoLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _currentInfoLabel;
}

-(UIButton *)confirmButton {
    if (_confirmButton == nil) {
        _confirmButton = [[UIButton alloc] init];
        [_confirmButton setTitle:@"修改环境" forState:UIControlStateNormal];
        _confirmButton.titleLabel.textColor = [UIColor blackColor];
        UIImage *normalImage = [self ywx_imageWithColor:[UIColor colorWithRed:24/255.0 green:171/255.0 blue:251/255.0 alpha:1.0]];
        [_confirmButton setBackgroundImage:normalImage forState:UIControlStateNormal];
        UIImage *highlightedImage = [self ywx_imageWithColor:[UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1.0]];
        [_confirmButton setBackgroundImage:highlightedImage forState:UIControlStateDisabled];
        [_confirmButton addTarget:self action:@selector(didClickChangeEnviromentButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

@end
