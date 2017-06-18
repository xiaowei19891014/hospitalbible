//
//  UserInfoShareClass.h
//  HospitalBible
//
//  Created by 边瑞康 on 2017/6/4.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoShareClass : NSObject
+ (instancetype)sharedManager;
/** //用户ID */
@property (nonatomic, copy) NSString *userId;
@end
