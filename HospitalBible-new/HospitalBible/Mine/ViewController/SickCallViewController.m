//
//  SickCallViewController.m
//  HospitalBible
//
//  Created by 边瑞康 on 2017/5/25.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "SickCallViewController.h"
#import "SickCallTableViewCell.h"
#import "UserInfoModel.h"
#import "AddSickViewController.h"
@interface SickCallHeadView : UIView
@property (nonatomic,strong)UILabel *tipsLabel;

@end

@implementation SickCallHeadView
- (instancetype)initWithFrame:(CGRect)frame;
{
    if (self = [super initWithFrame:frame]) {
        [self initializeUI];
    }
    return self;
}
-(void)initializeUI
{
    self.backgroundColor = [UIColor whiteColor];
    _tipsLabel = [[UILabel alloc]init];
    _tipsLabel.text = @"已添加2人,还能添加4人";
    _tipsLabel.font = [UIFont systemFontOfSize:14];
    _tipsLabel.textColor = [UIColor colorWithHexString:@"9B9B9B"];
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_tipsLabel];
    
    _tipsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_tipsLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_tipsLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    
    
}
@end


@interface SickCallViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataSources;


@end

@implementation SickCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSources = [[NSMutableArray alloc]init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"就诊人列表";
    [self initTableView];
    [self configRightItemWithType:@"添加就诊人"];
    [self startRequestData];
    
}

-(void)startRequestData{
    [self showLoadingHUD];
    NSDictionary *params = @{
                             @"userId":[UserInfoShareClass sharedManager].userId
                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:PATIENT_LIST params:params success:^(NSDictionary *responseObject) {
        [self hideLoadingHUD];
        _dataSources =   [UserInfoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableview reloadData];

    } failure:^(NSError *error) {
        [self hideLoadingHUD];
    }];

}

-(void)rightAction:(UIButton *)sender{
    
    AddSickViewController* vc= [[AddSickViewController alloc] init];
    [vc setAddSuccessBlock:^{
        [self startRequestData ];
    }];
    [self.navigationController pushViewController:vc animated:YES];


}
- (void)initTableView
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    tableview.delegate = self;
    tableview.dataSource = self;
//    SickCallHeadView *headView = [[SickCallHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//    tableview.tableHeaderView = headView;
    tableview.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:tableview];
    self.tableview = tableview;
    [_tableview registerNib:[UINib nibWithNibName:@"SickCallTableViewCell" bundle:nil] forCellReuseIdentifier:@"SickCallTableViewCell"];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSources.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        SickCallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SickCallTableViewCell"];
        UserInfoModel *model = _dataSources[indexPath.row];
    cell.sex.text = [model.sex isEqualToString:@"M"] ?@"性别：女":@"性别：男";
    cell.name.text = model.pname;
    cell.number.text = model.idcard;
        cell.accessoryType =UITableViewCellAccessoryNone;// UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInfoModel *model = _dataSources[indexPath.row];
    [self showLoadingHUD];
    NSDictionary *params = @{
                             @"userId":[UserInfoShareClass sharedManager].userId
                             @"id":model.id
                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:PATIENT_DELETE params:params success:^(NSDictionary *responseObject) {
        [self hideLoadingHUD];
        // 从数据源中删除
        [_dataSources removeObjectAtIndex:indexPath.row];
        //    // 从列表中删除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    } failure:^(NSError *error) {
        [self hideLoadingHUD];
    }];
    

}



- (void)didReceiveMemoryWarning {
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
