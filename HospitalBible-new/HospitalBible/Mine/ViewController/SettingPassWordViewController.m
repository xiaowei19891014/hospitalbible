//
//  SettingPassWordViewController.m
//  HospitalBible
//
//  Created by xiaowei on 2017/6/17.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "SettingPassWordViewController.h"

@interface SettingPassWordViewController ()

@end

@implementation SettingPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nextBtn.layer.cornerRadius = 22;
    _nextBtn.layer.masksToBounds = YES;

    _firstTF.secureTextEntry = YES;
    _secondTF.secureTextEntry = YES;


}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

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

- (void)registerRequest{
    [self showLoadingHUD];
    NSDictionary *params = @{
                             @"cellphone":_phoneNum,
                             @"password":_firstTF.text
                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:USER_REGIST params:params success:^(id responseObject) {
        [self hideLoadingHUD];

        [CacheMethod userDefaultSetValue:responseObject[@"userId"] forKey:@"userId"];

        [AppDelegate currentDelegate].window.rootViewController = [AppDelegate currentDelegate].tabbarMain;
        
        [AppDelegate currentDelegate].tabbarMain.selectedIndex = 0;
        
    } failure:^(NSError *error) {
        [self hideLoadingHUD];
        
    }];
}

- (void)resetPassWordRequest{
    [self showLoadingHUD];
    NSDictionary *params = @{
                             @"cellphone":_phoneNum,
                             @"password":_firstTF.text
                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:USER_RessREPASSWORD params:params success:^(id responseObject) {
        [self hideLoadingHUD];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        [self hideLoadingHUD];
        
    }];
}



- (IBAction)nextBtnAction:(UIButton *)sender {
    
    if (!_firstTF.text.length) {
        [EUnit showToastWithTitle:@"请输入密码"];
        return ;
    }
    if (!_secondTF.text.length) {
        [EUnit showToastWithTitle:@"请再次输入密码"];
        return ;
    }
    if (![_firstTF.text isEqualToString:_secondTF.text]) {
        [EUnit showToastWithTitle:@"两次密码输入不一致"];
        return ;
    }
    
    if (self.registType == kRegist) {
        [self registerRequest];

    }else{
        [self resetPassWordRequest];
    }
}

- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
