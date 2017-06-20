//
//  CommonDatePickView.m
//  EIntegrate
//
//  Created by xiaowei on 16/12/23.
//  Copyright © 2016年 CGL. All rights reserved.
//

#import "CommonDatePickView.h"
#import "CommonMethod.h"

#define beginYear         1985 //起始年份 提供起始年份开始100年内的年份选择

#define Action_Tag_Cancel 100
#define Action_Tag_Ok     101

@interface CommonDatePickView ()
{
    NSInteger selectedYearRow;
    NSInteger selectedMonthRow;
    BOOL firstTimeLoad;
}
@end

@implementation CommonDatePickView


-(id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        yearMtbArray = [[NSMutableArray alloc]init];
        for (int i=beginYear; i<beginYear+1000; i++)
        {
            [yearMtbArray addObject:[NSNumber numberWithInt:i]];
        }
        monthMtbArray = [[NSMutableArray alloc]init];
        for (int i=1; i<13; i++)
        {
            [monthMtbArray addObject:[NSNumber numberWithInt:i]];
        }
        dayMtbArray = [[NSMutableArray alloc]init];
        for (int i = 1; i <= 31; i++)
        {
            [dayMtbArray addObject:[NSNumber numberWithInt:i]];
        }
        hourMtbArray = [[NSMutableArray alloc]init];
        for (int i=0; i<=23; i++)
        {
            [hourMtbArray addObject:[NSNumber numberWithInt:i]];
        }
        self.pickerView.delegate = self;
        self.pickerView.dataSource =self;
        
        [self creatPickView];
    }
    return self;
    
}

-(void)creatPickView{

    _pickerView = [[UIPickerView alloc] initWithFrame:self.frame];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.showsSelectionIndicator = YES;
    _pickerView.centerX = (SCREEN_WIDTH-20)/2;

    NSLog(@"%@",NSStringFromCGRect(_pickerView.frame));
    
    [self addSubview:_pickerView];
    
    _datePicker = [[UIDatePicker alloc] init];
    _datePicker.centerX = (SCREEN_WIDTH-20)/2;
    [self addSubview:_datePicker];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    yearMtbArray = [[NSMutableArray alloc]init];
    for (int i=beginYear; i<beginYear+1000; i++)
    {
        [yearMtbArray addObject:[NSNumber numberWithInt:i]];
    }
    monthMtbArray = [[NSMutableArray alloc]init];
    for (int i=1; i<13; i++)
    {
        [monthMtbArray addObject:[NSNumber numberWithInt:i]];
    }
    dayMtbArray = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 31; i++)
    {
        [dayMtbArray addObject:[NSNumber numberWithInt:i]];
    }
    hourMtbArray = [[NSMutableArray alloc]init];
    for (int i=1; i<=24; i++)
    {
        [hourMtbArray addObject:[NSNumber numberWithInt:i]];
    }
    self.pickerView.delegate = self;
    self.pickerView.dataSource =self;
   
//    [self creatVIewAndDate];
}

