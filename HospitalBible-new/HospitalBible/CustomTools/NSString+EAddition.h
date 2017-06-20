//
//  NSString+EAddition.h
//  ECommerce
//
//  Created by SuWang on 14-4-7.
//  Copyright (c) 2014年 SuWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EAddition)

/** 判断是否已某个字符开始 */
- (BOOL)isStartWithString:(NSString*)start;

/** 转成URL */
- (NSURL *)converURL;

/** 得到字符串的大小 */
- (CGSize )sizeForWidth:(CGFloat )width andTextSize:(CGFloat )fontSize;

/** 是否为空 */
- (BOOL)isEmpty;

/** 不为空 */
- (BOOL)isNotEmpty;

/** 去除空格 */
- (NSString *)trimBlank;

/** 是否是手机号 */
- (BOOL)isPhone;

/** 是否是某个值 */
- (BOOL)isValue:(NSString *)value;

/** 字符串转成时间 */
- (NSDate *)toDate;

/** 追加字符*/
- (NSString *)add:(NSString *)addStr;

/** 转换手机号掩码 */
- (NSString *)maskPhoneNumber;

/** 转换为金额 */
- (NSString *)toMoneyStr;

- (BOOL)isContain:(NSString *)str;

- (NSString *)toDateStrng ;

- (NSString *)toSex;

+(BOOL)isValidID:(NSString*)identityString;

@end
