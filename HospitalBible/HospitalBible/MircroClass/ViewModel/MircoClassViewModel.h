//
//  MircoClassViewModel.h
//  HospitalBible
//
//  Created by me on 17/6/4.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MircoClassViewModel : NSObject
+ (void)requestDiscoverListWithDisclsid:(NSString*)disclsid successHandler:(SuccessCallBack)successHandler
                           errorHandler:(ErrorCallBack)errorHandler;
@end
