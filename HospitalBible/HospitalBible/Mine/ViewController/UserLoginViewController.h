//
//  UserLoginViewController.h
//  HospitalBible
//
//  Created by 边瑞康 on 2017/5/15.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "BaseViewController.h"


@interface UserLoginViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;

@property (copy, nonatomic) void (^loginSuccessBlock)();

- (IBAction)backAction:(UIButton *)sender;
- (IBAction)forgetPasswordAction:(UIButton *)sender;

@end
