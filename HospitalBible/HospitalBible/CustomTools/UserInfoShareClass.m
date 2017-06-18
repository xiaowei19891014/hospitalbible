//
//  UserInfoShareClass.m
//  HospitalBible
//
//  Created by 边瑞康 on 2017/6/4.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "UserInfoShareClass.h"

@implementation UserInfoShareClass
static UserInfoShareClass *_sharedManager = nil;
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc]init];
    });
    _sharedManager.userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    return _sharedManager;
}
@end
