//
//  AddSickTableViewCell.m
//  HospitalBible
//
//  Created by 边瑞康 on 2017/5/25.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "AddSickTableViewCell.h"

@implementation AddSickTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(AddSickModel *)model
{
    _title.text = model.title;
    _textfield.placeholder = model.placeholder;
    _textfield.tag = model.index;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
