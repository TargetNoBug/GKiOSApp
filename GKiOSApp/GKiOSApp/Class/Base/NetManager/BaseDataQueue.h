//
//  BaseDataQueue.h
//  GKiOSApp
//
//  Created by wangws1990 on 2019/5/15.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseDataQueue : NSObject
/**
 *  @brief 插入数据
 */
+ (void)insertDataToDataBase:(NSDictionary *)userInfo completion:(void(^)(BOOL success))completion;
/**
 *  @brief 数据更新
 */
+ (void)updateDataToDataBase:(NSDictionary *)userInfo completion:(void(^)(BOOL success))completion;
/**
 *  @brief 删除数据
 */
+ (void)deleteDataToDataBase:(NSString *)userId completion:(void(^)(BOOL success))completion;
/**
 *  @brief 使用事务来处理批量插入数据问题 效率比较高
 */
+ (void)insertDatasDataBase:(NSArray <NSDictionary *>*)listData completion:(void(^)(BOOL success))completion;
/**
 *  @brief 获取数据
 */
+ (void)getDatasFromDataBase:(void(^)(NSArray <NSDictionary *>*listData))completion;
+ (void)getDatasFromDataBase:(NSString *)userId completion:(void(^)(NSDictionary *dictionary))completion;
/**
 *  @brief 删除表
 */
+ (void)dropTheTableGroupDataBase:(void (^)(BOOL))completion;
@end

NS_ASSUME_NONNULL_END
