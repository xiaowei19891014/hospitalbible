//
//  HistoryTableViewCell.m
//  HospitalBible
//
//  Created by Walker on 2017/6/23.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "HistoryTableViewCell.h"

@implementation HistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIndexNumber:(NSInteger)indexNumber
{
    _indexNumber = indexNumber;
    if (indexNumber%2) {
        self.backgroundColor = [UIColor lightGrayColor];
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    self.nameLabel.text = dict[@"pname"];
    self.scoreLabel.text = [NSString stringWithFormat:@"得分：%@",dict[@"point"]];    self.dateLabel.text = [dict[@"date"] substringToIndex:10];
    self.timeLabel.text = [dict[@"date"] substringFromIndex:11];

}

@end
