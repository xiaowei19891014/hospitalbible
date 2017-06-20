//
//  UserRegisterConfirmViewController.m
//  HospitalBible
//
//  Created by 边瑞康 on 2017/6/4.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "UserRegisterConfirmViewController.h"

@interface UserRegisterConfirmViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF1;
@property (weak, nonatomic) IBOutlet UIButton *next;

@end

@implementation UserRegisterConfirmViewController
- (IBAction)back:(id)sender {
}
- (IBAction)next:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _next.layer.cornerRadius = 22;
    _next.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
