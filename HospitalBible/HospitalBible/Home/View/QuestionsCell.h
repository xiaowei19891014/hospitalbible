//
//  QuestionsCell.h
//  HospitalBible
//
//  Created by me on 17/5/14.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelfCheckView.h"
@interface QuestionsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *clickCheckAllButton;
@property (weak, nonatomic) IBOutlet SelfCheckView *questionOne;
@property (weak, nonatomic) IBOutlet SelfCheckView *questionTwo;
@property (weak, nonatomic) IBOutlet SelfCheckView *questionThree;
@property (nonatomic,copy) void (^clickAction)();

-(void)creatTheUIWithDate:(NSArray*)arr;
@end
