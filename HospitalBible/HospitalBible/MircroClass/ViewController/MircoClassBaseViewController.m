//
//  MircoClassBaseViewController.m
//  HospitalBible
//
//  Created by me on 17/5/14.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "MircoClassBaseViewController.h"
#import "MircoClassDetailViewController.h"
#import "MircoClasssCell.h"
#import "MircoClassViewModel.h"
#import "MJRefresh.h"

@interface MircoClassBaseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableview;
@property (nonatomic , strong) NSMutableArray *dataSources;

@end

@implementation MircoClassBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];

    [self requestNetWork];
}

- (void)initTableView
{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64-49-44)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.rowHeight = 94;
    tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    [tableview registerNib:[UINib nibWithNibName:@"MircoClasssCell" bundle:nil] forCellReuseIdentifier:@"MircoClasssCell"];
    [self.view addSubview:tableview];
    self.tableview = tableview;
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullRefresh)];

}

-(void)pullRefresh{

    [self requestNetWork];
}

- (void)requestNetWork {
    [self showLoadingHUD];
    [MircoClassViewModel requestDiscoverListWithDisclsid:_disclsidStr successHandler:^(id result) {
        [self hideLoadingHUD];
        self.dataSources = result;
        [self.tableview reloadData];
        [self.tableview.mj_header endRefreshing];
    } errorHandler:^(NSError *error) {
        [self hideLoadingHUD];
        [self.tableview.mj_header endRefreshing];

        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MircoClassListModel *listModel = self.dataSources[indexPath.row];
    MircoClasssCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MircoClasssCell"];
    cell.listModel = listModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MircoClassDetailViewController *detailVC = [UIStoryboard MircoClassDetailViewController];
    [detailVC setModel:self.dataSources[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

@end
