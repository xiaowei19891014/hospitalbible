//
//  HomeViewController.m
//  HospitalBible
//
//  Created by me on 17/5/13.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "HomeViewController.h"
#import "CateGoryCell.h"
#import "AppointmentReminderCell.h"
#import "QuestionsCell.h"
#import "QRScanViewController.h"
#import "AppointmentRemindTipsViewController.h"
#import "QuestionBankViewController.h"
#import "UIControl+BlocksKit.h"
#import "FeedbackViewController.h"
#import "HomeViewModel.h"
#import "DiseaseQuestionModel.h"
#import "QuestionBankViewController.h"

@interface HomeViewController () <SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataSources;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) NSMutableArray *asthmaArr; // 哮喘病数组
@property (nonatomic, strong) HomeViewModel *viewModel;

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _asthmaArr = [[NSMutableArray alloc]init];
    self.viewModel = [[HomeViewModel alloc] init];

    [self initTableView];
    [self initCycleScrollView];
    [self initNav];//12444
    
    //广告数据请求
    [self showLoadingHUD];
    [HomeViewModel requestAdvertisementListSuccessHandler:^(NSDictionary* result) {
        [self hideLoadingHUD];
        self.cycleScrollView.imageURLStringsGroup = [HomeViewModel getAdvertisementListImageWithRequestArr:result[@"advertisement"]];
        _asthmaArr = result[@"diseaseQuestionClass"];
        if (_asthmaArr.count > 0) {
            [self.tableview reloadData];
        }
    } errorHandler:^(NSError *error) {
        [self hideLoadingHUD];
        NSLog(@"%@",error);
    }];
    
    
    [HomeViewModel requestDiseasequestionListWithClassId:@"0" successHandler:^(id result) {
        NSLog(@"%@",result);
        self.viewModel.listArr = result;
    } errorHandler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    [HomeViewModel requestAllDiseasequestionListSuccessHandler:^(id result) {
        NSLog(@"%@",result);
    } errorHandler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)initNav
{
    UIBarButtonItem *scanBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"scan_icon.png"] style:(UIBarButtonItemStyleDone) target:self action:@selector(clickScanAction:)];
    self.navigationItem.leftBarButtonItem = scanBarButton;
}
- (void)clickScanAction:(UIButton *)button
{
    QRScanViewController *scanVC = [[QRScanViewController alloc] init];

    [self.navigationController pushViewController:scanVC animated:YES];
}
- (void)initTableView
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview registerNib:[UINib nibWithNibName:@"AppointmentReminderCell" bundle:nil] forCellReuseIdentifier:@"AppointmentReminderCell"];
    [tableview registerNib:[UINib nibWithNibName:@"QuestionsCell" bundle:nil] forCellReuseIdentifier:@"QuestionsCell"];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    self.tableview = tableview;
}

- (void)initCycleScrollView
{
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];

    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    self.cycleScrollView = cycleScrollView2;
    self.tableview.tableHeaderView = cycleScrollView2;
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 120;
    }
    else if (indexPath.row == 1) {
        return 40;
    }
    else if (indexPath.row == 2) {
        return 240;
    }
    else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CateGoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CateGoryCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CateGoryCell" owner:self options:nil] lastObject];
            [cell.cateGoryButton bk_addEventHandler:^(id  _Nonnull sender) {
                QuestionBankViewController *vc = [[QuestionBankViewController alloc]init];
                vc.dataSources = self.viewModel.listArr;
                vc.isCateGory = YES;
                [self.navigationController pushViewController:vc animated:YES];
            } forControlEvents:(UIControlEventTouchUpInside)];
            
            [cell.feedbackButton bk_addEventHandler:^(id  _Nonnull sender) {
                FeedbackViewController *vc = [[FeedbackViewController alloc] initWithNibName:@"FeedbackViewController" bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
            } forControlEvents:(UIControlEventTouchUpInside)];
            
            [cell.contactUsButton bk_addEventHandler:^(id  _Nonnull sender) {
                UIWebView * callWebview = [[UIWebView alloc]init];
                [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel:10010"]]];
                [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
                
            } forControlEvents:(UIControlEventTouchUpInside)];
        }
        return cell;
    }
    else if (indexPath.row == 1) {
        AppointmentReminderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppointmentReminderCell" forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.row == 2) {
        QuestionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionsCell" forIndexPath:indexPath];
        [cell creatTheUIWithDate:_asthmaArr];
        [cell setClickAction:^{
            QuestionBankViewController *vc = [[QuestionBankViewController alloc] init];
            vc.dataSources = self.viewModel.listArr;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        return cell;
    }

    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        AppointmentRemindTipsViewController *vc = [[AppointmentRemindTipsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);

    QuestionBankViewController *vc = [[QuestionBankViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
