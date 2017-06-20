//
//  QuestionBankCell.h
//  HospitalBible
//
//  Created by me on 17/5/15.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QuestionBankCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *selfTestButton;
@property (weak, nonatomic) IBOutlet UIButton *historyRecordButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imagePicView;

@property (nonatomic,strong)DiseaseQuestionClass *model;

@end
