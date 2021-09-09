//
//  YWXClientIdInfoView.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/25.
//

#import "YWXClientIdInfoView.h"
#import "Masonry.h"

@interface YWXClientIdInfoView ()<UITextFieldDelegate>

@property (nonatomic,strong) UILabel *clientIdLabel;
@property (nonatomic,strong) UITextField *clientIdTextField;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UITextField *phoneTextField;
@property (nonatomic,strong) UILabel *promptLabel;
@property (nonatomic,strong) UIView *promptView;
@property (nonatomic,strong) UIButton *actionButoon;
@property (nonatomic,strong) MASConstraint *buttonHeight;

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
    self.backgroundColor = [UIColor colorWithRed:30/255.0 green:150/255.0 blue:255/255.0 alpha:1.0];
    [self addSubview:self.clientIdLabel];
    [self addSubview:self.clientIdTextField];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.phoneTextField];
    
    [self addSubview:self.promptView];
    [self.promptView addSubview:self.promptLabel];
    [self.promptView addSubview:self.actionButoon];
}

- (void)updateConstraints {
    [self.clientIdTextField setContentCompressionResistancePriority:900 forAxis:UILayoutConstraintAxisHorizontal];
    [self.clientIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.clientIdTextField.mas_centerY);
        make.leading.mas_equalTo(self.mas_leading).offset(10);
        make.width.offset(80);
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

    }];
    [self.promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).offset(10);
        make.leading.mas_equalTo(self.mas_leading).offset(10);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-10);
        
    }];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.promptView.mas_top).offset(10);
        make.leading.mas_equalTo(self.promptView.mas_leading).offset(0);
        make.trailing.mas_equalTo(self.actionButoon.mas_leading).offset(0);
        make.bottom.mas_equalTo(self.promptView.mas_bottom).offset(-10);
    }];
    [self.actionButoon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.promptView.mas_centerY);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-10);
        make.width.offset(80);
        make.height.offset(30);
    }];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        self.buttonHeight = make.bottom.mas_equalTo(self.phoneTextField.mas_bottom).offset(10);
    }];
    [super updateConstraints];
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

-(void)textfieldDidChange:(UITextField *)textField {
//    [self.actionButoon mas_updateConstraints:^(MASConstraintMaker *make) {
//        self.buttonHeight = make.height.offset(30);
//    }];
    [self.buttonHeight uninstall];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        self.buttonHeight = make.bottom.mas_equalTo(self.promptView.mas_bottom).offset(10);
    }];
    self.promptView.hidden = NO;
    NSLog(@"text change");
}

-(void)didClickChangeButton:(UIButton *)button {
    if (self.didClickChange) {
        self.didClickChange();
    }
    self.promptView.hidden = YES;
    [self.buttonHeight uninstall];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        self.buttonHeight = make.bottom.mas_equalTo(self.phoneTextField.mas_bottom).offset(10);
    }];
}

#pragma mark - 懒加载

-(UILabel *)clientIdLabel {
    if (_clientIdLabel == nil) {
        _clientIdLabel = [[UILabel alloc] init];
        _clientIdLabel.textColor = [UIColor whiteColor];
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
        _clientIdTextField.delegate = self;
        [_clientIdTextField addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _clientIdTextField;
}

-(UILabel *)phoneLabel {
    if (_phoneLabel == nil) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.textColor = [UIColor whiteColor];
        _phoneLabel.text = @"手机号：";
    }
    return _phoneLabel;
}

- (UITextField *)phoneTextField {
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
        _phoneTextField.placeholder = @"请填写手机号";
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneTextField;
}

-(UILabel *)promptLabel {
    if (_promptLabel == nil) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.textColor = [UIColor colorWithRed:250/255.0 green:212/255.0 blue:20/255.0 alpha:1.0];;
        _promptLabel.numberOfLines = 0;
        _promptLabel.font = [UIFont systemFontOfSize:14];
        _promptLabel.text = @"提示：修改ClientId后需要重新切换一下环境, 同时会清除当前证书信息";
    }
    return _promptLabel;
}

-(UIButton *)actionButoon {
    if (_actionButoon == nil) {
        _actionButoon = [[UIButton alloc] init];
        [_actionButoon setTitle:@"修改" forState: UIControlStateNormal];
        _actionButoon.layer.cornerRadius = 10;
        _actionButoon.layer.masksToBounds = YES;
        _actionButoon.titleLabel.font = [UIFont systemFontOfSize:14];
        _actionButoon.backgroundColor = [UIColor colorWithRed:253/255.0 green:101/255.0 blue:133/255.0 alpha:1.0];
        [_actionButoon addTarget:self action:@selector(didClickChangeButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButoon;
}

-(UIView *)promptView {
    if (_promptView == nil) {
        _promptView = [[UIView alloc] init];
//        _promptView
        
    }
    return _promptView;
}

@end
