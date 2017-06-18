//
//  LGAlertViewExtension.h
//  EIntegrate
//
//  Created by Walker on 2016/12/15.
//  Copyright © 2016年 CGL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGAlertView.h"


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


@end
