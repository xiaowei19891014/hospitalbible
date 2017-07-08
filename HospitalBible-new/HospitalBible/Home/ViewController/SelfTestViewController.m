//
//  SelfTestViewController.m
//  HospitalBible
//
//  Created by me on 17/5/17.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "SelfTestViewController.h"
#import "SelfTestQuestionsCell.h"
#import "AnswerModel.h"
#import "SubmitTaskView.h"
#import "NSTimer+BlocksKit.h"
#import "UIControl+BlocksKit.h"
#import "UIButton+ImageTitleSpacing.h"
#import "UIView+ActivityIndicator.h"
#import "HomeViewModel.h"
#import "SwipeView.h"
#import "LGQuestionView.h"
#import "NSDate+gyh.h"

@interface SelfTestViewController ()<SwipeViewDataSource, SwipeViewDelegate>
@property(nonatomic,assign) NSInteger time;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UIImageView *clockImageView;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) SwipeView *swipeView;
@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,strong) NSMutableArray *ansArr;
@property(nonatomic,strong) NSMutableArray *scoreArr;
@property(nonatomic,strong) NSDate *startDate;

@end

@implementation SelfTestViewController

- (NSMutableArray *)ansArr
{
    if (!_ansArr) {
        _ansArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _ansArr;
}

- (NSMutableArray *)scoreArr
{
    if (!_scoreArr) {
        _scoreArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _scoreArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"自检答题";
    
    //1.顶部倒计时
    [self.view addSubview:self.clockImageView];
    [self.view addSubview:self.timeLabel];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        _time++;
        _timeLabel.text = [NSString stringWithFormat:@"倒计时:%@", getMMSSFromSS(_time)];
    }];
    
    self.swipeView = [[SwipeView alloc] initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, SCREEN_HEIGHT-160)];
    self.swipeView.dataSource = self;
    self.swipeView.delegate = self;
    [self.view addSubview:self.swipeView];
    
    self.startDate = [NSDate date];
}

- (void)setModel:(DiseaseQuestionClass *)model
{
    _model = model;
    _dataArray = model.diseasequestionArr;
    
    for (int i =0 ; i<model.diseasequestionArr.count; i++) {
        [self.ansArr addObject:@0];
        [self.scoreArr addObject:@0];
    }
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return self.dataArray.count;
}
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    LGQuestionView *scrollView = (LGQuestionView *)view;
    if (scrollView == nil)
    {
       
        scrollView = [[LGQuestionView alloc] initWithFrame:self.swipeView.bounds];
        view = scrollView;
    }
    
    DiseaseQuestionModel *model = self.dataArray[index];
    scrollView.index = index;
    scrollView.model = model;
    scrollView.currentSelectedIndex = [self.ansArr[index] integerValue];
    __block typeof(swipeView) weakView = swipeView;
    [scrollView setNextBtnClickAction:^(NSInteger currentIndex) {
        if (currentIndex < weakView.numberOfPages-1) {
             [weakView scrollToPage:currentIndex+1 duration:0.25];
        }else{
            NSLog(@"完成");
            [self checkResult];
        }
    }];
    
    __block typeof(self) weakSelf = self;
    [scrollView setTapAction:^(NSInteger index, NSInteger selNumber,NSInteger score) {
        [weakSelf.ansArr replaceObjectAtIndex:index withObject:@(selNumber)];
        [weakSelf.scoreArr replaceObjectAtIndex:index withObject:@(score)];
    }];

    if (index == swipeView.numberOfPages - 1) {
        [scrollView.nextBtn setTitle:@"交卷" forState:UIControlStateNormal];
    }
    
    view.backgroundColor = [UIColor whiteColor];
    
    return view;
};

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.swipeView.bounds.size;
}

-(UIImageView *)clockImageView{
    if (!_clockImageView) {
        _clockImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 139, 46)];
        _clockImageView.center = CGPointMake(SCREEN_WIDTH*0.5, 97);
        
        _clockImageView.image  =[ UIImage imageNamed:@"subscribe_big_laolin_icon"];
    }
    return _clockImageView;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.clockImageView.frame)+10, SCREEN_WIDTH, 20)];
        _timeLabel.text = @"倒计时:00:00:00";
        _timeLabel.font  =[UIFont systemFontOfSize:14];
        _timeLabel.textColor = [UIColor colorWithHexString:@"001627"];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}


