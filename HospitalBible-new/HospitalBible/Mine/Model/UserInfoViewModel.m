//
//  UserInfoViewModel.m
//  HospitalBible
//
//  Created by 边瑞康 on 2017/6/4.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "UserInfoViewModel.h"
#import "UserInfoModel.h"
@implementation UserInfoViewModel
+(void)requestUserInfoWithUserId:(NSString *)userId successHandler:(SuccessCallBack)successHandler errorHandler:(ErrorCallBack)errorHandler
{
    NSDictionary *params = @{
                             @"userId":userId
                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:USER_INFO params:params success:^(NSDictionary *responseObject) {
        if (successHandler) {
            
            UserInfoModel *detailModel = [UserInfoModel mj_objectWithKeyValues:responseObject];
            if (!detailModel.id) {
                return ;
            }
            NSArray *arr = @[detailModel.imgurl,NOTNIL(detailModel.nickname) ,detailModel.idtype,detailModel.idcard,detailModel.sex,detailModel.cellphone,NOTNIL( detailModel.age),detailModel.address,detailModel.height,detailModel.weight, NOTNIL( detailModel.birthDay),detailModel.email,@"",@"",@"",detailModel.id];
            successHandler(arr);
        }
    } failure:^(NSError *error) {
        if (errorHandler) {
            errorHandler(error);
        }
    }];
}
+(void)userLognWithUserName:(NSString *)userName password:(NSString*)password successHandler:(SuccessCallBack)successHandler errorHandler:(ErrorCallBack)errorHandler
{
    NSDictionary *params = @{
                             @"cellphone":userName,
                             @"password":password
                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:USER_LOGIN params:params success:^(NSDictionary *responseObject) {
        if (successHandler) {
            successHandler(responseObject);
        }
    } failure:^(NSError *error) {
        if (errorHandler) {
            errorHandler(error);
        }
    }];
}
+(void)userLogOutWithUserName:(NSString *)userName successHandler:(SuccessCallBack)successHandler errorHandler:(ErrorCallBack)errorHandler
{
    NSDictionary *params = @{
                             @"userId":userName
                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:USER_LOGOUT params:params success:^(NSDictionary *responseObject) {
        if (successHandler) {
            successHandler(responseObject);
        }
    } failure:^(NSError *error) {
        if (errorHandler) {
            errorHandler(error);
        }
    }];
}
@end
