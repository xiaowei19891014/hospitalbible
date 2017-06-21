//
//  LGQuestionView.h
//  HospitalBible
//
//  Created by Walker on 2017/6/19.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiseaseQuestionModel.h"

@interface LGQuestionView : UIScrollView
@property (nonatomic,strong)UIButton *nextBtn;
@property (nonatomic,strong)DiseaseQuestionModel *model;
@property (nonatomic)NSInteger index;
@property (nonatomic)NSInteger currentSelectedIndex;
@property (nonatomic,copy) void(^nextBtnClickAction)(NSInteger);
@property (nonatomic,copy) void(^tapAction)(NSInteger index,NSInteger selNumber,NSInteger score);

@end
