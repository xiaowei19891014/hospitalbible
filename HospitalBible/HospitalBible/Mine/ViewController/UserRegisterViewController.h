//
//  UserRegisterViewController.h
//  HospitalBible
//
//  Created by 边瑞康 on 2017/6/4.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface UserRegisterViewController : BaseViewController

@property (nonatomic,assign) RegistType registType;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;



@end
