//
//  MircoClassDetailViewController.m
//  HospitalBible
//
//  Created by me on 17/5/20.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "MircoClassDetailViewController.h"
#import "MircoClassListModel.h"
#import "ERHHtmlAnalysisTool.h"
#import "UIView+Action.h"

@interface MircoClassDetailViewController ()

@property(assign,nonatomic) BOOL isConllect;//是否收藏

@end

@implementation MircoClassDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微课堂详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.mWebView loadHTMLString:[[ERHHtmlAnalysisTool shareERHHtmlAnalysisTool] getNewHtmlStringWithOriginalHtmlString:_model.content] baseURL:nil];
    [self checkIfCollectNetWork];
    
//    [self.mWebView loadHTMLString:_model.content baseURL:nil];
    
    self.collectImgView.userInteractionEnabled = YES;
    [self.collectImgView setViewActionWithBlock:^{
        if (_isConllect) {
            [self canceCollectRequest];
        }else{
            [self collectRequest];
        }
    }];
}

- (void)checkIfCollectNetWork {
    [self showLoadingHUD];
    NSDictionary *params = @{
                             @"TableID":NOTNIL( _model.discoverId),
                             @"type": @"0",
                             @"userId":NOTNIL([UserInfoShareClass sharedManager].userId)
                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:DISCOVER_ISEFFECTIVE params:params success:^(id responseObject) {
        
        [self hideLoadingHUD];
        if ([responseObject[@"flag"] isEqualToString:@"false"]) {
            _isConllect = NO;
        }else{
            _isConllect = YES;

        }
        
    } failure:^(NSError *error) {
        [self hideLoadingHUD];
    }];
}


-(void)collectRequest{
    [self showLoadingHUD];
    NSDictionary *params = @{
                             @"TableID":NOTNIL( _model.discoverId),
                             @"userId":NOTNIL([UserInfoShareClass sharedManager].userId),
                             @"type": @"0",

                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:COLLECTION_DISCOVER params:params success:^(id responseObject) {
        
        [self hideLoadingHUD];
    } failure:^(NSError *error) {
        [self hideLoadingHUD];
    }];
    
}

-(void)canceCollectRequest{

    [self showLoadingHUD];
    NSDictionary *params = @{
                             @"TableID":NOTNIL( _model.discoverId),
                             @"userId":NOTNIL([UserInfoShareClass sharedManager].userId),
                             @"type": @"0",

                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:COLLECTION_DELETE params:params success:^(id responseObject) {
        
        [self hideLoadingHUD];
    } failure:^(NSError *error) {
        [self hideLoadingHUD];
    }];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
