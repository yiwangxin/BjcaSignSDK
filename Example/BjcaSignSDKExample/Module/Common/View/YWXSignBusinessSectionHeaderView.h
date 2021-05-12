//
//  YWXSignBusinessSectionHeaderView.h
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/25.
//

#import <UIKit/UIKit.h>
#import "YWXSignBusinessGroupModel.h"
NS_ASSUME_NONNULL_BEGIN

@class YWXSignBusinessSectionHeaderView;

@protocol YWXSignBusinessSectionHeaderViewDelegate <NSObject>

-(void)sectionHeader:(YWXSignBusinessSectionHeaderView *)sectionHeader didTap:(YWXSignBusinessGroupModel *)groupModel;

@end

@interface YWXSignBusinessSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<YWXSignBusinessSectionHeaderViewDelegate> delegate;

@property (nonatomic, strong) YWXSignBusinessGroupModel *groupModel;

@property (nonatomic, assign) NSInteger *itemCount;

@end

NS_ASSUME_NONNULL_END
