//
//  HistoryDetailViewModel.m
//  HB
//
//  Created by LIFEI on 2017/5/24.
//  Copyright © 2017年 break. All rights reserved.
//

#import "HistoryDetailViewModel.h"
@implementation HistoryDetailViewModel
+(CGFloat)calculateSectionViewHeightWithIndexText:(NSString*)indexText andTitleText:(NSString*)titleText{
    
    CGFloat indexTextDefultH = 20;
    CGFloat titleTextDefultH = 20;
    CGFloat totalH = 0;
    
    CGFloat indexTextCaltH = [self calculateRowHeight:indexText fontSize:14 textWidth:SCREEN_WIDTH-40];
    (indexTextCaltH > indexTextDefultH) ? (totalH += indexTextCaltH) : (totalH += indexTextDefultH);
    CGFloat titleTextCaltH = [self calculateRowHeight:titleText fontSize:12 textWidth:SCREEN_WIDTH-40];
    (titleTextCaltH > titleTextDefultH) ? (totalH += titleTextCaltH) : (totalH += titleTextDefultH);
    return totalH + 40;
}

+(CGFloat)calculateRowHeight:(NSString*)string fontSize:(CGFloat)fontSize textWidth:(CGFloat)textWidth{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(textWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}
@end
