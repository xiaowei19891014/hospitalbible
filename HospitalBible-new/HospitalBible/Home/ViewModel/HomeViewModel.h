//
//  HomeViewModel.h
//  HospitalBible
//
//  Created by me on 17/6/4.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiseaseQuestionModel.h"

@interface HomeViewModel : NSObject

@property (nonatomic,strong)NSMutableArray *listArr;

- (void)checkData:(void(^)(DiseaseQuestionClass *))checkModel
             byId:(NSString *)Id;

+ (void)requestAdvertisementListSuccessHandler:(SuccessCallBack)successHandler
                                  errorHandler:(ErrorCallBack)errorHandler;
+ (void)requestAllDiseasequestionListSuccessHandler:(SuccessCallBack)successHandler errorHandler:(ErrorCallBack)errorHandler;
+ (void)requestDiseasequestionListWithClassId:(NSString*)classid successHandler:(SuccessCallBack)successHandler
                                 errorHandler:(ErrorCallBack)errorHandler;
+ (void)requestPatientListWithUserId:(NSString*)userId successHandler:(SuccessCallBack)successHandler errorHandler:(ErrorCallBack)errorHandler;
+(NSMutableArray*)getAdvertisementListImageWithRequestArr:(NSArray*)array;
@end