static int finished;
- (void)checkResult
{
    finished = -1;
    [self.ansArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *num = (NSNumber *)obj;
        if ([num integerValue] == 0) {
            finished = idx;
            *stop = YES;
        }
    }];
    
    if (finished == -1) {
//        提交
        NSInteger sum = 0;
        NSString *result = @"";
        for (int i=0; i<self.scoreArr.count; i++) {
            NSInteger score = [self.scoreArr[i] integerValue];
            result = [NSString stringWithFormat:@"%@%@",result,self.scoreArr[i]];
            sum = sum + score;
        }
        
//        /api/chr/result/save
//        {"userid":2,"classid":1,"patientid":1,"result":"1","point":60，flag:true}
//        DISEASEQUEASETION_SAVE
//        计算一下本次答题总分值，弹出框提示：“您本次测试结果为60分，您当前病情严重程度为：严重，病情已经进入控制警戒线，建议您及时就医。系统将自动为您预约最近的医院，是否预约？”  / 如果大于60则：“您本次测试结果为80分，您当前病情稳定”只有一个确定按钮，点击是按钮上送预约 ，预约字段为true，点击否(确定)预约字段为false， 预约详情因为数据库设计不合理目前无法实现，暂时只上送
        if (sum <= [self.model.arrangemax integerValue]) {
            [LGAlertViewExtension showAlertTitle:[NSString stringWithFormat:@"您本次测试结果为%ld分，您当前病情严重程度为：严重，病情已经进入控制警戒线，建议您及时就医。系统将自动为您预约最近的医院，是否预约？",(long)sum] cancelTitle:@"否" cancelHandler:^{
                [self updateScore:sum flag:NO result:result];
            } destructiveTitle:@"是" destructiveHandler:^{
                [self updateScore:sum flag:YES result:result];
            }];
        }else{
            [self updateScore:sum flag:NO result:result];
        }
    }else{
        [LGAlertViewExtension showAlertTitle:[NSString stringWithFormat:@"请选择第%d题答案",finished+1] cancelTitle:@"取消" cancelHandler:nil destructiveTitle:@"确定" destructiveHandler:^{
        }];
    }
}

- (void)updateScore:(NSInteger)score flag:(BOOL)flag result:(NSString *)result
{

//    {"userid":2,"classid":1,"patientid":1,"result":"1","point":60,"flag":"false"}
    NSDateComponents *endDate = [self.startDate deltaWithNow];
    NSInteger hour = endDate.hour;
    NSInteger Minute = endDate.minute;
    NSInteger senond = endDate.second;
    
    NSString *hourTime = [NSString stringWithFormat:@"%ld",(long)hour];
    NSString *MinuteTime = [NSString stringWithFormat:@"%ld",(long)Minute];
    NSString *senondTime = [NSString stringWithFormat:@"%ld",(long)senond];
    
    if (hourTime.length == 1) {
        hourTime = [NSString stringWithFormat:@"0%@",hourTime];
    }
    
    if (MinuteTime.length == 1) {
        MinuteTime = [NSString stringWithFormat:@"0%@",MinuteTime];
    }
    
    if (senondTime.length == 1) {
        senondTime = [NSString stringWithFormat:@"0%@",senondTime];
    }
    
    NSString *date = [NSString stringWithFormat:@"%@:%@:%@",hourTime,MinuteTime,senondTime];
    
    NSDictionary *dict = @{@"userId":[UserInfoShareClass sharedManager].userId,
                           @"classid":self.model.id,
                           @"patientid":self.userId,
                           @"result":result,
                           @"point":[NSString stringWithFormat:@"%ld",score],
                           @"flag":flag ? @"true":@"false",
                           @"date":date};
    [self showLoadingHUD];
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:DISEASEQUEASETION_SAVE params:dict success:^(NSDictionary *responseObject) {
        [self hideLoadingHUD];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    } failure:^(NSError *error) {
        [self hideLoadingHUD];
        if (!error) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }
    }];
}


@end
