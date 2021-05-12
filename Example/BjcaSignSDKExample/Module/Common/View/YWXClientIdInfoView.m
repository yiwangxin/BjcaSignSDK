//
//  YWXClientIdInfoView.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/25.
//

#import "YWXClientIdInfoView.h"
#import "Masonry.h"

@interface YWXClientIdInfoView ()

@property (nonatomic,strong) UILabel *clientIdLabel;
@property (nonatomic,strong) UITextField *clientIdTextField;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UITextField *phoneTextField;

@end

@implementation YWXClientIdInfoView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self ininUI];
    }
    return self;
}

-(void)ininUI {
    self.backgroundColor = [UIColor purpleColor];
    [self addSubview:self.clientIdLabel];
    [self addSubview:self.clientIdTextField];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.phoneTextField];
    [self.clientIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.clientIdTextField.mas_centerY);
        make.leading.mas_equalTo(self.mas_leading).offset(10);
        make.width.mas_equalTo(80);
        make.height.offset(20);
    }];
    
    [self.clientIdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.leading.mas_equalTo(self.clientIdLabel.mas_trailing).offset(5);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-10);
        make.height.offset(30);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.phoneTextField.mas_centerY);
        make.leading.mas_equalTo(self.clientIdLabel.mas_leading);
        make.trailing.mas_equalTo(self.clientIdLabel.mas_trailing);
    }];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.clientIdTextField.mas_bottom).offset(10);
        make.leading.mas_equalTo(self.clientIdTextField.mas_leading).offset(0);
        make.trailing.mas_equalTo(self.clientIdTextField.mas_trailing).offset(0);
        make.height.mas_equalTo(self.clientIdTextField.mas_height).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
    
}

-(void)inputClientId:(NSString *)clientId {
    self.clientIdTextField.text = clientId;
}

-(void)inputPhoneNumber:(NSString *)phone {
    self.phoneTextField.text = phone;
}

-(NSString *)clientId {
    return self.clientIdTextField.text;
}

-(NSString *)phoneNumber {
    return self.phoneTextField.text;
}

#pragma mark - 懒加载

-(UILabel *)clientIdLabel {
    if (_clientIdLabel == nil) {
        _clientIdLabel = [[UILabel alloc] init];
        _clientIdLabel.textColor = [UIColor blackColor];
        _clientIdLabel.text = @"ClientId：";
    }
    return _clientIdLabel;
}

- (UITextField *)clientIdTextField {
    if (_clientIdTextField == nil) {
        _clientIdTextField = [[UITextField alloc]init];
        _clientIdTextField.borderStyle = UITextBorderStyleRoundedRect;
        _clientIdTextField.placeholder = @"请填写分配的clientId";
        _clientIdTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _clientIdTextField;
}

-(UILabel *)phoneLabel {
    if (_phoneLabel == nil) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.textColor = [UIColor blackColor];
        _phoneLabel.text = @"手机号：";
    }
    return _phoneLabel;
}

- (UITextField *)phoneTextField {
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc]init];
        _phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
        _phoneTextField.placeholder = @"请填写手机号";
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneTextField;
}


@end
