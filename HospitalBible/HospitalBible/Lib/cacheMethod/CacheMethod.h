//
//  CacheMethod.h
//  PensionTreasure
//
//  Created by xiaowei on 16/8/2.
//  Copyright © 2016年 柳宣泽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CacheMethod : NSObject


+(void)cacheArray:(NSArray *)object forKey:(NSString *)key;

+(void)cacheNSDictory:(NSDictionary *)object forKey:(NSString *)key;


+(NSArray *)getTheCacheArrayWithKey:(NSString*)key;
+(NSDictionary *)getTheCacheDictoryWithKey:(NSString*)key;


+(void)cleanCacheWithKey:(NSString*)key;


+(void)userDefaultSetValue:(NSString *)str forKey:(NSString *)key;


+ (id )userDefaultvalueForKey:(NSString *)key;
+ (NSString *)filePathWithName:(NSString *)name;

@end
