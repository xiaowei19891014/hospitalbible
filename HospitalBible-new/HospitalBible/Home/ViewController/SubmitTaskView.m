//
//  SubmitTaskView.m
//  HB
//
//  Created by LIFEI on 2017/5/17.
//  Copyright © 2017年 break. All rights reserved.
//

#import "SubmitTaskView.h"
@interface SubmitTaskView()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *correctCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *wrongCountLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView1;
@property (weak, nonatomic) IBOutlet UIView *bgView2;
@end
@implementation SubmitTaskView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView1.layer.cornerRadius = 10;
    self.bgView1.layer.masksToBounds = YES;
    self.bgView2.layer.cornerRadius = 10;
    self.bgView2.layer.masksToBounds = YES;
}

+(SubmitTaskView*)loadFromXibView{
    return [[NSBundle mainBundle] loadNibNamed:@"SubmitTaskView" owner:nil options:nil].firstObject;
}
-(void)updateUIWithTaskTotalCount:(NSInteger)totalCount completeTaskCount:(NSInteger)completeCount correctCount:(NSInteger)correctCount{
    _scoreLabel.text = [NSString stringWithFormat:@"%ld/%ld",completeCount,totalCount];
    _correctCountLabel.text = [NSString stringWithFormat:@"%ld",correctCount];
    _wrongCountLabel.text = [NSString stringWithFormat:@"%ld",completeCount-correctCount];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
