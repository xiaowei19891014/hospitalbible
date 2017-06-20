//
//  EUnit.m
//  Art88
//
//  Created by BaH Cy on 14/12/21.
//  Copyright (c) 2014年 suwang. All rights reserved.
//
#define myDotNumbers     @"0123456789.\n"
#define myNumbers        @"0123456789\n"

#import "EUnit.h"
#import "AppDelegate.h"
#import "NSString+EAddition.h"

#define kFrame(x,y,width,height)    CGRectMake(x, y, width, height)
#define kSize(width,height)         CGSizeMake(width,height)
#define kBOUNDS                     self.view.bounds
#define kWIDTH                      [AppDelegate currentDelegate].window.width
#define kHEIGHT                     [AppDelegate currentDelegate].window.height

#define ISIPHONE3_5  CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) || CGSizeEqualToSize(CGSizeMake(480, 320), [[UIScreen mainScreen] bounds].size)
#define ISIPHONE4_0  CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) || CGSizeEqualToSize(CGSizeMake(568, 320), [[UIScreen mainScreen] bounds].size)
#define ISIPHONE4_7  CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) || CGSizeEqualToSize(CGSizeMake(667, 375), [[UIScreen mainScreen] bounds].size)
#define ISIPHONE5_5  CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) || CGSizeEqualToSize(CGSizeMake(736, 414), [[UIScreen mainScreen] bounds].size)
#define ISIPHONE9_7  CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] bounds].size) || CGSizeEqualToSize(CGSizeMake(1024, 768), [[UIScreen mainScreen] bounds].size)

@implementation EUnit

+ (void)showToastWithTitle:(NSString *) titleStr
{
    CGSize titleSize = [titleStr sizeForWidth:kWIDTH andTextSize:13];
    
    UIView *toastView = [[UIView alloc] initWithFrame:kFrame(0, 0, titleSize.width + 16, [self getLengthWithSizeType:ESizeType4_7 andLength:50.f])];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:kFrame(0, 0, titleSize.width + 10, [self getLengthWithSizeType:ESizeType4_7 andLength:50.f])];
    
    UIView *bgView = [[UIView alloc] initWithFrame:toastView.bounds];
    [bgView setBackgroundColor:kCOLOR(blackColor)];
    [bgView setAlpha:0.7f];
    [toastView addSubview:bgView];
    
    [titleLabel setBackgroundColor:kCOLOR(clearColor)];
    [titleLabel setTextColor:kCOLOR(whiteColor)];
    [titleLabel setFont:kFONT(12.f)];
    [titleLabel setText:titleStr];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setCenter:toastView.center];
    [toastView addSubview:titleLabel];
    
    [toastView setBackgroundColor:kCOLOR(clearColor)];
    [toastView.layer setMasksToBounds:YES];
    [toastView.layer setCornerRadius:3];
    
    [toastView setCenter:kPoint(kWIDTH/2, kHEIGHT/2 )];
    [[AppDelegate currentDelegate].window addSubview:toastView];
    [toastView setAlpha:0];
    
    [UIView animateWithDuration:0.35 animations:^{
        [toastView setAlpha:1];
    } completion:^(BOOL finished) {
        double delayInSeconds = 1.0;
        dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_queue_t concurrentQueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.35 animations:^{
                    [toastView setAlpha:0];
                } completion:^(BOOL finished) {
                    [toastView removeFromSuperview];
                }];
            });
        });
    }];
}

+ (CGFloat)heightWithText:(NSString *)string WithFont:(UIFont *)font inWidth:(CGFloat ) width
{
    static UILabel *heightLabel;
    if (!heightLabel) {
        static dispatch_once_t one_token;
        dispatch_once(&one_token, ^{
            heightLabel = [[UILabel alloc] init];
            [heightLabel setNumberOfLines:0];
            [heightLabel setFont:font];
        });
    }
    [heightLabel setFrame:kFrame(0, 0, width, CGFLOAT_MAX)];
    [heightLabel setText:string];
    [heightLabel sizeToFit];
    return [heightLabel height];
}

+ (CGFloat)textWidthFromTextString:(NSString *)text height:(CGFloat)textHeight fontSize:(CGFloat)size
{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, textHeight) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width;
}

