//
//  UserInfoViewController.m
//  HospitalBible
//
//  Created by 边瑞康 on 2017/5/17.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoHeadTableViewCell.h"
#import "UserInfoDocumentTypeCell.h"
#import "UserInfoSexCell.h"
#import "UserInfoModel.h"
#import "UserInfoViewModel.h"
#import "UserInfoShareClass.h"
#import "UserTableViewCell.h"

@interface UserInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *dataSources;
@property (nonatomic, strong) NSArray *infoArr;

@property(nonatomic,assign) BOOL isCanEdit;//是否可以编辑
@end

@implementation UserInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人信息";
    self.dataSources = getUserInfpTitleList();
    [UserInfoViewModel requestUserInfoWithUserId:[UserInfoShareClass sharedManager].userId successHandler:^(id result) {
        _infoArr =(NSArray*)result;
        [_tableview reloadData];
    } errorHandler:^(NSError *error) {
    
    }];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initTableView];
    [self configRightItemWithType:@"编辑"];
}

-(void)rightAction:(UIButton *)sender{

    if ([sender.titleLabel.text isEqualToString:@"编辑"]) {
        [sender setTitle:@"保存" forState:UIControlStateNormal];
        _isCanEdit = YES;
    }
    if ([sender.titleLabel.text isEqualToString:@"保存"]) {
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        _isCanEdit = NO;

    }
    [self.tableview reloadData];
}

- (void)initTableView
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    self.tableview = tableview;
    [_tableview registerNib:[UINib nibWithNibName:@"UserInfoHeadTableViewCell" bundle:nil] forCellReuseIdentifier:@"UserInfoHeadTableViewCell"];
    [_tableview registerNib:[UINib nibWithNibName:@"UserInfoDocumentTypeCell" bundle:nil] forCellReuseIdentifier:@"UserInfoDocumentTypeCell"];
    
    [_tableview registerNib:[UINib nibWithNibName:@"UserInfoSexCell" bundle:nil] forCellReuseIdentifier:@"UserInfoSexCell"];
    [_tableview registerNib:[UINib nibWithNibName:@"UserTableViewCell" bundle:nil] forCellReuseIdentifier:@"UserTableViewCell"];
    self.tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSources.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        return 80;
    }else
    {
        return 44;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *ID = @"setting1";
    if (indexPath.row ==0) {
        UserInfoHeadTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"UserInfoHeadTableViewCell"];
        return cell;
    }else if(indexPath.row ==2)
    {
        UserInfoDocumentTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoDocumentTypeCell"];
        return cell;

    }else if (indexPath.row==4)
    {
        UserInfoSexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoSexCell"];
        return cell;

    }
    else{
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserTableViewCell"];
    cell.titleLab.text = self.dataSources[indexPath.row];
    cell.myTextField.text = _infoArr[indexPath.row];
        if (_isCanEdit) {
            cell.myTextField.enabled = YES;
        }else{
            cell.myTextField.enabled = NO;

        }
    return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    UserLoginViewController *vc = [[UserLoginViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}
- (NSArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [NSArray array];
    }
    return _dataSources;
}
@end
