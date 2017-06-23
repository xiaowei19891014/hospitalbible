//
//  HistoryDetailViewController.m
//  HB
//
//  Created by LIFEI on 2017/5/24.
//  Copyright © 2017年 break. All rights reserved.
//

#import "HistoryDetailViewController.h"
#import "HistoryDetailSectionHeaderView.h"
#import "ChooseAnswersCell.h"
#import "AnswerModel.h"
#import "QuestionBankViewModel.h"
#import "HistoryDetailViewModel.h"
#import "HistoryTableViewCell.h"

@interface HistoryDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataSources;

@end

@implementation HistoryDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史详情";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:(UITableViewStyleGrouped)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80;
    [self.tableView registerNib:[UINib nibWithNibName:@"HistoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellid"];
    [self.view addSubview:self.tableView];
    
//    /api/chr/result/list
    
//    {"userId":2147483647,"classid":1}
    [self showLoadingHUD];
    NSDictionary *params = @{@"userId":[UserInfoShareClass sharedManager].userId,
                             @"classid":NOTNIL(self.model.id)};
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:DISEASEQUEASETION_HISTORY_LIST params:params success:^(NSDictionary *responseObject) {
        [self hideLoadingHUD];
        NSLog(@"---%@--",responseObject);
        if ([responseObject[@"data"] count]) {
            self.dataSources = responseObject[@"data"];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self hideLoadingHUD];
        NSLog(@"---%@--",error);
    }];
    
}

-(NSMutableArray *)dataSources{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dict = self.dataSources[indexPath.row];
    cell.indexNumber= indexPath.row;
    return cell;
    
}
@end
