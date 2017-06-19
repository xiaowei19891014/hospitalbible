//
//  LGQuestionView.h
//  HospitalBible
//
//  Created by Walker on 2017/6/19.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGQuestionView : UIScrollView
@property (nonatomic,strong)UIButton *nextBtn;
@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic)NSInteger index;
@property (nonatomic,copy) void(^nextBtnClickAction)(NSInteger);

@end
