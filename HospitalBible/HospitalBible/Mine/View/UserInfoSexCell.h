//
//  UserInfoSexCell.h
//  HospitalBible
//
//  Created by 边瑞康 on 2017/5/24.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoSexCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *manBtn;

@property (weak, nonatomic) IBOutlet UIButton *womanBtn;

@property (weak, nonatomic) IBOutlet UIButton *otherBtn;


- (IBAction)selectAction:(UIButton *)sender;

@property(copy,nonatomic) void ( ^selectSexBlock)(NSInteger tag);


@end
