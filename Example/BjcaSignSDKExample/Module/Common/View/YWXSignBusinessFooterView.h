//
//  YWXSignBusinessFooterView.h
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWXSignBusinessFooterView : UIView

-(void)updateInfoWithVersion:(NSString *)version
                 serviceType:(NSInteger)serviceType
                 isExistCert:(BOOL)isExistCert
                 sdkLanguage:(NSString *)sdkLanguage;

@end

NS_ASSUME_NONNULL_END
