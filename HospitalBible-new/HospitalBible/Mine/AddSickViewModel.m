//
//  AddSickViewModel.m
//  HospitalBible
//
//  Created by 边瑞康 on 2017/5/25.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "AddSickViewModel.h"
#import "AddSickModel.h"
@implementation AddSickViewModel
NSMutableArray* getAddSickTitleAndIndexList(){
    
    NSArray *titles = @[@"姓名",@"证件类型",@"证件号",@"性别",@"联系电话",@"年龄",@"身高",@"体重",@"地址"];
    NSArray *placeholders = @[@"",@"",@"",@"",@"",@"",@"",@"",@""];
    NSMutableArray *models = [NSMutableArray array];
    for (int i = 0; i<titles.count; i++) {
        AddSickModel *model = [[AddSickModel alloc] init];
        model.title = titles[i];
        model.placeholder = placeholders[i];
        model.index = i+1016;
        [models addObject:model];
    }
    return models;
}
@end
