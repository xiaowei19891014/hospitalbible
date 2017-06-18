//
//  CateGoryCell.m
//  HospitalBible
//
//  Created by me on 17/5/14.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "CateGoryCell.h"
#import "UIButton+ImageTitleSpacing.h"
@interface CateGoryCell()


@end
@implementation CateGoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_feedbackButton setImage:[UIImage imageNamed:@"index_opinion_icon"] forState:(UIControlStateNormal)];
    [_feedbackButton setTitle:@"意见反馈" forState:UIControlStateNormal];
    _feedbackButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_feedbackButton setTitleColor:[UIColor colorWithHexString:@"9B9B9B"] forState:UIControlStateNormal];
    [_feedbackButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
                            imageTitleSpace:5];
    
    [_cateGoryButton setImage:[UIImage imageNamed:@"index_category_icon"] forState:(UIControlStateNormal)];
    [_cateGoryButton setTitleColor:[UIColor colorWithHexString:@"9B9B9B"] forState:UIControlStateNormal];
    _cateGoryButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_cateGoryButton setTitle:@"分类类别" forState:UIControlStateNormal];
    [_cateGoryButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
                                     imageTitleSpace:5];
    
    [_contactUsButton setImage:[UIImage imageNamed:@"index_contact_icon"] forState:(UIControlStateNormal)];
    _contactUsButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_contactUsButton setTitleColor:[UIColor colorWithHexString:@"9B9B9B"] forState:UIControlStateNormal];
    [_contactUsButton setTitle:@"联系我们" forState:UIControlStateNormal];
    [_contactUsButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
                                     imageTitleSpace:5];
    
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{

}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
}

@end
