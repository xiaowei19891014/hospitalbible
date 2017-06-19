//
//  CommonMethod.h
//  HospitalBible
//
//  Created by xiaowei on 2017/6/19.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonMethod : NSObject

+ (NSDate*)getDateFromDateStr:(NSString*)dateStr;
+ (NSString *)getDateStrWithDate:(NSDate*)someDate withCutStr:(NSString*)cutStr hasTime:(BOOL)hasTime;


@end
