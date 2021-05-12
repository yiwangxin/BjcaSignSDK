//
//  YWXUserInfoViewController.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/4/7.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import "YWXUserInfoViewController.h"
#import "Masonry.h"

@interface YWXUserInfoViewController ()

@property(nonatomic, strong) UILabel *openIdLabel;

@property(nonatomic, strong) UILabel *isFreePinLabel;

@property(nonatomic, strong) UITextView *userInfoTextView;

@property(nonatomic, strong) UIImageView *stampImageView;

@end

@implementation YWXUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

-(void)initUI {
    [self.view addSubview:self.openIdLabel];
    [self.view addSubview:self.isFreePinLabel];
    [self.view addSubview:self.userInfoTextView];
    [self.view addSubview:self.stampImageView];
    [self.openIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(5);
        make.leading.equalTo(self.view.mas_leading).offset(10);
        make.trailing.equalTo(self.view.mas_trailing).offset(-10);
        make.height.mas_equalTo(40);
    }];
    [self.isFreePinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.openIdLabel.mas_bottom).offset(5);
        make.leading.equalTo(self.openIdLabel.mas_leading);
        make.trailing.equalTo(self.openIdLabel.mas_trailing);
        make.height.equalTo(self.openIdLabel.mas_height);
    }];
    [self.userInfoTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.isFreePinLabel.mas_bottom).offset(5);
        make.leading.equalTo(self.openIdLabel.mas_leading);
        make.trailing.equalTo(self.openIdLabel.mas_trailing);
        make.height.mas_equalTo(200);;
    }];
    [self.stampImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userInfoTextView.mas_bottom).offset(5);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(80);;
    }];
}

-(void)initData {
//    self.freePin
    self.openIdLabel.text = [NSString stringWithFormat:@"openId:%@",self.openId?self.openId:@"不存在"];
    NSString *freePinString =  @"未开启";
    if (self.freePin) {
        freePinString = @"开启";
    }
    self.isFreePinLabel.text = [NSString stringWithFormat:@"是否开启免密:%@",freePinString];
    NSString *userInfoMessage = @"空";
    if (self.userInfoDictionary) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.userInfoDictionary options:NSJSONWritingPrettyPrinted error:nil];
        userInfoMessage = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    self.userInfoTextView.text = userInfoMessage;
    if (self.stampImageBase64) {
        NSArray *array = [self.stampImageBase64 componentsSeparatedByString:@","];
        NSString *base64 = self.stampImageBase64;
        if (array.count > 1) {
            base64 = array[1];
        } else {
            base64 = array[0];
        }
        NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *image = [UIImage imageWithData:decodedData];
        self.stampImageView.image = image;
    }
    
}

-(UILabel *)openIdLabel{
    if (_openIdLabel == nil) {
        _openIdLabel = [[UILabel alloc] init];
        _openIdLabel.textColor = [UIColor blackColor];
        _openIdLabel.font = [UIFont systemFontOfSize:14];
        _openIdLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _openIdLabel;
}

-(UILabel *)isFreePinLabel {
    if (_isFreePinLabel == nil) {
        _isFreePinLabel = [[UILabel alloc] init];
        _isFreePinLabel.textColor = [UIColor blackColor];
        _isFreePinLabel.font = [UIFont systemFontOfSize:14];
        _isFreePinLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _isFreePinLabel;
}

-(UITextView *)userInfoTextView {
    if (_userInfoTextView == nil) {
        _userInfoTextView = [[UITextView alloc] init];
        _userInfoTextView.textColor = [UIColor blackColor];
        _userInfoTextView.font = [UIFont systemFontOfSize:14];
        _userInfoTextView.backgroundColor = [UIColor lightGrayColor];
    }
    return _userInfoTextView;
}

-(UIImageView *)stampImageView {
    if (_stampImageView == nil) {
        _stampImageView = [[UIImageView alloc] init];
        _stampImageView.layer.borderWidth = 1;
        _stampImageView.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return _stampImageView;
}

@end