+ (CGFloat)getLengthWithSizeType:(ESizeType)sizeType andLength:(CGFloat)length
{
    CGFloat resultLength = length * [[self multiplicative][@([self getCurrentSizeType])] doubleValue] / [[self multiplicative][@(sizeType)] doubleValue];
    resultLength = ceil(resultLength);
    return resultLength;
}

+ (CGFloat)getLenght:(CGFloat)lenght
{
   return [EUnit getLengthWithSizeType:ESizeType4_7 andLength:lenght];
}

+ (ESizeType)getCurrentSizeType
{
    static ESizeType currentSizeType = ESizeTypeNone;
    
    if (currentSizeType == ESizeTypeNone) {
        if (ISIPHONE3_5) {
            currentSizeType = ESizeType3_5;
        }
        else if (ISIPHONE4_0) {
            currentSizeType = ESizeType4_0;
        }
        else if (ISIPHONE4_7) {
            currentSizeType = ESizeType4_7;
        }
        else if (ISIPHONE5_5) {
            currentSizeType = ESizeType5_5;
        }
        else if (ISIPHONE9_7) {
            currentSizeType = ESizeType9_7;
        }
    }
    
    return currentSizeType;
}

+ (NSDictionary *)multiplicative
{
    return @{@0:@0,
             @1:@320,
             @2:@320,
             @3:@375,
             @4:@414,
             @5:@768};
}

+ (void)saveLocation:(NSString *)key value:(NSString *)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
}

+ (NSString *)getLocation:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [defaults valueForKey:key];
    return value ? : @"";
}

+ (BOOL)moenyTextField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
     replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]||[string isEqualToString:@""]) { //按下return
        return YES;
    }
    
    NSCharacterSet *cs;
    NSUInteger nDotLoc = [textField.text rangeOfString:@"."].location;
    if (NSNotFound == nDotLoc && 0 != range.location) {
        cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
        if ([string isEqualToString:@"."]) {
            return YES;
        }
        //小数点前面6位
        if (textField.text.length >= 6) {
            return NO;
        }
    }
    else {
        cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
        if (textField.text.length >= 9) {
            return  NO;
        }
    }
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
        return NO;
    }
    
    //小数点后面两位
    if (NSNotFound != nDotLoc && range.location > nDotLoc + 2 ) {
        return NO;
    }
    
    if (NSNotFound != nDotLoc && range.location <= nDotLoc + 2 && [string isEqualToString:@"."]) {
        return NO;
    }
    
    if (NSNotFound == nDotLoc && [string isEqualToString:@"."]) {
        [textField setText:@"0"];
    }
    
    return YES;
}

+ (NSMutableAttributedString *)mString:(NSString *)mString addString:(NSString *)addString font:(UIFont *)font changeFont:(UIFont *)changeFont color:(UIColor *)color changeColor:(UIColor  *)changeColor isAddLine:(BOOL)isAddLine lineColor:(UIColor *)lineColor
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:mString attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font}];
    [attributedString setAttributes:@{NSForegroundColorAttributeName:changeColor,NSFontAttributeName:changeFont} range:[mString rangeOfString:addString]];
    if (isAddLine) {
        [attributedString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:[mString rangeOfString:addString]];
        [attributedString addAttribute:NSStrikethroughColorAttributeName value:lineColor range:[mString rangeOfString:addString]];
    }
    return  attributedString;
}

+ (NSString *)beautifyString:(NSString *)originalString{
    NSString *returnStr = @"";

    for (NSInteger i = 0; i< (originalString.length); i++) {
        NSString *str = [originalString substringWithRange:NSMakeRange(i, 1)];
        returnStr = [returnStr stringByAppendingString:str];
        if (i%4 == 3) {
          returnStr = [returnStr stringByAppendingString:@" "];
        }
    }
    return returnStr;
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
            service, (__bridge_transfer id)kSecAttrService,
            service, (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible,
            nil];
}

/** 根据答案 排序，转小写 **/
+ (NSString *)sortWithLowercaseString:(NSMutableArray *)listData
{
    NSArray *sortData = [listData sortedArrayUsingSelector:@selector(compare:)];
    NSString *text = @"";
    for (NSString *string in sortData) {
        NSString *result = [string substringWithRange:NSMakeRange(0, 1)];
        text = [text stringByAppendingString:result];
    }
    return text;
}