-(void)creatVIewAndDate{
    firstTimeLoad = YES;
    if(self.pageType == kDatePickerTypeFull) //年 月 日
    {
        self.pickerView.hidden = YES; //年月日 把自定义的隐藏 用系统的
        [_datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
        self.datePicker.datePickerMode = UIDatePickerModeDate;

        if(self.maxDate)
            self.datePicker.maximumDate = self.maxDate;
        if(self.minDate)
            self.datePicker.minimumDate = self.minDate;
        
        if (self.indexDate!= nil) //设置默认选中项
        {
            
            [self.datePicker setDate:[CommonMethod getDateFromDateStr:self.indexDate] animated:NO];
        }
        
    }else if (self.pageType == kDatePickerTypeAddHour ){ //分割年 月 日 时
        
        self.datePicker.hidden = YES;
        if (self.indexDate !=nil)
        {
            NSArray *temArray = [self.indexDate componentsSeparatedByString:@"-"];
            if (temArray.count == 3)
            {
                self.currentYear = [temArray[0] intValue];
                self.currentMonth = [temArray[1] intValue];
                self.currentDay = [temArray[2] intValue];
                //self.currentHour = [temArray[3] intValue];
            }
            self.currentHour = [[self.indexDate substringWithRange:NSMakeRange(self.indexDate.length - 2, 2)] intValue];
        }
        
        if (self.currentYear>=beginYear&&self.currentMonth>=1&&self.currentYear<(beginYear+100)&&self.currentMonth<=12&&self.currentDay>=1&&self.currentDay<=31&&self.currentDay>=1&&self.currentHour>=1&&self.currentHour<=24)
        {
            [self.pickerView selectRow:self.currentYear-beginYear inComponent:0 animated:NO];
            [self.pickerView selectRow:self.currentMonth-1 inComponent:1 animated:NO];
            [self.pickerView selectRow:self.currentDay-1 inComponent:2 animated:NO];
            [self.pickerView selectRow:self.currentHour inComponent:3 animated:NO];
        }
        else
        {
            [self.pickerView selectRow:0 inComponent:0 animated:NO];
            [self.pickerView selectRow:0 inComponent:1 animated:NO];
            [self.pickerView selectRow:0 inComponent:2 animated:NO];
            [self.pickerView selectRow:0 inComponent:3 animated:NO];
            
            self.currentYear = [yearMtbArray[0] intValue];
            self.currentMonth = [monthMtbArray[0] intValue];
            self.currentDay = [dayMtbArray[0] intValue];
            self.currentHour = [hourMtbArray[0] intValue];
        }
    }
    else if(self.pageType == kDatePickerTypeNoDay)  //只有年、月时 分割取出年份和月份
    {
        self.datePicker.hidden = YES;
        
        if (self.indexDate !=nil)  //indexDate =  2015-03-26 19
        {
            NSArray *temArray = [self.indexDate componentsSeparatedByString:@"-"];
            if (temArray.count==2)
            {
                self.currentYear = [temArray[0] intValue];
                self.currentMonth = [temArray[1] intValue];
            }
        }
        
        if (self.currentYear>=beginYear&&self.currentMonth>=1&&self.currentYear<(beginYear+100)&&self.currentMonth<=12)
        {
            [self.pickerView selectRow:self.currentYear-beginYear inComponent:0 animated:NO];
            [self.pickerView selectRow:self.currentMonth-1 inComponent:1 animated:NO];
        }
        else
        {
            [self.pickerView selectRow:0 inComponent:0 animated:NO];
            [self.pickerView selectRow:0 inComponent:1 animated:NO];
            
            self.currentYear = [yearMtbArray[0] intValue];
            self.currentMonth = [monthMtbArray[0] intValue];
        }
    }
    else if(self.pageType == kDatePickerTypeOnlyYear)
    {
        self.datePicker.hidden = YES;
        
        if (self.indexDate != Nil)
        {
            if ([self.indexDate intValue]>=beginYear&&[self.indexDate intValue]<beginYear+100)
            {
                self.currentYear = [self.indexDate intValue];
                [self.pickerView selectRow:self.currentYear-beginYear inComponent:0 animated:NO];
            }
        }
    }

}


#pragma mark--UIPickViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.pageType == kDatePickerTypeNoDay)
    {
        return 2;
    }
    else if(self.pageType == kDatePickerTypeOnlyYear)
    {
        return 1;
    }
    else if(self.pageType == kDatePickerTypeAddHour)
    {
        return 4;
    }
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.pageType == kDatePickerTypeNoDay)
    {
        return component==0?yearMtbArray.count:monthMtbArray.count;
    }
    else if(self.pageType == kDatePickerTypeOnlyYear)
    {
        return yearMtbArray.count;
    }
    else if(self.pageType == kDatePickerTypeAddHour)
    {
        if (component == 0 ) {
            return yearMtbArray.count;
            
        }else if (component == 1){
            return monthMtbArray.count;
            
        }else if (component == 2){
            if (firstTimeLoad)
            {
                if (_currentMonth == 1 || _currentMonth == 3 || _currentMonth == 5 || _currentMonth == 7 || _currentMonth == 8 || _currentMonth == 10 || _currentMonth == 12)
                {
                    return 31;
                }
                else if (_currentMonth == 2)
                {
                    if(((_currentYear %4==0)&&(_currentYear %100!=0))||(_currentYear %400==0)){
                        
                        return 29;
                    }
                    else
                    {
                        return 28; // or return 29
                    }
                }
                else
                {
                    return 30;
                }
            }
            else
            {
                if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
                {
                    return 31;
                }
                else if (selectedMonthRow == 1)
                {
                    int yearint = [[yearMtbArray objectAtIndex:selectedYearRow] intValue];
                    
                    if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                        
                        return 28;
                    }
                    else
                    {
                        return 29; // or return 29
                    }
                }
                else
                {
                    return 30;
                }
            }
            
        }else if (component == 3 ){
            
            return hourMtbArray.count;
        }
    }
    return 0;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (self.pageType == kDatePickerTypeNoDay)
    {
        return 150;
    }
    else if(self.pageType == kDatePickerTypeOnlyYear)
    {
        return 300;
    }
    else if(self.pageType == kDatePickerTypeAddHour)
    {
        return 65;
    }
    return 300;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.pageType == kDatePickerTypeNoDay)
    {
        if (component == 0)
        {
            return [NSString stringWithFormat:@"%@年",yearMtbArray[row]];
        }
        else if (component == 1)
        {
            return [NSString stringWithFormat:@"%@月",monthMtbArray[row]];
        }
    }
    else if(self.pageType == kDatePickerTypeOnlyYear)
    {
        return [NSString stringWithFormat:@"%@年",yearMtbArray[row]];
    }
    else if (self.pageType == kDatePickerTypeAddHour)
    {
        if (component == 0)
        {
            return [NSString stringWithFormat:@"%@",yearMtbArray[row]];
        }
        else if (component == 1)
        {
            return [NSString stringWithFormat:@"%@",monthMtbArray[row]];
        }
        else if (component == 2)
        {
            return [NSString stringWithFormat:@"%@",dayMtbArray[row]];
        }
        else if (component == 3)
        {
            return [NSString stringWithFormat:@"%@时",hourMtbArray[row]];
        }
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.pageType == kDatePickerTypeNoDay)
    {
        if (component == 0)
        {
            self.currentYear = [yearMtbArray[row] intValue];
        }
        else if (component == 1)
        {
            self.currentMonth = [monthMtbArray[row] intValue];
        }
        [self.pickerView reloadAllComponents];
    }
    else if(self.pageType == kDatePickerTypeOnlyYear)
    {
        self.currentYear = [yearMtbArray[row] intValue];
        [self.pickerView reloadAllComponents];
        
    }
    else if (self.pageType == kDatePickerTypeAddHour)
    {
        if (component == 0)
        {
            selectedYearRow = row;
            self.currentYear = [yearMtbArray[row] intValue];
            [self.pickerView reloadAllComponents];
        }
        else if (component == 1)
        {
            selectedMonthRow = row;
            self.currentMonth = [monthMtbArray[row] intValue];
            [self.pickerView reloadAllComponents];
            
        }else if (component == 2)
        {
            self.currentDay = [dayMtbArray[row] intValue];
            [self.pickerView reloadAllComponents];
        }
        else if (component == 3)
        {
            self.currentHour = [hourMtbArray[row] intValue];
            [self.pickerView reloadAllComponents];
        }
    }
    
    [self selectAction];
}

