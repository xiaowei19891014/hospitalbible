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
@interface SelfTestViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *dataSources;
@property(nonatomic,assign) NSInteger time;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UIImageView *clockImageView;
@property(nonatomic,assign) CGFloat scrollIndex;
@property(nonatomic,strong) UIButton *summitButton;
@property(nonatomic,strong) NSTimer *timer;
@end

@implementation SelfTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    //[self test];
    
    //1.顶部倒计时
    [self.view addSubview:self.clockImageView];
    [self.view addSubview:self.timeLabel];
    
    //2.题目
    [self.view addSubview:self.collectionView];
    
    //3.最后一个单元格，添加提交按钮
    [self initSummitButton];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        _time++;
        _timeLabel.text = [NSString stringWithFormat:@"倒计时:%@", getMMSSFromSS(_time)];
        
    }];
    
//    [HomeViewModel requestDiseasequestionListWithClassId:@"2" successHandler:^(id result) {
//        self.dataSources = result;
//        [self.collectionView reloadData];
//    } errorHandler:^(NSError *error) {
//        
//    }];

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelfTestQuestionsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelfTestQuestionsCell" forIndexPath:indexPath];
    cell.mdel = self.dataSources[indexPath.row];
    return cell;
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
    
    [self.dataSources addObjectsFromArray:@[model1,model2,model3]];
}

-(NSMutableArray *)dataSources{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-160);
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.timeLabel.frame)+10, SCREEN_WIDTH, SCREEN_HEIGHT-160) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.bounces = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled  = YES;
        [_collectionView registerNib:[UINib nibWithNibName:@"SelfTestQuestionsCell" bundle:nil] forCellWithReuseIdentifier:@"SelfTestQuestionsCell"];
    }
    return _collectionView;
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
-(void)initSummitButton{
    UIButton *summit = [UIButton buttonWithType:(UIButtonTypeCustom)];
    summit.backgroundColor = [UIColor redColor];
    [summit setTitle:@"提交" forState:(UIControlStateNormal)];
    summit.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.5, 44);
    summit.center = CGPointMake((self.dataSources.count-1)*SCREEN_WIDTH+SCREEN_WIDTH*0.5, self.collectionView.frame.size.height - 22-10);
    summit.layer.cornerRadius = 22;
    summit.backgroundColor = [UIColor colorWithHexString:@"0FA49E"];
    summit.layer.masksToBounds = YES;
    [self.collectionView addSubview:summit];
    [summit bk_addEventHandler:^(id  _Nonnull sender) {
        
        if ([self isNoCompleteQuestions]) {
            [self showErrorMessage:@"您还有未打完的题目"];
        }else{//提交,上送结果到服务器
            [_timer invalidate];
            _time = 0;
            [self showErrorMessage:@"提交成功"];
        }
    } forControlEvents:(UIControlEventTouchUpInside)];
}

-(BOOL)isNoCompleteQuestions{
    for (AnswerModel *model in self.dataSources) {
        if ([model.selectedResult isEqualToString:@""]) {
            return YES;
        }
    }
    return NO;
}
-(NSArray*)getCompletedAnswersResult{
    NSMutableArray *results = [NSMutableArray array];
    for (AnswerModel *model in self.dataSources) {
        [results addObject:model.selectedResult];
    }
    return results;
    
}
@end
