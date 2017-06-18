//
//  AddSickTableViewCell.h
//  HospitalBible
//
//  Created by 边瑞康 on 2017/5/25.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddSickModel.h"
@interface AddSickTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (nonatomic,strong) AddSickModel *model;
@end
