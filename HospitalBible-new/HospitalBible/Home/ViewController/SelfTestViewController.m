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
@property(nonatomic,strong) NSMutableArray *ansArr;
@property(nonatomic,strong) NSMutableArray *scoreArr;

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


static NSInteger finished;
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
        for (int i=0; i<self.scoreArr.count; i++) {
            NSInteger score = [self.scoreArr[i] integerValue];
            sum = sum + score;
        }
        
//        /api/chr/result/save
//        {"userid":2,"classid":1,"patientid":1,"result":"1","point":60，flag:true}
//        DISEASEQUEASETION_SAVE

        
        
        
        NSDictionary *dict = @{@"userid":@"",
                               @"classid":@"",
                               @"patientid":@"",
                               @"result":@"",
                               @"point":@"",
                               @"flag":@""};
        [[ERHNetWorkTool sharedManager] requestDataWithUrl:DISEASEQUEASETION_SAVE params:dict success:^(NSDictionary *responseObject) {
            
        } failure:^(NSError *error) {
            
        }];
    }else{
        [LGAlertViewExtension showAlertTitle:[NSString stringWithFormat:@"请选择第%ld题答案",finished+1] cancelTitle:@"取消" cancelHandler:nil destructiveTitle:@"确定" destructiveHandler:^{
            
        }];
    }
}

- (void)updateScore:(NSInteger)score flag:(BOOL)flag
{

    NSDictionary *dict = @{@"userid":[UserInfoShareClass sharedManager].userId,
                           @"classid":self.model.id,
                           @"patientid":self.userId,
                           @"result":@"",
                           @"point":[NSString stringWithFormat:@"%ld",score],
                           @"flag":flag ? @"ture":@"false"};
    [self showLoadingHUD];
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:DISEASEQUEASETION_SAVE params:dict success:^(NSDictionary *responseObject) {
        [self hideLoadingHUD];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [self hideLoadingHUD];
    }];
}


@end
