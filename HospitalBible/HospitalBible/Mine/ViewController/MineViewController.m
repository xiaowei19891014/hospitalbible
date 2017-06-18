//
//  MineViewController.m
//  HospitalBible
//
//  Created by me on 17/5/14.
//  Copyright © 2017年 com.hao. All rights reserved.
//1111111111

#import "MineViewController.h"
#import "TitleImageModel.h"
#import "UserLoginViewController.h"
#import "UserInfoViewController.h"
#import "MyCollectionViewController.h"
#import "AppointmentRemindTipsViewController.h"
#import "SickCallViewController.h"
#import "AddSickViewController.h"
#import "ERHNetWorkTool.h"
#import "UserInfoShareClass.h"
#import "UserInfoViewModel.h"
#import "AboutAppViewController.h"
#import "AppDelegate.h"
@interface TradeSuccessHeadView : UIView
@property (nonatomic,strong)UILabel *tipsLabel;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic, copy) void (^userLognBlock)();
@end

@implementation TradeSuccessHeadView
- (instancetype)initWithFrame:(CGRect)frame;
{
    if (self = [super initWithFrame:frame]) {
        [self initializeUI];
    }
    return self;
}
-(void)initializeUI
{
    self.backgroundColor = [UIColor grayColor];
    //my_home_bj
    UIImageView *backgroundeImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    backgroundeImage.image = [UIImage imageNamed:@"my_home_bj"];
    [self addSubview:backgroundeImage];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image =[UIImage imageNamed:@"skin_1_img_default_avatar"];
    [self addSubview:imageView];
    
    _tipsLabel = [[UILabel alloc]init];
    _tipsLabel.text = @"李飞";
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_tipsLabel];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    [self addSubview:lineLabel];
    
    _btn =[[UIButton alloc]init];
    [_btn setTitle:@"退出登录" forState:UIControlStateNormal];
    _btn.layer.cornerRadius = 18;
    _btn.layer.masksToBounds = YES;
    _btn.layer.borderWidth = 1;
    _btn.layer.borderColor = [UIColor whiteColor].CGColor;
    [_btn addTarget:self action:@selector(outLonging) forControlEvents:UIControlEventTouchUpInside];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btn.hidden = YES;
    [self addSubview:_btn];
    
    _btn.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    _tipsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    lineLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(imageView, _tipsLabel, lineLabel,_btn);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[lineLabel]-0-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lineLabel(0.5)]-0-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-33-[imageView]-20-[_tipsLabel(16)]-10-[_btn(36)]" options:0 metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_btn(115)]" options:0 metrics:nil views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_btn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_tipsLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    
    
}
-(void)outLonging
{
    if(_userLognBlock)
    {
        _userLognBlock();
    }
}
@end



@interface MineViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataSources;
@end

@implementation MineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataSources = getUserCenterTitleAndImageList();
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logn) name:USERLOGING object:nil];
    [self initTableView];
}
-(void)logn
{
    TradeSuccessHeadView*head =(TradeSuccessHeadView *)_tableview.tableHeaderView;
    head.tipsLabel.text = [UserInfoShareClass sharedManager].userId;
    [head.btn setTitle:@"退出登录" forState:UIControlStateNormal];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [_tableview reloadData];
}
- (void)initTableView
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64-50) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
     TradeSuccessHeadView *headView =[[TradeSuccessHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    headView.userLognBlock = ^{
        if (![UserInfoShareClass sharedManager].userId)
        {
            UserLoginViewController *vc = [[UserLoginViewController alloc] init];
            UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nvc animated:YES completion:^{
                
            }];
        }else
        {
            [self showLoadingHUD];
            [UserInfoViewModel userLogOutWithUserName:[UserInfoShareClass sharedManager].userId successHandler:^(id result) {
                [self hideLoadingHUD];
                [UserInfoShareClass sharedManager].userId = nil;
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                UserLoginViewController *uvc = [[UserLoginViewController alloc]init];
                
                [uvc setLoginSuccessBlock:^{
                    [AppDelegate currentDelegate].window.rootViewController = [AppDelegate currentDelegate].tabbarMain;
                    [AppDelegate currentDelegate].tabbarMain.selectedIndex = 0;

                }];
                [AppDelegate currentDelegate].window.rootViewController = uvc;
            } errorHandler:^(NSError *error) {
                [self hideLoadingHUD];
            }];
        }
        
    };
    if(![UserInfoShareClass sharedManager].userId)
    {
        headView.tipsLabel.text = @"";
        [headView.btn setTitle:@"登录" forState:UIControlStateNormal];
    }else{
        
    headView.tipsLabel.text = [UserInfoShareClass sharedManager].userId;
    }
    tableview.tableHeaderView = headView;
    [self.view addSubview:tableview];
    
    self.tableview = tableview;
    self.tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero]; 
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataSources.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *ID = @"setting1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    if (indexPath.section == 0) {
        
        TitleImageModel *model = self.dataSources[indexPath.row];
        cell.textLabel.text = model.title;
        cell.imageView.image = [UIImage imageNamed:model.imageName];
        if (indexPath.row == 8 || indexPath.row == 10) { //不展示点头
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }else{
        
        cell.textLabel.text = @"退出登录";
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (![UserInfoShareClass sharedManager].userId) {
        UserLoginViewController *vc = [[UserLoginViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }
   
    if (indexPath.section == 1) {
        [self showLoadingHUD];
        [UserInfoViewModel userLogOutWithUserName:[UserInfoShareClass sharedManager].userId successHandler:^(id result) {
            [self hideLoadingHUD];
            [UserInfoShareClass sharedManager].userId = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            UserLoginViewController *uvc = [[UserLoginViewController alloc]init];
            
            [uvc setLoginSuccessBlock:^{
                [AppDelegate currentDelegate].window.rootViewController = [AppDelegate currentDelegate].tabbarMain;
                [AppDelegate currentDelegate].tabbarMain.selectedIndex = 0;
                
            }];
            [AppDelegate currentDelegate].window.rootViewController = uvc;
        } errorHandler:^(NSError *error) {
            [self hideLoadingHUD];
        }];

    }else{
            if (indexPath.row==2)//我的信息
            {
                UserInfoViewController *vc= [[UserInfoViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }else if (indexPath.row == 1)//我的收藏
            {
                MyCollectionViewController*vc= [[MyCollectionViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
                return;

            }else if (indexPath.row ==0)//预约
            {
                AppointmentRemindTipsViewController*vc= [[AppointmentRemindTipsViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
                return;

                
            }else if (indexPath.row == 4)//就诊患者管理
            {
                SickCallViewController*vc= [[SickCallViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
                return;

            }else if (indexPath.row == 3)//就诊卡绑定
            {
                AddSickViewController* vc= [[AddSickViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }else if (indexPath.row == 5)//就诊卡绑定
            {
                AboutAppViewController* vc= [[AboutAppViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }else if(indexPath.row == 6){
                
               NSString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"10010"];
                // NSLog(@"str======%@",str);
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10;
}

- (NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}


@end
