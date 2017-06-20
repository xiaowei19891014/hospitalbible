//
//  SickCallTableViewCell.m
//  HospitalBible
//
//  Created by 边瑞康 on 2017/5/25.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "SickCallTableViewCell.h"

@implementation SickCallTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _image.image = [UIImage imageNamed:@"float_good"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
