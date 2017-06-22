//
//  RemindDetailViewController.m
//  HospitalBible
//
//  Created by 边瑞康 on 2017/5/17.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "RemindDetailViewController.h"
#import "RemindDetailTableViewCell.h"
@interface TradeSuccessFootView : UIView
@property (nonatomic, copy) void (^tradeSuccessBlock)();
@property (nonatomic, strong) UIButton *tradeSuccessBtn;
@end

@implementation TradeSuccessFootView
- (instancetype)initWithFrame:(CGRect)frame;
{
    if (self = [super initWithFrame:frame]) {
        [self initializeUI];
    }
    return self;
}
- (void)initializeUI
{
    _tradeSuccessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_tradeSuccessBtn setTitle:@"取消预约" forState:UIControlStateNormal];
    [_tradeSuccessBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_tradeSuccessBtn addTarget:self action:@selector(tradeSuccessBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _tradeSuccessBtn.layer.cornerRadius = 20;
    _tradeSuccessBtn.layer.masksToBounds = YES;
    _tradeSuccessBtn.layer.borderWidth = 1;

    [self addSubview:_tradeSuccessBtn];

    _tradeSuccessBtn.translatesAutoresizingMaskIntoConstraints = NO;


    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-32-[_tradeSuccessBtn(44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tradeSuccessBtn)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-120-[_tradeSuccessBtn]-120-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tradeSuccessBtn)]];
}
- (void)tradeSuccessBtnClick
{
    if (self.tradeSuccessBlock) {
        self.tradeSuccessBlock();
    }
}

@end

@interface RemindDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;


@end

@implementation RemindDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"预约详情";
    
    [self initTableView];
}
- (void)initTableView
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview registerNib:[UINib nibWithNibName:@"RemindDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"RemindDetailTableViewCell"];
    [self.view addSubview:tableview];
    tableview.rowHeight = 240;
//    TradeSuccessFootView *footView = [[TradeSuccessFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
//    footView.tradeSuccessBlock = ^{
//
//    };
    tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableview = tableview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RemindDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RemindDetailTableViewCell"];

    cell.lable1.text = _model.hospitalName;
    cell.lable2.text = _model.address;
    cell.lable3.text = _model.departmentName;
    cell.lable4.text = _model.doctorName;
    cell.lable5.text = _model.appointdate;
    
    
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
