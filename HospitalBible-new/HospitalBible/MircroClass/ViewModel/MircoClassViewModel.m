//
//  MircoClassViewModel.m
//  HospitalBible
//
//  Created by me on 17/6/4.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "MircoClassViewModel.h"
#import "MircoClassListModel.h"
@implementation MircoClassViewModel
+ (void)requestDiscoverListWithDisclsid:(NSString*)disclsid successHandler:(SuccessCallBack)successHandler
                                 errorHandler:(ErrorCallBack)errorHandler
{
    NSDictionary *params = @{
                             @"disclsid":disclsid
                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:DISCOVER_LIST params:params success:^(id responseObject) {
        if (successHandler) {
            successHandler([MircoClassListModel mj_objectArrayWithKeyValuesArray:responseObject]);
        }
    } failure:^(NSError *error) {
        if (errorHandler) {
            errorHandler(error);
        }
    }];
}

@end
