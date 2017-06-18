//
//  ChooseAnswersCell.h
//  HB
//
//  Created by LIFEI on 2017/5/15.
//  Copyright © 2017年 break. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseAnswersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *optionLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectResultButton;
-(void)setChooseAnswerUpperCaseWithIndex:(NSInteger)index;
@end
