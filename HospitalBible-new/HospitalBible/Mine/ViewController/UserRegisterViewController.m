//
//  UserRegisterViewController.m
//  HospitalBible
//
//  Created by 边瑞康 on 2017/6/4.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "UserRegisterViewController.h"
#import "UserRegisterConfirmViewController.h"
#import "EUnit.h"
#import "SettingPassWordViewController.h"
@interface UserRegisterViewController ()

/** 1 短信 2 密码 */
@property (nonatomic, assign) NSInteger registerType;

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *validateTF;
@property (weak, nonatomic) IBOutlet UIButton *validate;
@property (weak, nonatomic) IBOutlet UIButton *next;

@property (nonatomic, strong) NSTimer *mTimer;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *verify;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *rePassword;

@end

@implementation UserRegisterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _registerType = 1;
    _validate.layer.cornerRadius = 12.5;
    _validate.layer.masksToBounds = YES;
    _next.layer.cornerRadius = 22;
    _next.layer.masksToBounds = YES;
    
    _count = 60;
    
    if (self.registType == kForgetPassWord) {
        self.titleLable.text = @"忘记密码";
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)next:(id)sender {
    
    if (_registerType == 1) {
        _phone = _userNameTF.text;
        _verify = _validateTF.text;
    }
    
    if (_registerType == 2) {
        _password = _userNameTF.text;
        _rePassword = _validateTF.text;
    }
    
    if ([self checkValue] && _registerType == 1) {
        [self checkMessageRequest];
//        _registerType = 2;
//        [self setPassWord];
    }else if([self checkValue] && _registerType == 2){
    }
    
}


- (BOOL)checkValue{
    if ( 1 == _registerType) {
        if (_phone.length != 11 ) {
            [EUnit showToastWithTitle:@"请输入手机号"];
            return NO;
        }
        
        if (_verify.length != 6) {
            [EUnit showToastWithTitle:@"请输入验证码"];
            return NO;
        }
        return YES;
    }else if( 2 == _registerType) {
        
        if (!_password.length) {
            [EUnit showToastWithTitle:@"请输入密码"];
            return NO;
        }
        
        if (![_password isEqualToString:_rePassword]) {
            [EUnit showToastWithTitle:@"两次密码输入不一致"];
            return NO;
        }
        
    }
    return YES;
}

- (IBAction)validateAction:(UIButton *)sender {
    [sender setEnabled:NO];
    [self sendValid];
}

- (void)sendValid {
    
    _phone = _userNameTF.text;
    
    _mTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timingAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_mTimer forMode:NSDefaultRunLoopMode];
    [self sendSMSRequest];
    
}

- (void)timingAction{
    _count--;
    if (_count == -1) {
        [self resetCount];
    }else{
        
         [_validate setTitle:[NSString stringWithFormat:@"(%zd)",_count] forState:UIControlStateNormal];
    }
}

- (void)resetCount {
    [_validate setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_validate setEnabled:YES];
    _count = 60;
    [_mTimer invalidate];
    _mTimer = nil;
}

- (void)setPassWord {
    _userNameTF.placeholder =@"请输入密码(6-18个字符)";
    _validateTF.placeholder =@"再次输入密码";
    _validate.hidden = YES;
    [_userNameTF setText:@""];
    [_validateTF setText:@""];
    
    [self installUserNameTFAndValidateTF];
}

- (void)installUserNameTFAndValidateTF
{
    UIView *leftUserNameView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 26, 25)];
    UIImageView *leftUserNameImage= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 22, 26)];
    leftUserNameImage.image = [UIImage imageNamed:@"padlock_icon"];
    [leftUserNameView addSubview:leftUserNameImage];
    _userNameTF.leftView = leftUserNameView;
    _userNameTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIView *leftPassWordView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 26, 25)];
    UIImageView *leftPassWordImage= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 22, 26)];
    leftPassWordImage.image = [UIImage imageNamed:@"padlock_icon"];
    [leftPassWordView addSubview:leftPassWordImage];
    _validateTF.secureTextEntry = YES;
    _validateTF.leftView = leftPassWordView;
    _validateTF.leftViewMode = UITextFieldViewModeAlways;
}

- (void)sendSMSRequest {
    [self showLoadingHUD];
    NSDictionary *params = @{
                             @"cellphone":_phone
                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:VERIFY_SENDSMS params:params success:^(id responseObject) {
        [self hideLoadingHUD];
        
    } failure:^(NSError *error) {
        [self hideLoadingHUD];

    }];
}

//USER_ISEFFECTIVE

- (void)checkMessageRequest {
    [self showLoadingHUD];
    NSDictionary *params = @{
                             @"cellphone":_phone,
                             @"verify":_verify
                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:USER_ISEFFECTIVE params:params success:^(id responseObject) {
        [self hideLoadingHUD];
        SettingPassWordViewController *pvc = [[SettingPassWordViewController alloc]init];
        pvc.registType = self.registType;
        pvc.phoneNum = _phone;
        [self.navigationController pushViewController:pvc animated:YES];
        
    } failure:^(NSError *error) {
        [self hideLoadingHUD];
        
    }];
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
