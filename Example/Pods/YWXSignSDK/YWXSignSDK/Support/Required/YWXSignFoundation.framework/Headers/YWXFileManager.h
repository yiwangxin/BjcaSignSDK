//
//  YWXFileManager.h
//  YWXSignFoundation
//
//  Created by szyx on 2021/3/31.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWXFileManager : NSObject

/// 单例
+ (instancetype)sharedManager;

/// 保存对应信息到指定的文件下
/// @param value 需要保存的内容
/// @param key 需要保存的健值
/// @param fileName 文件名
+(BOOL)saveValue:(id)value forKey:(id)key inDocumentFileName:(NSString *)fileName;

/// 获取对应健值得信息
/// @param key 健值
/// @param fileName 文件名
+(id)getValueForKey:(id)key inFileName:(NSString *)fileName;

/// 删除对应健值的内容
/// @param key 健值
/// @param fileName 文件名
+(BOOL)removeValueForKey:(id)key inFileName:(NSString *)fileName;

/// 删除对应的文件
/// @param fileName 文件名
+(BOOL)removeFileWithFileName:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
