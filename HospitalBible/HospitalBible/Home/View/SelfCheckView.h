//
//  Symptom   Symptom SelfCheckView.h
//  HospitalBible
//
//  Created by me on 17/5/14.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfCheckView : UIView

@property(strong,nonatomic) UIButton *button;

@property(copy,nonatomic) NSString *BtnTitle;

@property(copy,nonatomic) NSString *imgurl;

-(void)refrestTheUI;

@end
