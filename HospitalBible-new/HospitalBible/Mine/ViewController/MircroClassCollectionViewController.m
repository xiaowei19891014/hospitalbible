//
//  MircroClassCollectionViewController.m
//  HospitalBible
//
//  Created by LIFEI on 2017/5/25.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "MircroClassCollectionViewController.h"
#import "ERHErrorRequestView.h"
#import "MircoClassDetailViewController.h"
#import "MircoClasssCell.h"
@interface MircroClassCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableview;
@property (nonatomic , strong) NSMutableArray *dataSources;

@end

@implementation MircroClassCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancleOrAddCollection) name:@"cancleOrAddCollection" object:nil];
    
    [self showLoadingHUD];
    NSDictionary *dict = @{@"type":@"0",
                           @"userId":[UserInfoShareClass sharedManager].userId};
    [[ERHNetWorkTool sharedManager]  requestDataWithUrl:COLLECTION_DISCOVERLIST params:dict success:^(NSDictionary *responseObject) {
        [_dataSources removeAllObjects];
        if ([responseObject[@"collection"] count]) {
            NSArray *arr = responseObject[@"collection"];
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MircoClassListModel *model = [MircoClassListModel mj_objectWithKeyValues:obj];
                [self.dataSources addObject:model];
            }];
        }
        [self hideLoadingHUD];
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        [self hideLoadingHUD];
    }];
}

- (void)cancleOrAddCollection
{
    NSDictionary *dict = @{@"type":@"0",
                           @"userId":[UserInfoShareClass sharedManager].userId};
    [[ERHNetWorkTool sharedManager]  requestDataWithUrl:COLLECTION_DISCOVERLIST params:dict success:^(NSDictionary *responseObject) {
        [_dataSources removeAllObjects];
        if ([responseObject[@"collection"] count]) {
            NSArray *arr = responseObject[@"collection"];
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MircoClassListModel *model = [MircoClassListModel mj_objectWithKeyValues:obj];
                [self.dataSources addObject:model];
            }];
        }
        [self.tableview reloadData];
    } failure:^(NSError *error) {
    }];
}


- (void)initTableView
{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -44-64)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.rowHeight = 94;
    [tableview registerNib:[UINib nibWithNibName:@"MircoClasssCell" bundle:nil] forCellReuseIdentifier:@"MircoClasssCell"];
    [self.view addSubview:tableview];
    self.tableview = tableview;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    footerView.backgroundColor = [UIColor clearColor];
    self.tableview.tableFooterView = footerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MircoClassListModel *model = self.dataSources[indexPath.row];
    MircoClasssCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MircoClasssCell"];
    cell.listModel = model;
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
