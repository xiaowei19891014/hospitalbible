//
//  MircoClasssCell.m
//  HospitalBible
//
//  Created by me on 17/5/20.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "MircoClasssCell.h"
#import "UIImageView+WebCache.h"
@interface MircoClasssCell()
@property (weak, nonatomic) IBOutlet UIImageView *imagePic;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation MircoClasssCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setListModel:(MircoClassListModel *)listModel{
    _listModel = listModel;
    _titleLabel.text = listModel.title;
    _dateLabel.text = listModel.date;
    _contentLabel.text = listModel.bdescription;
    NSString *urlStr = listModel.picture;
    
    [_imagePic sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
