//
//  YWXClientIdInfoView.h
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWXClientIdInfoView : UIView

@property(nonatomic, copy, readonly) NSString *clientId;

@property(nonatomic, copy, readonly) NSString *phoneNumber;

/// 点击修改
@property (nonatomic, copy) void (^didClickChange)(void);

-(void)inputClientId:(NSString *)clientId;

-(void)inputPhoneNumber:(NSString *)phone;

@end

NS_ASSUME_NONNULL_END
