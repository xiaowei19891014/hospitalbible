//
//  MircoClassViewController.m
//  HospitalBible
//
//  Created by me on 17/5/13.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "MircoClassViewController.h"
#import "MircoClassBaseViewController.h"
@interface MircoClassViewController ()

@property (nonatomic, strong) NSMutableArray *viewControlleArray;

@end

@implementation MircoClassViewController
- (id)initWithViewControllerClasses:(NSArray<Class> *)classes andTheirTitles:(NSArray<NSString *> *)titles{
    if (self = [super initWithViewControllerClasses:classes andTheirTitles:titles]) {
        self.titleSizeSelected = 14.0f;
        self.titleSizeNormal = 14.0f;
        self.titleColorNormal = [UIColor colorWithHexString:@"9B9B9B"];
        self.titleColorSelected = [UIColor colorWithHexString:@"00A49F"];
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuHeight = 44;
        self.menuItemWidth = 75;
        self.menuBGColor = [UIColor whiteColor];
        self.otherGestureRecognizerSimultaneously = YES;
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.progressHeight = 3;
        
        _viewControlleArray = [NSMutableArray array];
        int i = 0;
        while (i <titles.count) {
            MircoClassBaseViewController *mVC = [[MircoClassBaseViewController alloc] init];
            [mVC setDisclsidStr:[NSString stringWithFormat:@"%zd",i+1]];
            [_viewControlleArray addObject:mVC];
            i++;
        }

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectIndex = 0;
}

#pragma mark - WMPageControllerDataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    return _viewControlleArray[index];
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titles[index];
}

@end
