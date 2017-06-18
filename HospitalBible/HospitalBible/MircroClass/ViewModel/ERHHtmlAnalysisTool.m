//
//  ERHHtmlAnalysisTool.m
//  HppleDemo
//
//  Created by LIFEI on 2017/2/27.
//
//

#import "ERHHtmlAnalysisTool.h"
#import "TFHpple.h"
static ERHHtmlAnalysisTool *tool = nil;
@implementation ERHHtmlAnalysisTool

+(ERHHtmlAnalysisTool*)shareERHHtmlAnalysisTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[ERHHtmlAnalysisTool alloc] init];
    });
    return tool;
}

-(NSString*)getNewHtmlStringWithOriginalHtmlString:(NSString*)htmlStr{
    
    NSString *textColor = nil;

    textColor =@"body {margin-left: 30px;margin-right: 30px;font-size: 32px;color: #333;background-color: #ffffff;}";
        

    NSString *html = [NSString stringWithFormat:@"<!DOCTYPE html><html><head lang=\"en\"><meta charset=\"UTF-8\"><style type=\"text/css\"> %@</style></head><body>%@</body></html>",textColor,htmlStr];
    NSMutableString *mutableStr = [[NSMutableString alloc]initWithString:html];
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple * doc      = [[TFHpple alloc] initWithHTMLData:data];
    NSArray * elements = [doc searchWithXPathQuery:@"//img"];
    for (int i = 0; i < elements.count; i++) {
        TFHppleElement * e = [elements objectAtIndex:i];
        if ([e objectForKey:@"href"]) {
            NSDictionary *dict = [e attributes];
            NSRange range = [mutableStr rangeOfString:dict[@"href"]];
            [mutableStr replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%@",dict[@"href"]]];
        }else{
            NSDictionary *dict = [e attributes];
            NSRange range = [mutableStr rangeOfString:dict[@"src"]];
            [mutableStr replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%@",dict[@"src"]]];
        }
    }
    return mutableStr;
}
-(NSString*)getMessageHtmlStringWithOriginalHtmlString:(NSString*)htmlStr
{
    NSString *textColor = nil;

    textColor =@"body {margin-left: 30px;margin-right: 30px;font-size: 32px;color: #333;background-color: #ffffff;}";
    NSString *html = [NSString stringWithFormat:@"<!DOCTYPE html><html><head lang=\"en\"><meta charset=\"UTF-8\"><style type=\"text/css\"> %@</style></head><body>%@</body></html>",textColor,htmlStr];
    NSMutableString *mutableStr = [[NSMutableString alloc]initWithString:html];
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple * doc      = [[TFHpple alloc] initWithHTMLData:data];
    NSArray * elements = [doc searchWithXPathQuery:@"//img"];
    for (int i = 0; i < elements.count; i++) {
        TFHppleElement * e = [elements objectAtIndex:i];
        if ([e objectForKey:@"href"]) {
            NSDictionary *dict = [e attributes];
            NSRange range = [mutableStr rangeOfString:dict[@"href"]];
            [mutableStr replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%@",dict[@"href"]]];
        }else{
            NSDictionary *dict = [e attributes];
            NSRange range = [mutableStr rangeOfString:dict[@"src"]];
            [mutableStr replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%@",dict[@"src"]]];
        }
    }

  
    return mutableStr;
}
@end
