//
//  HomeViewModel.m
//  HospitalBible
//
//  Created by me on 17/6/4.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "HomeViewModel.h"
#import "UserInfoModel.h"
@implementation HomeViewModel
+ (void)requestAdvertisementListSuccessHandler:(SuccessCallBack)successHandler
          errorHandler:(ErrorCallBack)errorHandler
{
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:DISEASEQUEASETION_THREE params:nil success:^(NSDictionary *responseObject) {
        if (successHandler) {
            successHandler(responseObject);
        }
    } failure:^(NSError *error) {
        if (errorHandler) {
            errorHandler(error);
        }
    }];
}
//DISEASEQUEASETION_THREE
+ (void)requestAllDiseasequestionListSuccessHandler:(SuccessCallBack)successHandler errorHandler:(ErrorCallBack)errorHandler{
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:DISEASEQUEASETION_THREE params:nil success:^(NSDictionary *responseObject) {
        if (successHandler) {
            //
            successHandler([DiseaseQuestionClass mj_objectArrayWithKeyValuesArray:responseObject[@"diseaseQuestionClass"]]);
        }
    } failure:^(NSError *error) {
        if (errorHandler) {
            errorHandler(error);
        }
    }];
}

+ (void)requestDiseasequestionListWithClassId:(NSString*)classid successHandler:(SuccessCallBack)successHandler
                                  errorHandler:(ErrorCallBack)errorHandler
{
    NSDictionary *params = @{
                             @"classid":classid
                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:DISEASEQUEASETION_LIST params:params success:^(id responseObject) {
        if (successHandler) {
            
            NSArray *list = responseObject;
            NSMutableArray *getList = [NSMutableArray array];
            //遍历数组
            for (int i = 0; i<list.count; i++) {
                NSDictionary *dic = list[i];
                DiseaseQuestionModel *model = [DiseaseQuestionModel mj_objectWithKeyValues:dic];

                NSDictionary *dic1 = [self dictionaryWithJsonString:dic[@"choices"]];
                NSArray *list2 = dic1[@"cont"];
                NSLog(@"%@",list2);
                NSArray *choiceList = [DiseaseQuestionChoiceModel mj_objectArrayWithKeyValuesArray:list2];
                model.choiceList = choiceList;
                [getList addObject:model];
            }
            
            successHandler(getList);
        }
    } failure:^(NSError *error) {
        if (errorHandler) {
            errorHandler(error);
        }
    }];
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}
+(NSMutableArray*)getAdvertisementListImageWithRequestArr:(NSArray*)array{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        [arr addObject:dic[@"imgurl"]];
    }
    return arr;
}
+ (void)requestPatientListWithUserId:(NSString*)userId successHandler:(SuccessCallBack)successHandler errorHandler:(ErrorCallBack)errorHandler
{
    NSDictionary *params = @{
                             @"userId":userId
                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:PATIENT_LIST params:params success:^(NSDictionary *responseObject) {
        if (successHandler) {
            successHandler([UserInfoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]);
        }
    } failure:^(NSError *error) {
        if (errorHandler) {
            errorHandler(error);
        }
    }];
}


@end
