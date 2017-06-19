//
//  AppointmentRemindTipsViewController.h
//  HospitalBible
//
//  Created by 边瑞康 on 2017/5/15.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentRemindTipsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *startLable;
@property (weak, nonatomic) IBOutlet UILabel *endLable;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UIView *startView;
@property (weak, nonatomic) IBOutlet UIView *endView;
@property (strong, nonatomic) IBOutlet UIView *headView;

@end
