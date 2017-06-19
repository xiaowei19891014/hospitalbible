//
//  LGAlertViewExtension.h
//  EIntegrate
//
//  Created by Walker on 2016/12/15.
//  Copyright © 2016年 CGL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGAlertView.h"
#import "CommonDatePickView.h"

@interface LGAlertViewExtension : NSObject

+ (void)showAlertTitle:(NSString *)title
           cancelTitle:(NSString *)cancelTitle
         cancelHandler:(void(^)())cancelHandler
      destructiveTitle:(NSString *)destructiveTitle
    destructiveHandler:(void(^)())destructiveHandler;

+ (void)showAlertTitle:(NSString *)title
          messageTitle:(NSString *)message
      destructiveTitle:(NSString *)destructiveTitle
    destructiveHandler:(void(^)())destructiveHandler;

+ (void)showAlertTitle:(NSString *)title
          messageTitle:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
         cancelHandler:(void(^)())cancelHandler
      destructiveTitle:(NSString *)destructiveTitle
    destructiveHandler:(void(^)())destructiveHandler;

//银行卡列表专用
+ (void)showSheetTitle:(NSString *)title
              cardList:(NSArray  *)cardList
      defaultCardIndex:(NSInteger)cardIndex
   cardSelectedHandler:(void(^)(NSInteger))cardSelectedHandler
      otherButtonTitle:(NSString *)buttonTitle
     otherButtonAction:(void(^)())buttonHandler;

+ (void)showDateSelectInViewController:(UIViewController*)viewController
                             indexDate:(NSString*)dateStr
                                andMax:(NSDate *)maxDates
                                andMin:(NSDate *)minDates
                                  type:(kDatePickerType)pickerType
                               clickOk:(DateSelectAction)block;
@end
