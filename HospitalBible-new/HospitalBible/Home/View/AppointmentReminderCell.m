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

- (void)setModel:(appointmentModel *)model
{
    _model = model;
//    appointdate : 2017-07-07 23:16:15;
//    #define DATEFORMAT24        @"yyyy-MM-dd HH:mm:ss"
    NSString *str = [[[DateFormat share] convertString:model.appointdate fromType:DATEFORMAT24 toType:DATEFORMAT2] substringFromIndex:5];
    self.appointLabel.text = [NSString stringWithFormat:@"您%@有预约,请点击查看",str];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
}
@end
