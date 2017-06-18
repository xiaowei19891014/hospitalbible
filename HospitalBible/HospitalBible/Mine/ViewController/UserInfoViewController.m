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
@interface UserInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *dataSources;
@property (nonatomic, strong) NSArray *infoArr;
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
}

- (void)initTableView
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    self.tableview = tableview;
    [_tableview registerNib:[UINib nibWithNibName:@"UserInfoHeadTableViewCell" bundle:nil] forCellReuseIdentifier:@"UserInfoHeadTableViewCell"];
    [_tableview registerNib:[UINib nibWithNibName:@"UserInfoDocumentTypeCell" bundle:nil] forCellReuseIdentifier:@"UserInfoDocumentTypeCell"];
    
    [_tableview registerNib:[UINib nibWithNibName:@"UserInfoSexCell" bundle:nil] forCellReuseIdentifier:@"UserInfoSexCell"];
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
    static NSString *ID = @"setting1";
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = self.dataSources[indexPath.row];
    cell.detailTextLabel.text = _infoArr[indexPath.row];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    cell.accessoryType =UITableViewCellAccessoryNone;// UITableViewCellAccessoryDisclosureIndicator;
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
