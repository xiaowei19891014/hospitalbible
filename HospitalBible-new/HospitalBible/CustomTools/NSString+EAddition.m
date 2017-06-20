//
//  NSString+EAddition.m
//  ECommerce
//
//  Created by SuWang on 14-4-7.
//  Copyright (c) 2014年 SuWang. All rights reserved.
//

#import "NSString+EAddition.h"

@implementation NSString (EAddition)
- (BOOL)isStartWithString:(NSString*)start
{
    BOOL result = FALSE;
    NSRange found = [self rangeOfString:start options:NSCaseInsensitiveSearch];
    if (found.location == 0)
    {
        result = TRUE;
    }
    return result;
}

- (NSURL *)converURL
{
    NSURL *url = [NSURL URLWithString:self];
    return url;
}


- (CGSize )sizeForWidth:(CGFloat )width andTextSize:(CGFloat )fontSize
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:kFONT(fontSize), NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize  labelSize = [self boundingRectWithSize:CGSizeMake(width, 1999)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:attributes
                                           context:nil].size;
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    return labelSize;
}

- (BOOL)isEmpty
{
    return self.length == 0;
}

- (BOOL)isNotEmpty
{
    return self.length != 0;
}

- (BOOL)isPhone
{
  return self.length == 11;
}

- (NSString *)trimBlank
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (BOOL)isValue:(NSString *)value
{
    return [self isEqualToString:value];
}

- (NSDate *)toDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter dateFromString:self];
}

- (NSString *)add:(NSString *)addStr
{
    return [self stringByAppendingString:addStr];
}

- (NSString *)maskPhoneNumber
{
    return [self stringByReplacingCharactersInRange:NSMakeRange(3,4) withString:@"****"];
}

- (NSString *)toMoneyStr
{
    return @"";
}

- (BOOL)isContain:(NSString *)str
{
    NSRange a = [self rangeOfString:str];
    return a.location != NSNotFound;
}

- (NSString *)toDateStrng {
    NSString *str1 = [self stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
    str1 = [str1 stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
    str1 = [str1 stringByReplacingOccurrencesOfString:@"日" withString:@""];
    return str1;
}

- (NSString *)toSex{
    return [self isEqualToString:@"男"] ? @"M" : @"F" ;
}
@end
