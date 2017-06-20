//
//  UIStoryboard+KZ.m
//  HospitalBible
//
//  Created by wangsu on 2017/6/14.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "UIStoryboard+KZ.h"
#import "MircoClassDetailViewController.h"


@implementation UIStoryboard (KZ)

+ (MircoClassDetailViewController *) MircoClassDetailViewController{
    return [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"MircoClassDetailVC"];
}

@end
