//
//  MircoClassDetailViewController.h
//  HospitalBible
//
//  Created by me on 17/5/20.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@class MircoClassListModel;

@interface MircoClassDetailViewController : BaseViewController

@property (nonatomic , strong) MircoClassListModel *model;

@property (nonatomic, weak) IBOutlet UIWebView *mWebView;
@property (weak, nonatomic) IBOutlet UIImageView *collectImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;

@end
