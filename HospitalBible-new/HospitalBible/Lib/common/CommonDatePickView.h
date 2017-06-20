//
//  CommonDatePickView.h
//  EIntegrate
//
//  Created by xiaowei on 16/12/23.
//  Copyright © 2016年 CGL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  //日期选择的类型
{
    kDatePickerTypeFull ,        //年，月，日
    kDatePickerTypeNoDay ,       //只包含年，月
    kDatePickerTypeOnlyYear,     //只包含年
    kDatePickerTypeAddHour,  //年，月，日，时
    
}kDatePickerType;

typedef void(^DateSelectAction)(NSString*selectDateStr);


@interface CommonDatePickView   : UIView<UIPickerViewDataSource,
UIPickerViewDelegate>
{
    NSMutableArray *yearMtbArray;   //年
    NSMutableArray *monthMtbArray;  //月
    NSMutableArray *dayMtbArray;    //日
    NSMutableArray *hourMtbArray;   //时
}

@property (assign, nonatomic) kDatePickerType pageType;

@property (strong, nonatomic)  UIDatePicker *datePicker;
@property (strong, nonatomic)  UIPickerView *pickerView;

@property (strong,nonatomic) NSDate *maxDate;
@property (strong,nonatomic) NSDate *minDate;

@property (strong, nonatomic) NSString *indexDate;  //页面显示时的默认选中日期
@property (assign, nonatomic) int currentYear;    //选择的年份
@property (assign, nonatomic) int currentMonth;   //选择的月份
@property (assign, nonatomic) int currentDay;     //选择的日
@property (assign, nonatomic) int currentHour;    //选择的小时

@property (copy, nonatomic) DateSelectAction clickOkAction;

-(void)creatVIewAndDate;
@end
