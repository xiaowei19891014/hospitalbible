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

- (NSMutableArray *)listArr
{
    if (!_listArr) {
        _listArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _listArr;
}


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
    return;
    NSDictionary *params = @{
                             @"classid":classid
                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:DISEASEQUEASETION_LIST params:params success:^(id responseObject) {
            
        NSArray *diseasequestionArr = responseObject[@"diseasequestion"];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        if (diseasequestionArr.count) {
            [diseasequestionArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
                NSDictionary *dict = (NSDictionary *)obj;
                DiseaseQuestionClass *DiseaseQuestion = [DiseaseQuestionClass mj_objectWithKeyValues:dict];
                NSArray *array = dict[@"diseasequestion"];
                DiseaseQuestion.diseasequestionArr = [NSMutableArray arrayWithCapacity:0];
                
                [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *tempDict = (NSDictionary *)obj;
                    DiseaseQuestionModel *model = [DiseaseQuestionModel mj_objectWithKeyValues:tempDict];
                    model.choiceList = [NSMutableArray arrayWithCapacity:0];
                    NSArray *tempArr = tempDict[@"choice"];
                    [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSDictionary *temp = (NSDictionary *)obj;
                        DiseaseQuestionChoiceModel *diseaseQuestionChoiceModel = [DiseaseQuestionChoiceModel mj_objectWithKeyValues:temp];
                        [model.choiceList addObject:diseaseQuestionChoiceModel];
                    }];
                    [DiseaseQuestion.diseasequestionArr addObject:model];
                }];
                [arr addObject:DiseaseQuestion];
            }];
        }
             
        if (successHandler) {
            successHandler(arr);
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
