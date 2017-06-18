//
//  HotSpotCell.m
//  HospitalBible
//
//  Created by me on 17/5/14.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "HotSpotCell.h"
#import "HotSpot.h"
@interface HotSpotCell()
@property (strong, nonatomic) UILabel *contentLabel;

@end

@implementation HotSpotCell
-(void)setDataWithSourceData:(id)model{
    HotSpot *hot = (HotSpot*)model;
    self.contentLabel.text  = hot.title;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        //_contentLabel.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}
@end