-(void)selectAction{
    if (self.pageType == kDatePickerTypeFull)
    {
        self.clickOkAction([CommonMethod getDateStrWithDate:self.datePicker.date withCutStr:@"-" hasTime:NO]);
    }
    else if(self.pageType == kDatePickerTypeNoDay)
    {
        if (self.currentMonth<10) //选择的月份小于10时 前面补个0
        {
            self.clickOkAction([NSString stringWithFormat:@"%d-0%d",self.currentYear,self.currentMonth]);
        }
        else
        {
            self.clickOkAction([NSString stringWithFormat:@"%d-%d",self.currentYear,self.currentMonth]);
        }
        
    }
    else if(self.pageType == kDatePickerTypeOnlyYear)
    {
        self.clickOkAction([NSString stringWithFormat:@"%d",self.currentYear]);
    }
    else if(self.pageType == kDatePickerTypeAddHour)  //yyyy%@MM%@dd HH:mm:ss
    {
        
        if (self.currentMonth<10) //选择的月份小于10时 前面补个0
        {
            if (self.currentDay < 10 )
            {
                
                if (self.currentHour < 10 ) {
                    
//                    self.clickOkAction([NSString stringWithFormat:@"%d-0%d-0%d 0%d时",self.currentYear,self.currentMonth,self.currentDay,self.currentHour]);
                    
                    [CacheMethod userDefaultSetValue:[NSString stringWithFormat:@"%d-0%d-0%d 0%d时",self.currentYear,self.currentMonth,self.currentDay,self.currentHour] forKey:@"dateStr"];
                    

                    
                }else{
                    
                    
//                    self.clickOkAction([NSString stringWithFormat:@"%d-0%d-0%d %d时",self.currentYear,self.currentMonth,self.currentDay,self.currentHour]);
                    
                    [CacheMethod userDefaultSetValue:[NSString stringWithFormat:@"%d-0%d-0%d %d时",self.currentYear,self.currentMonth,self.currentDay,self.currentHour] forKey:@"dateStr"];

                }
                
            }
            else
            {
                if (self.currentHour < 10 ) {
//                    self.clickOkAction([NSString stringWithFormat:@"%d-0%d-%d 0%d时",self.currentYear,self.currentMonth,self.currentDay,self.currentHour]);
                    
                    [CacheMethod userDefaultSetValue:[NSString stringWithFormat:@"%d-0%d-%d 0%d时",self.currentYear,self.currentMonth,self.currentDay,self.currentHour] forKey:@"dateStr"];

                    
                }else{
//                    self.clickOkAction([NSString stringWithFormat:@"%d-0%d-%d %d时",self.currentYear,self.currentMonth,self.currentDay,self.currentHour]);
                    
                    [CacheMethod userDefaultSetValue:[NSString stringWithFormat:@"%d-0%d-%d %d时",self.currentYear,self.currentMonth,self.currentDay,self.currentHour] forKey:@"dateStr"];
                }
                
            }
        }
        else
        {
            if (self.currentDay < 10 )
            {
                if (self.currentHour < 10 ) {
//                    self.clickOkAction([NSString stringWithFormat:@"%d-%d-0%d 0%d时",self.currentYear,self.currentMonth,self.currentDay,self.currentHour]);
                    
                    [CacheMethod userDefaultSetValue:[NSString stringWithFormat:@"%d-%d-0%d 0%d时",self.currentYear,self.currentMonth,self.currentDay,self.currentHour] forKey:@"dateStr"];

                    
                }else{
//                    self.clickOkAction([NSString stringWithFormat:@"%d-%d-0%d %d时",self.currentYear,self.currentMonth,self.currentDay,self.currentHour]);
                    [CacheMethod userDefaultSetValue:[NSString stringWithFormat:@"%d-%d-0%d %d时",self.currentYear,self.currentMonth,self.currentDay,self.currentHour] forKey:@"dateStr"];

                }
            }
            else
            {
                
                if (self.currentHour < 10 ) {
                    
//                    self.clickOkAction([NSString stringWithFormat:@"%d-%d-%d 0%d时",self.currentYear,self.currentMonth,self.currentDay,self.currentHour]);
                    
                    [CacheMethod userDefaultSetValue:[NSString stringWithFormat:@"%d-%d-%d 0%d时",self.currentYear,self.currentMonth,self.currentDay,self.currentHour] forKey:@"dateStr"];

                    
                }else{
//                    self.clickOkAction([NSString stringWithFormat:@"%d-%d-%d %d时",self.currentYear,self.currentMonth,self.currentDay,self.currentHour]);
                    
                    [CacheMethod userDefaultSetValue:[NSString stringWithFormat:@"%d-%d-%d %d时",self.currentYear,self.currentMonth,self.currentDay,self.currentHour] forKey:@"dateStr"];

                }
            }
        }
    }
}




@end
