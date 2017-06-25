//
//  TabbarViewController.m
//  新闻
//
//  Created by gyh on 15/9/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "TabbarViewController.h"
#import "MircoClassViewController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
#import "NavigationController.h"
#import "MircoClassBaseViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initControl];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)initControl
{
    HomeViewController  *new = [[HomeViewController alloc]init];
    [self setupChildViewController:new title:@"首页" imageName:@"index_home_icon" selectedImage:@"index_home_icon"];

    
//    热点知识  女性健康 医药介绍
    NSArray *titleArray = [NSArray arrayWithObjects:@"热点知识",@"女性健康",@"医药介绍", nil];
    NSArray *classArray = [NSArray arrayWithObjects:    [MircoClassBaseViewController class],
                           [MircoClassBaseViewController class],
                           [MircoClassBaseViewController class],
//                           [MircoClassBaseViewController class],
//                           [MircoClassBaseViewController class],
                           nil];
    MircoClassViewController *photo = [[MircoClassViewController alloc] initWithViewControllerClasses:classArray
                                                                                       andTheirTitles:titleArray];
    [self setupChildViewController:photo title:@"微课堂" imageName:@"index_class_icon" selectedImage:@"index_class_icon"];
    
    MineViewController *video = [[MineViewController alloc]init];
    [self setupChildViewController:video title:@"我的" imageName:@"index_me_icon" selectedImage:@"index_me_icon"];
}


-(void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImage
{
    
    //设置控制器属性
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"00A49F"]} forState:(UIControlStateSelected)];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"929292"]} forState:(UIControlStateNormal)];
    
    
    
    //包装一个导航控制器
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:childVc];
    nav.navigationBar.barTintColor = [UIColor colorWithHexString:@"0FA49E"];
    nav.navigationBar.tintColor = [UIColor colorWithHexString:@"FFFFFF"];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self addChildViewController:nav];
}

@end
