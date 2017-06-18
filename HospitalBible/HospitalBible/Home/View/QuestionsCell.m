//
//  QuestionsCell.m
//  HospitalBible
//
//  Created by me on 17/5/14.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "QuestionsCell.h"
@interface QuestionsCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation QuestionsCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.borderColor = [UIColor colorWithHexString:@"FAFAFA"].CGColor;
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
}

- (IBAction)btnAction:(id)sender {
    if (self.clickAction) {
        self.clickAction();
    }
}


-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
}

-(void)creatTheUIWithDate:(NSArray*)arr{
    if (arr.count == 0) {  return; }
    
    NSDictionary *dic1 = arr[0];
    _questionOne.BtnTitle = dic1[@"pdescribe"];
    _questionOne.imgurl = dic1[@"imgurl"];
    [_questionOne refrestTheUI];
    
    NSDictionary *dic2 = arr[1];
    _questionTwo.BtnTitle = dic2[@"pdescribe"];
    _questionTwo.imgurl = dic2[@"imgurl"];
    [_questionTwo refrestTheUI];

    NSDictionary *dic3 = arr[2];
    _questionThree.BtnTitle = dic3[@"pdescribe"];
    _questionThree.imgurl = dic3[@"imgurl"];
    [_questionThree refrestTheUI];

}

@end
