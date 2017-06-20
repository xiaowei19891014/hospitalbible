//
//  QuestionBankCell.m
//  HospitalBible
//
//  Created by me on 17/5/15.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "QuestionBankCell.h"
@interface QuestionBankCell()
@property (weak, nonatomic) IBOutlet UIView *bottomBgView;
@property (weak, nonatomic) IBOutlet UIView *topBgView;

@end

@implementation QuestionBankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.topBgView.layer.cornerRadius = 5;
    self.topBgView.layer.masksToBounds = YES;
    
    self.bottomBgView.layer.cornerRadius = 5;
    self.bottomBgView.layer.masksToBounds = YES;
    
    self.imagePicView.layer.cornerRadius =1.2*(SCREEN_WIDTH - 40)/12.0;
    self.imagePicView.layer.masksToBounds = YES;
}

- (void)setModel:(DiseaseQuestionClass *)model
{
    _model = model;
    
}


@end
