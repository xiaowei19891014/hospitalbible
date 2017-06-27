//
//  MyCollectionViewController.m
//  HospitalBible
//
//  Created by 边瑞康 on 2017/5/24.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "ERHErrorRequestView.h"
#import "QuestionsCollectionViewController.h"
#import "MircroClassCollectionViewController.h"
#import "QuestionBankViewController.h"

@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController
- (instancetype)init {
    if (self = [super init]) {
        self.titleSizeSelected = 14.0f;
        self.titleSizeNormal = 14.0f;
        self.titleColorNormal = [UIColor colorWithHexString:@"9B9B9B"];
        self.titleColorSelected = [UIColor colorWithHexString:@"00A49F"];
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuHeight = 44;
        self.menuItemWidth = SCREEN_WIDTH/2.0;
        self.titles = @[
                        @"题库",
                        @"微课堂"
                        ];
        self.menuBGColor = [UIColor whiteColor];
        self.otherGestureRecognizerSimultaneously = YES;
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.progressHeight = 3;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
}

#pragma mark - WMPageControllerDataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    if (index == 0) {
        QuestionBankViewController *vc = [[QuestionBankViewController alloc] init];
        vc.isCateGory = YES;
        vc.isStore = YES;
        return vc;
    }
    return [[MircroClassCollectionViewController alloc] init];
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titles[index];
}

@end
