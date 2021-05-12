//
//  YWXUtilities.h
//  YWXSignFoundation
//
//  Created by Weipeng Qi on 2021/4/6.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWXUtilities : NSObject

/// 判断字符串是否是手机号。
/// @param number 字符串。
+ (BOOL)isCellPhoneNumber:(NSString *)number;

+ (NSBundle *)bundleWithName:(NSString*)name;

+ (NSString *)YWXLocalizedStringWithKey:(NSString *)key language:(NSString *)language inBundle:(NSString *)bundleName;

@end

NS_ASSUME_NONNULL_END
