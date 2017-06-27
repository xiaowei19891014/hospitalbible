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
#import "NSString+EAddition.h"
@interface UserInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *dataSources;
@property (nonatomic, strong) NSArray *infoArr;

@property(nonatomic,assign) BOOL isCanEdit;//是否可以编辑
@property(nonatomic,strong)NSString* personSex; //性别
@property(nonatomic,strong)UIBarButtonItem *rightItem;


@end

@implementation UserInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人信息";
    self.dataSources = getUserInfpTitleList();
    [self showLoadingHUD];
    [UserInfoViewModel requestUserInfoWithUserId:[UserInfoShareClass sharedManager].userId successHandler:^(id result) {
        [self hideLoadingHUD];
        _infoArr =(NSArray*)result;
        [_tableview reloadData];
    } errorHandler:^(NSError *error) {
        [self hideLoadingHUD];
    }];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initTableView];
    [self configRightItemWithType:@"编辑"];
}

- (void)configRightItemWithType:(NSString *) buttonType
{
    UIButton *rightButton =[UIButton buttonWithType:UIButtonTypeSystem];
    [rightButton setFrame:CGRectMake(0.0, 0.0, 50, 30)];
    rightButton.tag=521;
    if ([buttonType isEqualToString:@"编辑"] || [buttonType isEqualToString:@"保存"] || [buttonType isEqualToString:@"添加就诊人"]) {
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        if ([buttonType isEqualToString:@"添加就诊人"]) {
            [rightButton setFrame:CGRectMake(0.0, 0.0, 80, 30)];
        }
        [rightButton setTitle:buttonType forState:UIControlStateNormal];
    }else{
        [rightButton setImage:[UIImage imageNamed:buttonType] forState:UIControlStateNormal];
    }
    rightButton.adjustsImageWhenHighlighted = NO;
    [rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

-(void)rightAction:(UIButton *)sender{

    if ([sender.titleLabel.text isEqualToString:@"编辑"]) {
        [sender setTitle:@"保存" forState:UIControlStateNormal];
        _isCanEdit = YES;
    }
    if ([sender.titleLabel.text isEqualToString:@"保存"]) {
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        _isCanEdit = NO;

        
        [self saveinfo];
    }
}

-(void)saveinfo{

    
    UserTableViewCell *cell1 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString *name = cell1.myTextField.text;

    UserTableViewCell *cell3 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    NSString *idNum = cell3.myTextField.text;

    UserTableViewCell *cell5 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    NSString *phoneNUm = cell5.myTextField.text;

    UserTableViewCell *cell6 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    NSString *age = cell6.myTextField.text;

    UserTableViewCell *cell7 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
    NSString *address = cell7.myTextField.text;

    UserTableViewCell *cell8 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
    NSString *heigh = cell8.myTextField.text;

    UserTableViewCell *cell9 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:9 inSection:0]];
    NSString *width = cell9.myTextField.text;
    
    UserTableViewCell *cell10 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:10 inSection:0]];
    NSString *birthDay = cell10.myTextField.text;

    UserTableViewCell *cell11 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:11 inSection:0]];
    NSString *email = cell11.myTextField.text;


    [self showLoadingHUD];
    NSDictionary *params = @{
                             @"userId":[UserInfoShareClass sharedManager].userId,
                             @"nickname":NOTNIL(name),
                             @"email":NOTNIL(email),
                             @"address":NOTNIL(address),
                             @"regdate":@"",
                             @"idtype":@"1",
                             @"idcard":NOTNIL(idNum),
                             @"imgurl":@"",
                             @"height":NOTNIL(heigh),
                             @"qQNum": _infoArr.lastObject,
                             @"weChat":@"",
                             @"weight":NOTNIL(width),
                             @"sex":NOTNIL(_personSex),
                             @"birthday": [NSString isValidID:idNum]? [idNum substringWithRange:NSMakeRange(6, 8)] : @"",
                             @"IDCard":NOTNIL(idNum),
                             @"phoneNum":NOTNIL(phoneNUm),
                             @"age":NOTNIL(age),
                             
                             @"id": NOTNIL(_infoArr.lastObject),

                             
                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:USER_USER_UPDATE params:params success:^(NSDictionary *responseObject) {
        [self hideLoadingHUD];
//        [self.tableview reloadData];
    } failure:^(NSError *error) {
        [self hideLoadingHUD];
    }];
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
        
        _personSex = _infoArr[indexPath.row];
        if ([_personSex isEqualToString:@"M"]) {
            cell.manBtn.selected =YES;
            cell.womanBtn.selected = NO;
        }else{
            cell.manBtn.selected = NO;
            cell.womanBtn.selected = YES;
        }
        
        [cell setSelectSexBlock:^(NSInteger tag ) {
            if (tag ==0) {
                if (tag ==0 ) {
                    _personSex = @"M";
                }else{
                    
                    _personSex = @"F";
                }
            }
        }];
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
