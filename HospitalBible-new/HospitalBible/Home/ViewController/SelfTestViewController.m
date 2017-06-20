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

@interface SelfTestViewController ()<SwipeViewDataSource, SwipeViewDelegate>
@property(nonatomic,assign) NSInteger time;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UIImageView *clockImageView;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) SwipeView *swipeView;
@property(nonatomic,strong) NSArray *dataArray;

@end

@implementation SelfTestViewController

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
}

- (void)setModel:(DiseaseQuestionClass *)model
{
    _model = model;
    _dataArray = model.diseasequestionArr;
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
    __block typeof(swipeView) weakView = swipeView;
    [scrollView setNextBtnClickAction:^(NSInteger currentIndex) {
        if (currentIndex < weakView.numberOfPages-1) {
             [weakView scrollToPage:currentIndex+1 duration:0.25];
        }else{
            NSLog(@"完成");
        }
    }];

    if (index == swipeView.numberOfPages - 1) {
        [scrollView.nextBtn setTitle:@"交卷" forState:UIControlStateNormal];
    }
    
//    CGFloat red = arc4random() / (CGFloat)INT_MAX;
//    CGFloat green = arc4random() / (CGFloat)INT_MAX;
//    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
//    view.backgroundColor = [UIColor colorWithRed:red
//                                           green:green
//                                            blue:blue
//                                           alpha:1.0];
    view.backgroundColor = [UIColor whiteColor];
    
    return view;
};

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.swipeView.bounds.size;
}

-(void)test{
    
    AnswerModel *model1 = [AnswerModel new];
    model1.title = @"一，这是第一个题";
    model1.options = @[@"1、风险测评旨在帮助您了解自己的风险偏好和风险承受能力风险测评旨在帮助您了解自己的风险偏好和风险承受能力风险测评旨在帮助您了解自己的风险偏好和风险承受能力风险测评旨在帮助您了解自己的风险偏好和风险承受能力",
                       @"2、您提供的信息应当真实、准确、完整，我们的风险评价将基于",
                       @"3、本测试结果的有效期为12个月"];
    model1.result =@[@"A"];
    model1.selectedResult = @"";
    
    AnswerModel *model2 = [AnswerModel new];
    model2.title = @"二，这是第二个题";
    model2.options = @[@"1、风险测评旨在帮助您了解自己的风险偏好和风险承受能力",
                       @"2、您提供的信息应当真实、准确、完整，我们的风险评价将基于",
                       @"3、本测试结果的有效期为12个月"];
    model2.result =@[@"A",@"B"];
    model2.selectedResult = @"";
    
    AnswerModel *model3 = [AnswerModel new];
    model3.title = @"三，这是第三个题";
    model3.options = @[@"1、风险测评旨在帮助您了解自己的风险偏好和风险承受能力",
                       @"2、您提供的信息应当真实、准确、完整，我们的风险评价将基于",
                       @"3、本测试结果的有效期为12个月"];
    model3.result =@[@"A",@"C"];
    model3.selectedResult = @"";
    
//    [self.dataSources addObjectsFromArray:@[model1,model2,model3]];
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

@end
