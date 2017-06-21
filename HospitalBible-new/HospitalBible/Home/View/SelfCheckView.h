//
//  Symptom   Symptom SelfCheckView.h
//  HospitalBible
//
//  Created by me on 17/5/14.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfCheckView : UIView

@property(strong,nonatomic) UIImageView *imageView;
@property(strong,nonatomic) UILabel     *label;

@property(copy,nonatomic) NSString *BtnTitle;

@property(copy,nonatomic) NSString *imgurl;
@property (nonatomic)NSInteger index;

@property (nonatomic,copy) void (^clicked)(BOOL left,NSInteger index);

-(void)refrestTheUI;

@end
