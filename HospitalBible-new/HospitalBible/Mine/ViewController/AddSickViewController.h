//
//  AddSickViewController.h
//  HospitalBible
//
//  Created by 边瑞康 on 2017/5/25.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "BaseViewController.h"
#import "UserInfoModel.h"

@interface AddSickViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *footview;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
- (IBAction)saveAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@property(copy,nonatomic) void(^addSuccessBlock) (void);

@property (strong, nonatomic)  UserInfoModel *model;
@property (nonatomic)BOOL canEdit;


@end
