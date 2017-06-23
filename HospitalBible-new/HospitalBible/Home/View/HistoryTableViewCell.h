//
//  HistoryTableViewCell.h
//  HospitalBible
//
//  Created by Walker on 2017/6/23.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (nonatomic) NSInteger indexNumber;

@property (nonatomic,strong)NSDictionary *dict;

@end
