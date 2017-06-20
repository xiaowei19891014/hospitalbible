//
//  UserInfoViewModel.h
//  HospitalBible
//
//  Created by 边瑞康 on 2017/6/4.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoViewModel : NSObject
+(void)requestUserInfoWithUserId:(NSString *)userId successHandler:(SuccessCallBack)successHandler errorHandler:(ErrorCallBack)errorHandler;
+(void)userLognWithUserName:(NSString *)userName password:(NSString*)password successHandler:(SuccessCallBack)successHandler errorHandler:(ErrorCallBack)errorHandler;
+(void)userLogOutWithUserName:(NSString *)userName successHandler:(SuccessCallBack)successHandler errorHandler:(ErrorCallBack)errorHandler;
@end
