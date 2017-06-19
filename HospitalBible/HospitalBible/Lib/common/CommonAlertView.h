//
//  CommonAlertView.h
//  EIntegrate
//
//  Created by xiaowei on 2017/4/25.
//  Copyright © 2017年 CGL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonAlertView : UIView{
    
    UIView *_backView;
}


- (IBAction)btnAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *addView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property(copy,nonatomic) void(^clickBlock)(void);
-(instancetype)init;
-(instancetype)initWithFrame:(CGRect)frame;

-(void)showAlertView;

-(void)hiddenView;

@end
