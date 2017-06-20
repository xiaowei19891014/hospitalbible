//
//  AppointmentReminderCell.m
//  HospitalBible
//
//  Created by me on 17/5/14.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "AppointmentReminderCell.h"
@interface AppointmentReminderCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *appointLabel;
@end

@implementation AppointmentReminderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.borderColor = [UIColor colorWithHexString:@"00A49F"].CGColor;
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.masksToBounds = YES;
    
    self.appointLabel.layer.cornerRadius = 8;
    self.appointLabel.layer.masksToBounds = YES;
    self.appointLabel.layer.borderColor = [UIColor colorWithHexString:@"00A49F"].CGColor;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
}
@end
