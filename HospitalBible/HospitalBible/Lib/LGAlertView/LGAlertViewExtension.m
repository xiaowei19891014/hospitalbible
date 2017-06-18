//
//  LGAlertViewExtension.m
//  EIntegrate
//
//  Created by Walker on 2016/12/15.
//  Copyright © 2016年 CGL. All rights reserved.
//

#import "LGAlertViewExtension.h"
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
    [LGAlertView setDestructiveButtonFont:[UIFont systemFontOfSize:16]];
    [LGAlertView setDestructiveButtonTitleColor:UIColorFromRGB(0xf7504d)];
    //#f7504d
    [LGAlertView setDestructiveButtonBackgroundColor:[UIColor whiteColor]];
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

@end
