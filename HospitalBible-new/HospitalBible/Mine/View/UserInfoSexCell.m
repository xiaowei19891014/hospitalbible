//
//  UserInfoSexCell.m
//  HospitalBible
//
//  Created by 边瑞康 on 2017/5/24.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "UserInfoSexCell.h"

@implementation UserInfoSexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectAction:(UIButton *)sender {
    _manBtn.selected = NO;
    _womanBtn.selected = NO;
    sender.selected = YES;
    
    if (self.selectSexBlock) {
        self.selectSexBlock(sender.tag);
    }
}
@end
