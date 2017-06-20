//
//  UserLoginViewController.m
//  HospitalBible
//
//  Created by 边瑞康 on 2017/5/15.
//  Copyright © 2017年 com.hao. All rights reserved.
//123222

#import "UserLoginViewController.h"
#import "UserInfoViewModel.h"
#import "UserRegisterViewController.h"

@interface UserLoginViewController ()

@end

@implementation UserLoginViewController

- (void)viewDidLoad
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewDidLoad];
    [self installUserNameTFAndPassWordTF];
}

- (void)installUserNameTFAndPassWordTF
{
    UIView *leftUserNameView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 25)];
    UIImageView *leftUserNameImage= [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 25, 25)];
    leftUserNameImage.image = [UIImage imageNamed:@"home_avatar"];
    [leftUserNameView addSubview:leftUserNameImage];
    _userNameTF.leftView = leftUserNameView;
    _userNameTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIView *leftPassWordView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 25)];
    UIImageView *leftPassWordImage= [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 25, 25)];
    leftPassWordImage.image = [UIImage imageNamed:@"home_password"];
    [leftPassWordView addSubview:leftPassWordImage];
    _passWordTF.secureTextEntry = YES;
    _passWordTF.leftView = leftPassWordView;
    _passWordTF.leftViewMode = UITextFieldViewModeAlways;
}

- (IBAction)userRegister:(id)sender {
    UserRegisterViewController * vc =[[UserRegisterViewController alloc] init];
    vc.registType = kRegist ;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)lognCilck:(id)sender {
    [self showLoadingHUD];
    [UserInfoViewModel  userLognWithUserName:_userNameTF.text password:_passWordTF.text successHandler:^(id result) {
        [self hideLoadingHUD];
        [CacheMethod userDefaultSetValue:result[@"userId"] forKey:@"userId"];
        [UserInfoShareClass sharedManager].userId = result[@"userId"];
        [[NSNotificationCenter defaultCenter] postNotificationName:USERLOGING object:nil];
        if (self.loginSuccessBlock) {
            self.loginSuccessBlock();
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    } errorHandler:^(NSError *error) {
        [self hideLoadingHUD];

    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}

- (void)didReceiveMemoryWarning
{
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

- (IBAction)backAction:(UIButton *)sender {
    
    exit(0);
    
}

- (IBAction)forgetPasswordAction:(UIButton *)sender {
    
    UserRegisterViewController * vc =[[UserRegisterViewController alloc] init];
    vc.registType = kForgetPassWord ;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
