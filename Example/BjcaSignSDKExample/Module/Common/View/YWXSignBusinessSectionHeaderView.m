//
//  YWXSignBusinessSectionHeaderView.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/25.
//

#import "YWXSignBusinessSectionHeaderView.h"
#import "Masonry.h"
@interface YWXSignBusinessSectionHeaderView ()

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UIView *lineView;

@property(nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation YWXSignBusinessSectionHeaderView


- (void)setGroupModel:(YWXSignBusinessGroupModel *)groupModel {
    _groupModel = groupModel;
    self.titleLabel.text = groupModel.titleString;
    if (groupModel.isShow) {
        self.arrowImageView.image = [UIImage imageNamed:@"arrow_up"];
    } else {
        self.arrowImageView.image = [UIImage imageNamed:@"arrow_down"];
    }
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)initUI {
    self.contentView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.arrowImageView];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(10);
        make.trailing.mas_equalTo(self.arrowImageView.mas_leading);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.leading.mas_equalTo(self.contentView.mas_leading);
        make.trailing.mas_equalTo(self.contentView.mas_trailing);
        make.height.mas_equalTo(0.5);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-16).priority(500);
        make.size.mas_equalTo(self.arrowImageView.intrinsicContentSize).priority(500);
    }];
}

-(void)didClick {
    self.groupModel.isShow = !self.groupModel.isShow;
    if ([self.delegate respondsToSelector:@selector(sectionHeader:didTap:)]) {
        [self.delegate sectionHeader:self didTap:self.groupModel];
    }
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (UIImageView *)arrowImageView {
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"arrow_down"];
    }
    return _arrowImageView;
}

@end
