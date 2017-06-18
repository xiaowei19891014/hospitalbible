//
//  BaseViewController.m
//  新闻
//
//  Created by 范英强 on 16/9/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+ActivityIndicator.h"
#import "IQKeyboardManager.h"
@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside =YES;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 30.f;
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"确定";

}

- (BOOL)canSwipBack
{
    return YES;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    DLog(@"Controller dealloc = %@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)showErrorMessage:(NSString*)message{
    [self.view showTipViewAtCenter:message timer:2];
}
-(void)showLoadingHUD{
    [self.view showHUDIndicatorViewAtCenter:@"正在加载中..."];
    
}
-(void)hideLoadingHUD{
    [self.view hideHUDIndicatorViewAtCenter];
}
@end
