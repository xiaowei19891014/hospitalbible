//
//  LGAlertViewExtension.m
//  EIntegrate
//
//  Created by Walker on 2016/12/15.
//  Copyright © 2016年 CGL. All rights reserved.
//

#import "LGAlertViewExtension.h"
#import "CommonAlertView.h"
@implementation LGAlertViewExtension

+ (void)showAlertTitle:(NSString *)title
           cancelTitle:(NSString *)cancelTitle
         cancelHandler:(void(^)())cancelHandler
      destructiveTitle:(NSString *)destructiveTitle
    destructiveHandler:(void(^)())destructiveHandler
{
    [LGAlertView setTitleTextColor:UIColorFromRGB(0x333333)];
    [LGAlertView setTitleFont:[UIFont boldSystemFontOfSize:16]];
    [LGAlertView setCancelButtonFont:[UIFont systemFontOfSize:16]];
    [LGAlertView setDestructiveButtonFont:[UIFont systemFontOfSize:16]];
    [LGAlertView setCancelButtonBackgroundColor:[UIColor whiteColor]];
    [LGAlertView setCancelButtonTitleColor:UIColorFromRGB(0x666666)];
    [LGAlertView setCancelButtonTitleColorHighlighted:UIColorFromRGB(0x666666)];
    [LGAlertView setCancelButtonBackgroundColorHighlighted:[UIColor clearColor]];
    [LGAlertView setDestructiveButtonBackgroundColor:[UIColor whiteColor]];
    [LGAlertView setDestructiveButtonBackgroundColorHighlighted:[UIColor clearColor]];
    [LGAlertView setDestructiveButtonTitleColorHighlighted:[UIColor redColor]];
    [[[LGAlertView alloc] initWithTitle:title
                                message:nil
                                  style:LGAlertViewStyleAlert
                           buttonTitles:nil
                      cancelButtonTitle:cancelTitle
                 destructiveButtonTitle:destructiveTitle
                          actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
//                              NSLog(@"actionHandler, %@, %lu", title, (long unsigned)index);
                          }
                          cancelHandler:^(LGAlertView *alertView) {
//                              NSLog(@"cancelHandler");
                              if (cancelHandler) {
                                  cancelHandler();
                              }
                          }
                     destructiveHandler:^(LGAlertView *alertView) {
//                         NSLog(@"destructiveHandler");
                         if (destructiveHandler) {
                             destructiveHandler();
                         }
                     }] showAnimated:YES completionHandler:nil];
}

+ (void)showAlertTitle:(NSString *)title
          messageTitle:(NSString *)message
      destructiveTitle:(NSString *)destructiveTitle
    destructiveHandler:(void(^)())destructiveHandler
{
    [LGAlertView setTitleTextColor:UIColorFromRGB(0x000000)];
    [LGAlertView setTitleFont:[UIFont systemFontOfSize:16]];
    [LGAlertView setMessageTextColor:UIColorFromRGB(0x000000)];
    [LGAlertView setMessageFont:[UIFont systemFontOfSize:16]];
    [LGAlertView setDestructiveButtonBackgroundColor:[UIColor whiteColor]];
    [LGAlertView setDestructiveButtonBackgroundColorHighlighted:[UIColor clearColor]];
    [LGAlertView setDestructiveButtonTitleColorHighlighted:[UIColor redColor]];
    [LGAlertView setDestructiveButtonFont:[UIFont systemFontOfSize:16]];
    [[[LGAlertView alloc] initWithTitle:title
                                message:message
                                  style:LGAlertViewStyleAlert
                           buttonTitles:nil
                      cancelButtonTitle:nil
                 destructiveButtonTitle:destructiveTitle actionHandler:nil cancelHandler:nil destructiveHandler:^(LGAlertView *alertView) {
                     if (destructiveHandler) {
                         destructiveHandler();
                     }
                 }] showAnimated:YES completionHandler:nil];
}


