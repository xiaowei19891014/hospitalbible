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


- (void)configRightItemWithType:(NSString *) buttonType
{
    UIButton *rightButton =[UIButton buttonWithType:UIButtonTypeSystem];
    [rightButton setFrame:CGRectMake(0.0, 0.0, 50, 30)];
    rightButton.tag=521;
    if ([buttonType isEqualToString:@"编辑"] || [buttonType isEqualToString:@"保存"] || [buttonType isEqualToString:@"添加就诊人"]) {
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        if ([buttonType isEqualToString:@"添加就诊人"]) {
            [rightButton setFrame:CGRectMake(0.0, 0.0, 80, 30)];
        }
        [rightButton setTitle:buttonType forState:UIControlStateNormal];
    }else{
        [rightButton setImage:[UIImage imageNamed:buttonType] forState:UIControlStateNormal];
    }
    rightButton.adjustsImageWhenHighlighted = NO;
    [rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)rightAction:(UIButton *)sender
{
    
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
