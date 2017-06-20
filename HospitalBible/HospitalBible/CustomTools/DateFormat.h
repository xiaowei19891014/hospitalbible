//
//  DateFormat.h
//  EIntegrate
//
//  Created by Granger on 2017/2/14.
//  Copyright © 2017年 CGL. All rights reserved.
//

#import <Foundation/Foundation.h>

/// yyyy年M月d日
#define DATEFORMAT          @"yyyy年M月d日"
/// yyyy年MM月dd日
#define DATEFORMAT2         @"yyyy年MM月dd日"
///  yyyy年MM月dd日 HH:mm:ss
#define DATEFORMAT3         @"yyyy年MM月dd日 HH:mm:ss"
///  yyyy年MM月dd日(EEE)
#define DATEFORMAT4         @"yyyy年MM月dd日(ccc)"
///  yyyy/MM/dd HH:mm:ss
#define DATEFORMAT5         @"yyyy/MM/dd HH:mm:ss"
///  yyyy/MM/dd
#define DATEFORMAT6         @"yyyy/MM/dd"
///  yyyy年MM月dd日(EEE) HH:mm:ss
#define DATEFORMAT7			@"yyyy年MM月dd日(ccc) HH:mm:ss"
///  yyyy年MM月
#define DATEFORMAT8			@"yyyy年MM月"
///  yyyy/MM
#define DATEFORMAT9         @"yyyy/MM"
///  HH:mm:ss
#define DATEFORMAT10		@"HH:mm:ss"
///  YYYYMMDDHHMMSS
/*!
 * @brief YYYYMMDDHHMMSS
 */
#define DATEFORMAT11        @"yyyyMMddHHmmss"
///  yyyy/MM/dd HH:mm
#define DATEFORMAT12        @"yyyy/MM/dd HH:mm"
/// yyyyMMddHHmm
#define DATEFORMAT13        @"yyyyMMddHHmm"
///  yyyy年MM月dd日(EEE)HH:mm
#define DATEFORMAT14		@"yyyy年MM月dd日(ccc)HH:mm"
///  yyyyMMdd
#define DATEFORMAT15		@"yyyyMMdd"
/// HH:mm
#define DATEFORMAT16        @"HH:mm"
/// HHmmss
#define DATEFORMAT17        @"HHmmss"
/// HHmm
#define DATEFORMAT18        @"HHmm"
/// yyyy-MM-dd HH-mm-ss
#define DATEFORMAT19        @"yyyy-MM-dd HH-mm-ss"
/// HH
#define DATEFORMAT20        @"HH"
/// mm
#define DATEFORMAT21        @"mm"
/// ss
#define DATEFORMAT22        @"ss"
/// yyyy-MM-dd HH:mm
#define DATEFORMAT23        @"yyyy-MM-dd HH:mm"
/// yyyy-MM-dd HH:mm:ss
#define DATEFORMAT24        @"yyyy-MM-dd HH:mm:ss"
/// yyyyMMddHHmmssSSSS
#define DATEFORMAT25        @"yyyyMMddHHmmssSSSS"
/// mm:ss
#define DATEFORMAT26        @"mm:ss"
///yyyy.MM.dd
#define DATEFORMAT27        @"yyyy.MM.dd"
///yyyy-MM-dd
#define DATEFORMAT28        @"yyyy-MM-dd"

///yyMMddHHmmss
#define DATEFORMAT29        @"yyMMddHHmmss"
///MMddHHmm
#define DATEFORMAT30        @"MMddHHmm"
///MM-dd HH:mm
#define DATEFORMAT31        @"MM-dd HH:mm"
#define DATEFORMAT32        @"MM-dd HH:mm:ss"
@interface DateFormat : NSObject
{
    NSDateFormatter *formatter;
}

//实例化
+(DateFormat*)share;

/*!
 * @brief   将日期转换成字符串
 * @param   date 日期
 * @param   type 日期格式
 * @return  NSString 日期转换后的字符串
 */
- (NSString*)convertDate:(NSDate*)date type:(NSString*)type;
/*!
 * @brief   将时间戳转换成字符串
 * @param   timeInterval 时间戳
 * @param   type 字符串格式
 * @return  NSString 日期转换后的字符串
 */
- (NSString *)convertTimeInterval:(NSInteger)timeInterval type:(NSString *)type;

/*!
 * @brief   将字符串转换成日期
 * @param   dateStr 日期字符串
 * @param   type    字符串的时间格式
 * @return  NSDate  字符串转换后生成的日期
 */
- (NSDate*)convertString:(NSString*)dateStr type:(NSString*)type;

/*!
 * @brief   将时间字符串转换成指定的时间字符串
 * @param   dateStr  需要转换的时间字符串
 * @param   type     字符串当前格式
 * @param   aType    目的字符串格式
 * @return  NSString 转换后字符串
 */
- (NSString*)convertString:(NSString*)dateStr fromType:(NSString *)type toType:(NSString *)aType;
/*!
 * @brief   获取当前时间字符串
 * @param   type 时间格式
 * @return  NSString 时间字符串
 */
- (NSString*)convertNowType:(NSString*)type;

/*!
 * @brief   判断两个日期是处于同一年，同一月，同一个星期，同一天
 * @param   firstDate
 * @param   secondDate
 * @return  满足条件返回YES,反之NO
 */
- (BOOL)sameYear:(NSDate*)firstDate date:(NSDate*)secondDate;
- (BOOL)sameMonth:(NSDate*)firstDate date:(NSDate*)secondDate;
- (BOOL)sameWeek:(NSDate*)firstDate date:(NSDate*)secondDate;
- (BOOL)sameDay:(NSDate*)firstDate date:(NSDate*)secondDate;

/*!
 * @brief 判断日期与现在是处于同一年，同一月，同一个星期，同一天
 */
- (BOOL)sameYearCompareNow:(NSDate*)date;
- (BOOL)sameMonthCompareNow:(NSDate*)date;
- (BOOL)sameWeekCompareNow:(NSDate*)date;
- (BOOL)sameDayCompareNow:(NSDate*)date;

/*!
 * @brief 判断时间是否早于或晚于今天
 */
- (BOOL)earlierNow:(NSDate*)date;
- (BOOL)laterNow:(NSDate*)date;
/*!
 * @brief 当前时间与某一时间之间相差自然天数
 */
- (NSInteger)daysCompareNow:(NSDate*)date;

/*!
 * @brief 以今天为标准格式化时间，输出时间字符串
 */
- (NSString *)formatDatetimeSinceNowWithDate:(NSDate *)date;

/*!
 * @brief   获取某个日期的间隔几天的日期
 * @param   type 时间格式
 * @return  NSString 时间字符串
 */
-(NSDate *)formatDateGetAnotherDate:(NSDate*)date disDays:(int)days;

@end
