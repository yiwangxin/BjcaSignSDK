//
//  YWXAlgCFYUserDataManager.h
//  YWXSignFoundation
//
//  Created by szyx on 2021/4/19.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWXAlgCFYUserDataManager : NSObject

//自定义key保存  增/改
+(void)saveValue:(id)object forKey:(NSString *)key;
//根据某个key读某个值 查
+(id)readKey:(NSString *)key;
//根据某个key删掉某个值 删
+(void)deleteKey:(NSString *)key;

//删除本App在keyChain中存储的所有数据
+(void)deleteKeyChain;

//读取本app在KeyChain中存储的所有值
+(id)readKeyDic;

@end

NS_ASSUME_NONNULL_END
