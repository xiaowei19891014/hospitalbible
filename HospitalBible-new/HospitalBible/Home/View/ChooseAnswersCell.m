//
//  ChooseAnswersCell.m
//  HB
//
//  Created by LIFEI on 2017/5/15.
//  Copyright © 2017年 break. All rights reserved.
//

#import "ChooseAnswersCell.h"
@interface ChooseAnswersCell()


@end
@implementation ChooseAnswersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectResultButton.layer.cornerRadius = 10;
    self.selectResultButton.layer.masksToBounds = YES;
}
-(void)setChooseAnswerUpperCaseWithIndex:(NSInteger)index{
    NSString *indexStr = [self getUpperCaseWithIndex:index];
    
    [self.selectResultButton setAttributedTitle:[self getNormalUpperCaseIndexWithIndex:indexStr] forState:(UIControlStateNormal)];
    [self.selectResultButton setAttributedTitle:[self getSelectUpperCaseIndexWithIndex:indexStr] forState:(UIControlStateSelected)];

}
-(NSMutableAttributedString *)getNormalUpperCaseIndexWithIndex:(NSString*)index{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:index];
    //颜色 设置
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"FFFFFF"] range:NSMakeRange(0, str.length)];
    //样式、大小 设置
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:16] range:NSMakeRange(0, str.length)];
    return str;
}

-(NSMutableAttributedString *)getSelectUpperCaseIndexWithIndex:(NSString*)index{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:index];
    //颜色 设置
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(0, str.length)];
    //样式、大小 设置
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:20] range:NSMakeRange(0, str.length)];
    return str;
}

-(NSString*)getUpperCaseWithIndex:(NSInteger)index{
    if (index == 0) {
        return @"A";
    }else if(index == 1){
        return @"B";
    }else if(index == 2){
        return @"C";
    }else if(index == 3){
        return @"D";
    }else{
        return @"";
    }
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
}


@end
