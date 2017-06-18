//
//  EUnit.h
//  Art88
//
//  Created by BaH Cy on 14/12/21.
//  Copyright (c) 2014年 suwang. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum ESizeType
{
    ESizeTypeNone = 0,
    ESizeType3_5,
    ESizeType4_0,
    ESizeType4_7,
    ESizeType5_5,
    ESizeType9_7,
} ESizeType;


@interface EUnit : NSObject

/*!
 @brief 显示吐司
 @param titleStr 显示的吐司内容
 */
+ (void)showToastWithTitle:(NSString *) titleStr;

/*!
 @brief 得到在一定的宽度范围内得到高度
 @param sting 计算的字符
 @param font  字体样式
 @param width 宽度
 */

+ (CGFloat)heightWithText:(NSString *) string WithFont:(UIFont *) font inWidth:(CGFloat ) width;

+ (CGFloat)getLengthWithSizeType:(ESizeType)sizeType andLength:(CGFloat)length;

/**
 *  根据字符串内容的多少  在固定高度 下计算出实际的行宽
 *
 *  @param text       需要计算的内容
 *  @param textHeight 设定的显示高度
 *  @param size       字体的大小
 *
 *  @return 宽度
 */
+ (CGFloat)textWidthFromTextString:(NSString *)text height:(CGFloat)textHeight fontSize:(CGFloat)size;

+ (CGFloat)getLenght:(CGFloat)lenght;

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

+ (void)save:(NSString *)service data:(id)data ;

+ (id)load:(NSString *)service ;

+ (void)delete:(NSString *)service ;

+ (NSString *)UUID;

+ (NSString *)level;

/** 保存本地 */
+(void)saveLocation:(NSString *)key value:(NSString *)value;

/** 得到某个值 */
+(NSString *)getLocation:(NSString *)key;

/** 只限制输入金额 例如:19.00 */
+ (BOOL)moenyTextField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
     replacementString:(NSString *)string;


/** 根据答案 排序，转小写 **/
+ (NSString *)sortWithLowercaseString:(NSMutableArray *)listData;

/** 每日一句**/
+ (NSString *)everyDayInfoOneEnglish;

/*!
 * 根据字符串范围设置字符串效果
 */
+ (NSMutableAttributedString *)mString:(NSString *)mString addString:(NSString *)addString font:(UIFont *)font changeFont:(UIFont *)changeFont color:(UIColor *)color changeColor:(UIColor  *)changeColor isAddLine:(BOOL)isAddLine lineColor:(UIColor *)lineColor;

/*!
 * 把字符串每隔4个字符加一个空格
 */
+ (NSString *)beautifyString:(NSString *)originalString;
@end
