//
//  ERHHtmlAnalysisTool.h
//  HppleDemo
//
//  Created by LIFEI on 2017/2/27.
//
//

#import <Foundation/Foundation.h>

@interface ERHHtmlAnalysisTool : NSObject
+(ERHHtmlAnalysisTool*)shareERHHtmlAnalysisTool;
-(NSString*)getNewHtmlStringWithOriginalHtmlString:(NSString*)htmlStr;
//首页公告信息html
-(NSString*)getMessageHtmlStringWithOriginalHtmlString:(NSString*)htmlStr;

@end
