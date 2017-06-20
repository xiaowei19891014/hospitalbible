//
//  CommonFunction.h
//  HospitalBible
//
//  Created by me on 17/5/14.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <Foundation/Foundation.h>

int add(int num1, int num2);

NSMutableArray* getUserCenterTitleAndImageList();
NSArray* getUserInfpTitleList();

//0-A,1-B
NSString* getUpperCaseWithIndex(NSInteger index);

NSString* getMMSSFromSS(NSInteger totalTime);


