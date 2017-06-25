//
//  CommonFunction.m
//  HospitalBible
//
//  Created by me on 17/5/14.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "CommonFunction.h"
#import "TitleImageModel.h"
NSMutableArray* getUserCenterTitleAndImageList(){
    
    NSArray *titles = @[@"我的预约",@"我的收藏",@"我的信息",@"就诊患者管理",@"关于APP",@"客服电话"];
    NSArray *images = @[@"my_subscribe_icon",@"my_xinyin_icon",@"my_xinxi_icon",@"my_huanzhe_icon",@"my_huancun_icon",@"my_app_icon",@"my_phone_icon"];
    NSMutableArray *models = [NSMutableArray array];
    for (int i = 0; i<titles.count; i++) {
        TitleImageModel *model = [[TitleImageModel alloc] init];
        model.title = titles[i];
        model.imageName = images[i];
        [models addObject:model];
    }
    return models;
}

NSArray* getUserInfpTitleList(){
    NSArray *titles = @[@"头像",@"姓名",@"证件类型",@"证件号",@"性别",@"联系电话",@"年龄",@"地址",@"身高",@"体重",@"生日",@"Email"];
    return titles;
}
NSString* getUpperCaseWithIndex(NSInteger index){
    if (index == 0) {
        return @"A";
    }else if(index == 1){
        return @"B";
    }else if(index == 2){
        return @"C";
    }else if(index == 3){
        return @"D";
    }else{
        return @"";
        
    }
}

NSString* getMMSSFromSS(NSInteger totalTime){
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",totalTime/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(totalTime%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",totalTime%60];
    return [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
}