/** 每日一句**/
+ (NSString *)everyDayInfoOneEnglish
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSInteger day = comps.day;
    NSString *text = nil;
    switch (day) {
        case 1:
            text = @"Genius is one percent inspiration, ninety-nine percent perspiration.\n天才是1%的天分加99%的努力.";
            break;
        case 2:
            text = @"Life is not fair, get used to it.\n生活是不公平的；要去适应它。";
            break;
        case 3:
            text = @"All for one, one for all. \n人人为我，我为人人";
            break;
        case 4:
            text = @"Knowledge is power.\n知识就是力量。";
            break;
        case 5:
            text = @"I am a slow walker , but I never walk backwards.\n我走得很慢，但是我从来不会后退。";
            break;
        case 6:
            text = @"He who seize the right moment, is the right man. \n谁把握机遇，谁就心想事成。";
            break;
        case 7:
            text = @"Stay Hungry, Stay Foolish\n求知若渴,大智若愚 ";
            break;
        case 8:
            text = @"Attitude is a little thing that makes a big difference.\n态度决定一切。";
            break;
        case 9:
            text = @"Genius is one percent inspiration, ninety-nine percent perspiration.\n天才是1%的天分加99%的努力。";
            break;
        case 10:
            text = @"Where there is a will , there is a way. \n有志者，事竟成。";
            break;
        case 11:
            text = @"Courage is resistance to fear, mastery of fear; not absence of fear.\n勇气是征服恐惧，并不是没有恐惧。";
            break;
        case 12:
            text = @"The two most powerful warriors are patience and time.\n时间与耐心是最强大的两个战士。";
            break;
        case 13:
            text = @"Art is a lie that tells the truth. ——Pablo Picasso\n艺术是揭示真理的谎言";
            break;
        case 14:
            text = @"I have a dream ... \n我有一个梦想 ";
            break;
        case 15:
            text = @"A man can be destroyed but not defeated. \n人可以被毁灭，但不可以被打败。";
            break;
        case 16:
            text = @"I am a slow walker , but I never walk backwards.\n我走得很慢，但是我从来不会后退。";
            break;
        case 17:
            text = @"Never leave that until tomorrow , which you can do today.\n今天的事不要拖到明天。";
            break;
        case 18:
            text = @"The first wealth is health.\n健康是人生第一财富。";
            break;
        case 19:
            text = @"Temperance is a mean with regard to pleasures.\n节制是一条通向快乐的道路。";
            break;
        case 20:
            text = @"Patience is bitter, but its fruit is sweet.\n 忍耐是痛苦的，但它的果实是甜蜜的。";
            break;
        case 21:
            text = @"This above all: to thine self be true. \n最重要的是，你必须对自己忠实。";
            break;
        case 22:
            text = @"Act enthusiastic and you will be enthusiastic. \n凡是积极主动，你会变得充满热情。 ";
            break;
        case 23:
            text = @"You have to believe in yourself. That’s the secret of success.\n必须相信自己，这是成功的秘诀。";
            break;
        case 24:
            text = @"Other men live to eat, while I eat to live.\n别人为食而生存，我为生存而食。";
            break;
        case 25:
            text = @"If winter comes，can spring be far behind？\n冬天来了，春天还会远吗？";
            break;
        case 26:
            text = @"Intellectuals solve problems; geniuses prevent them.\n智者解决问题，天才预防问题.";
            break;
        case 27:
            text = @"The first and greatest victory is to conquer yourself.\n第一个最伟大的胜利就是战胜自己。";
            break;
        case 28:
            text = @"Temperance is a mean with regard to pleasures.\n节制是一条通向快乐的道路。";
            break;
        case 29:
            text = @"We come nearest to the great when we are great in humility.\n当我们极谦卑时，则几近於伟大。";
            break;
        case 30:
            text = @"Victory belongs to the most persevering.\n坚持到底必将成功。";
            break;
        case 31:
            text = @"Patience is bitter, but its fruit is sweet.\n 忍耐是痛苦的，但它的果实是甜蜜的。";
            break;
        default:
            break;
    }
    return text;
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    NSLog(@"获取手机唯一ID:%@",ret);
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}

+ (NSString *)UUID{
    return  [[UIDevice currentDevice].identifierForVendor UUIDString];
}

+ (NSString *)level{

#if EnglishOne
    return @"1";
#endif

#if EnglishTwo
    return @"2";
#endif
    
#if EnglishThree
    return @"3";
#endif
    abort();
}
@end


