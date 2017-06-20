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
    
//    [ERHErrorRequestView addErrorView:self title:@"微课堂暂时没有收藏" image:[UIImage imageNamed:@"tishi_big_banner"] frame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) touch:^{
//        
//    }];
    
}

- (void)initTableView
{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -44)];
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
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MircoClasssCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MircoClasssCell"];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MircoClassDetailViewController *detailVC = [[MircoClassDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:NO];
    
}

- (NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

@end
