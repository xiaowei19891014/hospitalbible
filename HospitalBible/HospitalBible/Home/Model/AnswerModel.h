//
//  AnswerModel.h
//  HB
//
//  Created by LIFEI on 2017/5/15.
//  Copyright © 2017年 break. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerModel : NSObject
@property(nonatomic,strong) NSString *index;
@property(nonatomic,strong) NSString *title;//题目
@property(nonatomic,strong) NSArray *options;//选项
@property(nonatomic,strong) NSArray *result;//答案
@property(nonatomic,assign) BOOL isSelectedResult;//是否已经选择答案
@property(nonatomic,strong) NSString *selectedResult;//题目
@end