+ (void)showAlertTitle:(NSString *)title
          messageTitle:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
         cancelHandler:(void(^)())cancelHandler
      destructiveTitle:(NSString *)destructiveTitle
    destructiveHandler:(void(^)())destructiveHandler
{
    [LGAlertView setMessageTextColor:UIColorFromRGB(0x333333)];
    [LGAlertView setMessageFont:[UIFont systemFontOfSize:16]];
    if(title!=nil && title.length>0){
        [LGAlertView setTitleFont:[UIFont boldSystemFontOfSize:16]];
        [LGAlertView setTitleTextColor:UIColorFromRGB(0x333333)];
        [LGAlertView setMessageFont:[UIFont systemFontOfSize:13]];
        }
    [LGAlertView setCancelButtonBackgroundColor:[UIColor whiteColor]];
    [LGAlertView setCancelButtonTitleColor:UIColorFromRGB(0x666666)];
    [LGAlertView setCancelButtonFont:[UIFont systemFontOfSize:16]];
    [LGAlertView setCancelButtonBackgroundColorHighlighted:[UIColor whiteColor]];
    [LGAlertView setDestructiveButtonFont:[UIFont systemFontOfSize:16]];
    [LGAlertView setDestructiveButtonTitleColor:[UIColor colorWithHexString:@"#f7504d"]];
    [LGAlertView setDestructiveButtonBackgroundColor:[UIColor whiteColor]];
    [LGAlertView setDestructiveButtonBackgroundColorHighlighted:[UIColor whiteColor]];
    [[[LGAlertView alloc] initWithTitle:title
                                message:message
                                  style:LGAlertViewStyleAlert
                           buttonTitles:nil
                      cancelButtonTitle:cancelTitle
                 destructiveButtonTitle:destructiveTitle actionHandler:nil cancelHandler:^(LGAlertView *alertView) {
                     if (cancelHandler) {
                         cancelHandler();
                     }
                 } destructiveHandler:^(LGAlertView *alertView) {
                     if (destructiveHandler) {
                         destructiveHandler();
                     }
                 }] showAnimated:YES completionHandler:nil];
}

//银行卡列表专用
+ (void)showSheetTitle:(NSString *)title
              cardList:(NSArray  *)cardList
      defaultCardIndex:(NSInteger)cardIndex
   cardSelectedHandler:(void(^)(NSInteger))cardSelectedHandler
      otherButtonTitle:(NSString *)buttonTitle
     otherButtonAction:(void(^)())buttonHandler
{
   }

/**
 *	@brief	显示日期选择页面
 *
 *	@param 	viewController
 *	@param 	dateStr 	显示页面是默认的被选择的日期 格式为“2013-12-12” 或“2013-12” 或 @“2013”
 *	@param 	pickerType  picker类型
 *  @param  block  点击确定按钮时的回调 返回选择的日期字符串 格式为“2013-12-12” 或“2013-12” 或 @“2013”
 *	return 1
 */

+ (void)showDateSelectInViewController:(UIViewController*)viewController
                             indexDate:(NSString*)dateStr andMax:(NSDate *)maxDates andMin:(NSDate *)minDates
                                  type:(kDatePickerType)pickerType
                               clickOk:(DateSelectAction)block{
    [viewController.view endEditing:YES];
    CommonDatePickView *view =[[CommonDatePickView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 216)];
    view.width = SCREEN_WIDTH-20;
    view.centerX = (SCREEN_WIDTH -20)/2;
    view.pageType = pickerType;
    view.indexDate = dateStr;
    
    [CacheMethod userDefaultSetValue:dateStr forKey:@"dateStr"];

    if(pickerType == kDatePickerTypeFull){
        if(maxDates)
            view.maxDate = maxDates;
        if(minDates)
            view.minDate = minDates;
    }
    [view creatVIewAndDate];
    
    CommonAlertView *alertView = [[[NSBundle mainBundle]loadNibNamed:@"CommonAlertView" owner:self options:nil] firstObject];
    [alertView.addView addSubview:view];
    
    [alertView setClickBlock:^{
        NSString *selectDataStr = [CacheMethod userDefaultvalueForKey:@"dateStr"];
        if (selectDataStr.length > 0) {
            block(selectDataStr);
        }
    }];
    [alertView showAlertView];

}


@end
