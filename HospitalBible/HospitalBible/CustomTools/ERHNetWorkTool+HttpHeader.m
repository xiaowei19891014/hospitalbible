//
//  ERHNetWorkTool+HttpHeader.m
//  EIntegrate
//
//  Created by Walker on 2016/12/1.
//  Copyright © 2016年 CGL. All rights reserved.
//

#import "ERHNetWorkTool+HttpHeader.h"
#import <CommonCrypto/CommonDigest.h>

@implementation ERHNetWorkTool (HttpHeader)

- (NSDictionary*)getERHHttpHeaders
{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    [formatDay setLocale:[NSLocale systemLocale]];
    [formatDay setTimeZone:[NSTimeZone systemTimeZone]];
//    [formatDay setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    formatDay.dateFormat = @"yyyyMMdd";
    
    NSDateFormatter *formatTime = [[NSDateFormatter alloc] init];
//    [formatTime setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatDay setLocale:[NSLocale systemLocale]];
    [formatDay setTimeZone:[NSTimeZone systemTimeZone]];
    formatTime.dateFormat = @"HHmmss";
    
    NSString *uuid = [self createUUID];
    NSString *dayStr = [formatDay stringFromDate:now];
    NSString *timeStr = [formatTime stringFromDate:now];
    
//    NSDictionary *dict =   @{@"clentid":kAppkey,
//                             @"uuid":uuid,
//                             @"userid":@"",
//                             @"acton":@"",
//                             @"chnflg":@"1",
//                             @"trandt":dayStr,
//                             @"trantm":timeStr,
//                             @"transSeqNo":uuid
//                             //,@"keyversion":@"1"
//                             };
//    if ([[ERHAuthorizeInfo sharedManager] isLogined]) {
//        NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
//        [mutableDict setValue:([ERHAuthorizeInfo sharedManager].Cookie ? [ERHAuthorizeInfo sharedManager].Cookie : @"") forKey:@"Cookie"];
//        [mutableDict setValue:([ERHAuthorizeInfo sharedManager].userId ? [ERHAuthorizeInfo sharedManager].userId : @"") forKey:@"userid"];
//        [mutableDict setValue:([ERHAuthorizeInfo sharedManager].accessToken ? [ERHAuthorizeInfo sharedManager].accessToken : @"") forKey:@"acton"];
//        return mutableDict;
//    }
    return nil;
}

-(NSString*)createUUID {
    CFUUIDRef uuid = CFUUIDCreate(nil);
    CFStringRef cfstring = CFUUIDCreateString(kCFAllocatorDefault, uuid);
    const char *cStr = CFStringGetCStringPtr(cfstring,CFStringGetFastestEncoding(cfstring));
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result );
    CFRelease(cfstring);
    CFRelease(uuid);
    
    NSString * _openUDID = [NSString stringWithFormat:
                            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                            result[0], result[1], result[2], result[3],
                            result[4], result[5], result[6], result[7],
                            result[8], result[9], result[10], result[11],
                            result[12], result[13], result[14], result[15]];
    return _openUDID;
}

@end
