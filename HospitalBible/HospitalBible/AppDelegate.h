//
//  AppDelegate.h
//  First
//
//  Created by me on 17/5/12.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabbarViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic , strong) TabbarViewController *tabbarMain;

+ (AppDelegate *)currentDelegate;

+ (void)closeKeyWindow;

@end

