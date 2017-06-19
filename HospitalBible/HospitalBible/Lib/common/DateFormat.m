//
//  DateFormat.m
//  EIntegrate
//  时间格式化
//  Created by Granger on 2017/2/14.
//  Copyright © 2017年 CGL. All rights reserved.
//

#import "DateFormat.h"

@implementation DateFormat

/*!
 * @brief 实例化方法
 */
+ (DateFormat *)share
{
    static DateFormat *shareDateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareDateFormatter = [[DateFormat alloc] init];
        
    });
    return shareDateFormatter;
}

- (instancetype)init{
    if (self = [super init]) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale systemLocale]];
        [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    }
    return self;
}

/*!
 * @brief   将日期转换成字符串
 * @param   type 日期格式
 * @param   date 日期
 * @return  NSString 日期转换后的字符串
 */
- (NSString *)convertDate:(NSDate *)date type:(NSString *)type
{
    //    NSLocale *locale_zh;
    //    locale_zh = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    [formatter setDateFormat:type];
    //    [formatter setLocale:[NSLocale systemLocale]];
    return [formatter stringFromDate:date];
}

/*!
 * @brief   将时间戳转换成字符串
 * @param   timeInterval 时间戳
 * @param   type 字符串格式
 * @return  NSString 日期转换后的字符串
 */
- (NSString *)convertTimeInterval:(NSInteger)timeInterval type:(NSString *)type
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [self convertDate:date type:type];
}
/*!
 * @brief   将字符串转换成日期
 * @param   type 日期格式
 * @param   dateStr  日期字符串
 * @return  NSDate 字符串转换后生成的日期
 */
- (NSDate *)convertString:(NSString *)dateStr type:(NSString *)type
{
    //    NSLocale *locale_zh;
    //    locale_zh = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    [formatter setDateFormat:type];
    //    [formatter setLocale:locale_zh];
    return [formatter dateFromString:dateStr];
}

/*!
 * @brief   将时间字符串转换成指定的时间字符串
 * @param   dateStr 需要转换的时间字符串
 * @param   type 字符串当前格式
 * @param   aType 目的字符串格式
 * @return  NSString 转换后字符串
 */

- (NSString*)convertString:(NSString *)dateStr fromType:(NSString *)type toType:(NSString *)aType
{
    NSDate *date = [self convertString:dateStr type:type];
    NSString *str = [self convertDate:date type:aType];
    if(!str)
        return @"";
    return str;
}

/*!
 * @brief   获取当前时间字符串
 * @param   type 时间格式
 * @return  NSString 时间字符串
 */
-(NSString *)convertNowType:(NSString *)type
{
    return [self convertDate:[NSDate date] type:type];
}

- (BOOL)sameYear:(NSDate*)firstDate date:(NSDate*)secondDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:firstDate];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:secondDate];
    if ([comp1 year] == [comp2 year]) {
        return YES;
    }
    return NO;
}
- (BOOL)sameMonth:(NSDate*)firstDate date:(NSDate*)secondDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:firstDate];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:secondDate];
    if ([comp1 year] == [comp2 year] && [comp1 month] == [comp2 month]) {
        return YES;
    }
    return NO;
}

- (BOOL)sameWeek:(NSDate*)firstDate date:(NSDate*)secondDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:firstDate];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:secondDate];
    if ([comp1 year] == [comp2 year] && [comp1 month] == [comp2 month] && [comp1 weekOfMonth] == [comp2 weekOfMonth]) {
        return YES;
    }
    return NO;
}

- (BOOL)sameDay:(NSDate*)firstDate date:(NSDate*)secondDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:firstDate];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:secondDate];
    if ([comp1 year] == [comp2 year] && [comp1 month] == [comp2 month] && [comp1 day] == [comp2 day]) {
        return YES;
    }
    return NO;
}

- (BOOL)sameYearCompareNow:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    if ([comp1 year] == [comp2 year]) {
        return YES;
    }
    return NO;
}
- (BOOL)sameMonthCompareNow:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    if ([comp1 year] == [comp2 year] && [comp1 month] == [comp2 month]) {
        return YES;
    }
    return NO;
}
- (BOOL)sameWeekCompareNow:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    if ([comp1 year] == [comp2 year] && [comp1 month] == [comp2 month] && [comp1 weekOfMonth] == [comp2 weekOfMonth]) {
        return YES;
    }
    return NO;
}
- (BOOL)sameDayCompareNow:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    if ([comp1 year] == [comp2 year] && [comp1 month] == [comp2 month] && [comp1 day] == [comp2 day]) {
        return YES;
    }
    return NO;
}

- (BOOL)earlierNow:(NSDate *)date
{
    if (NSOrderedAscending == [date compare:[NSDate date]]) {
        return YES;
    }
    return NO;
}

- (BOOL)laterNow:(NSDate *)date
{
    if (NSOrderedDescending == [date compare:[NSDate date]]) {
        return YES;
    }
    return NO;
}
- (NSInteger)daysCompareNow:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    if (comp2.year - comp1.year >= 1) {
        return 2;
    }
    if (comp2.year - comp1.year < 0) {
        return 0;
    }
    if (comp2.month - comp1.month >= 1) {
        return 2;
    }
    if (comp2.month - comp1.month < 0) {
        return 0;
    }
    if (comp2.day - comp1.day >= 1) {
        return 2;
    }
    return 0;
}

- (NSString *)formatDatetimeSinceNowWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if ([comp1 year] != [comp2 year]) {
        /// 显示年月日yyyy-MM-dd
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        return [dateFormatter stringFromDate:date];
    }
    
    if ([comp1 year] == [comp2 year] && [comp1 month] == [comp2 month] && [comp1 day]== [comp2 day]) {
        /// 显示时间HH:mm
        dateFormatter.dateFormat = @"HH:mm";
        return [dateFormatter stringFromDate:date];
    }
    
    /// 显示月日MM-dd
    dateFormatter.dateFormat = @"MM-dd";
    return [dateFormatter stringFromDate:date];
}

/*!
 * @brief   获取某个日期的间隔几天的日期
 * @param   type 时间格式
 * @return  NSString 时间字符串
 */
-(NSDate *)formatDateGetAnotherDate:(NSDate*)date disDays:(int)days{
    NSDate *anotherDate;
    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
    anotherDate = [[NSDate alloc] initWithTimeInterval:+oneDay*days sinceDate:date];
    return anotherDate;
}

@end
