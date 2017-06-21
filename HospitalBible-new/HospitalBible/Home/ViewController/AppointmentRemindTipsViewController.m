//
//  AppointmentRemindTipsViewController.m
//  HospitalBible
//
//  Created by 边瑞康 on 2017/5/15.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "AppointmentRemindTipsViewController.h"
#import "AppointmentRemindTipsTableViewCell.h"
#import "RemindDetailViewController.h"
#import "HomeViewModel.h"
#import "UserInfoModel.h"
#import "UIView+Action.h"
#import "LGAlertViewExtension.h"
#import "DateFormat.h"

@interface AppointmentRemindTipsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataSources;
@end

@implementation AppointmentRemindTipsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"预约提醒";
    // Do any additional setup after loading the view.
    [self initTableView];
    [HomeViewModel requestPatientListWithUserId:@"1" successHandler:^(id result) {
        self.dataSources = result;
        [self.tableview reloadData];
    } errorHandler:^(NSError *error) {
        
    }];
    
    [self creatSelectView];
}


-(void)creatSelectView{

    [self.startView setViewActionWithBlock:^{
        
        NSDate *date = [NSDate date];
        NSDateFormatter *formatters = [[NSDateFormatter alloc] init];
        [formatters setDateFormat:@"yyyy-MM-dd"];
        NSString *nowDate= [formatters stringFromDate:date];
        
        [LGAlertViewExtension showDateSelectInViewController:self indexDate:nowDate andMax:date andMin:nil type:kDatePickerTypeFull clickOk:^(NSString *selectDateStr){
            NSLog(@"%@",selectDateStr);
            self.startLable.text = selectDateStr;
        }];        
        
    }];
    [self.endView setViewActionWithBlock:^{
        NSDate *date = [NSDate date];
        NSDateFormatter *formatters = [[NSDateFormatter alloc] init];
        [formatters setDateFormat:@"yyyy-MM-dd"];
        NSString *nowDate= [formatters stringFromDate:date];
        
        [LGAlertViewExtension showDateSelectInViewController:self indexDate:nowDate andMax:date andMin:nil type:kDatePickerTypeFull clickOk:^(NSString *selectDateStr){
            NSLog(@"%@",selectDateStr);
            self.endLable.text = selectDateStr;


        }];
  
        
    }];
    
    [self.selectImageView setViewActionWithBlock:^{
        
        if ([_startLable.text hasPrefix:@"请选择"]) {
            [self showErrorMessage:@"请选择起始日期"];
            return ;
        }
        if ([_endLable.text hasPrefix:@"请选择"]) {
            [self showErrorMessage:@"请选择结束日期"];
            return;
        }
        
        NSDictionary *params = @{
                                 @"userId": NOTNIL([UserInfoShareClass sharedManager].userId),
                                 @"startDate": [[DateFormat share]convertString:_startLable.text fromType:DATEFORMAT28 toType:DATEFORMAT24],

                                 @"endDate": [[DateFormat share]convertString:_endLable.text fromType:DATEFORMAT28 toType:DATEFORMAT24],

                                 };
        [[ERHNetWorkTool sharedManager] requestDataWithUrl:APPOPINTMENT_SEARCH params:params success:^(NSDictionary *responseObject) {

        } failure:^(NSError *error) {
            
        }];

        
    }];

}


- (void)initTableView
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview registerNib:[UINib nibWithNibName:@"AppointmentRemindTipsTableViewCell" bundle:nil] forCellReuseIdentifier:@"AppointmentRemindTipsTableViewCell"];
    [self.view addSubview:tableview];
    tableview.rowHeight = 100;
    self.tableview = tableview;
    
    self.tableview.tableHeaderView = self.headView;
    self.tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSources.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInfoModel *model = self.dataSources[indexPath.row];
    AppointmentRemindTipsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppointmentRemindTipsTableViewCell"];
    cell.nameLabel.text = model.pname;
    cell.dateLabel.text = model.birthDay;
    cell.hospitalLabel.text = model.pname;
    cell.addressLabel.text = model.sex;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    RemindDetailViewController *vc = [[RemindDetailViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
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
