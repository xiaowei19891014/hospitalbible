//
//  QuestionBankViewModel.m
//  HB
//
//  Created by LIFEI on 2017/5/15.
//  Copyright © 2017年 break. All rights reserved.
//

#import "QuestionBankViewModel.h"

@implementation QuestionBankViewModel
+(CGFloat)calculateRowHeight:(NSString*)string fontSize:(CGFloat)fontSize textWidth:(CGFloat)textWidth{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(textWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}

+(CGFloat)calculateAnswersRowHeightWithText:(NSString*)string fontSize:(CGFloat)fontSize textWidth:(CGFloat)textWidth{
    CGFloat height = [self calculateRowHeight:string fontSize:12 textWidth:textWidth];
    CGFloat h = 0;
    (height > 20) ?  (h = height) : (h = 20);
    return h + 15;
}
@end
