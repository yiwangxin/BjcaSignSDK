//
//  UIViewController+YWXAddition.h
//  YWXSignFoundation
//
//  Created by Weipeng Qi on 2021/3/24.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (YWXAddition)

/// 获取当前 key window 持有的最顶层控制器。
+ (nullable UIViewController *)ywx_topViewController;

@end

NS_ASSUME_NONNULL_END
