//
//  ChooseAnswersCell.m
//  HB
//
//  Created by LIFEI on 2017/5/15.
//  Copyright © 2017年 break. All rights reserved.
//

#import "ChooseAnswersCell.h"

@implementation ChooseAnswersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    self.nameLabel.text = dict[@"pname"];
    self.scoreLabel.text = dict[@"point"];
    self.dateLabel.text = [dict[@"date"] substringToIndex:10];
    self.timeLabel.text = [dict[@"date"] substringFromIndex:11];
    
}

@end
