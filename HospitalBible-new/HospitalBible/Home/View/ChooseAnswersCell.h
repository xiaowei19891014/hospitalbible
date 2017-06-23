//
//  ChooseAnswersCell.h
//  HB
//
//  Created by LIFEI on 2017/5/15.
//  Copyright © 2017年 break. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseAnswersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) NSInteger index;

@property (nonatomic,strong)NSDictionary *dict;


@end
