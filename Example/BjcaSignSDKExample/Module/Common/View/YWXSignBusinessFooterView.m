//
//  YWXSignBusinessFooterView.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/25.
//

#import "YWXSignBusinessFooterView.h"
#import "Masonry.h"

@interface YWXSignBusinessFooterView ()

@property (nonatomic, strong) UILabel *contentLabel;


@end

@implementation YWXSignBusinessFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        
    }
    return self;
}

-(void)updateInfoWithVersion:(NSString *)version
                 serviceType:(NSInteger)serviceType
                 isExistCert:(BOOL)isExistCert
                 sdkLanguage:(NSString *)sdkLanguage {
    NSMutableString *footMessage = [NSMutableString string];
    [footMessage appendFormat:@"版本号：%@\n",version];
    [footMessage appendFormat:@"SDK显示语言：%@\n",sdkLanguage];
    [footMessage appendFormat:@"是否存在证书：%@\n",isExistCert ? @"存在" : @"不存在"];
    
    NSString *env = @"";
    switch (serviceType) {
        case 0:
            env = @"生产环境";
            break;
        case 1:
            env = @"集成环境";
            break;
        case 2:
            env = @"测试环境";
            break;
        case 3:
            env = @"开发环境";
            break;
        default:
            env = @"未知环境";
            break;
    }
    [footMessage appendFormat:@"当前环境：%@\n",env];
    self.contentLabel.text = footMessage;
    CGSize size = [self.contentLabel systemLayoutSizeFittingSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 1000)];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, size.height+10);
}

-(void)initUI {
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.leading.mas_equalTo(self.mas_leading).offset(10);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-10).priority(500);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
    }];
    [self updateInfoWithVersion:@"未知" serviceType:@"未知" isExistCert:NO sdkLanguage:@"未知"];
}

-(UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textColor = [UIColor lightGrayColor];
        _contentLabel.preferredMaxLayoutWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 20;
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

@end
