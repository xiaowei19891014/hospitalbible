//
//  SettingPassWordViewController.h
//  HospitalBible
//
//  Created by xiaowei on 2017/6/17.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingPassWordViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)nextBtnAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *secondTF;

@property (weak, nonatomic) IBOutlet UITextField *firstTF;

@property(nonatomic,copy)NSString* phoneNum;

@property (nonatomic,assign) RegistType registType;

- (IBAction)backAction:(id)sender;

@end
