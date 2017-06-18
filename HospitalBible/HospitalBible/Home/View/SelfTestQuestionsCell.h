//
//  SelfTestQuestionsCell.h
//  HospitalBible
//
//  Created by me on 17/5/17.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswerModel.h"
#import "DiseaseQuestionModel.h"
@interface SelfTestQuestionsCell : UICollectionViewCell
//@property(nonatomic,strong) AnswerModel *model;
@property(nonatomic,strong) DiseaseQuestionModel *mdel;
@property(nonatomic,strong) NSMutableArray *resultList;
@end

