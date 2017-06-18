//
//  Symptom   Symptom SelfCheckView.m
//  HospitalBible
//
//  Created by me on 17/5/14.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "SelfCheckView.h"
#import "UIButton+ImageTitleSpacing.h"
#import "UIButton+WebCache.h"
@implementation SelfCheckView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initialization];
}
-(void)initialization{
    
    
    CGFloat width = 100;
    CGFloat height = 130;
    
    //1.最上面图标按钮
    _button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _button.frame = CGRectMake(0, 0, width, height-30);
    [_button setTitleColor:[UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
    
    [_button sd_setImageWithURL:[NSURL URLWithString:self.imgurl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"feibu_icon"]];
    _button.titleLabel.font = [UIFont systemFontOfSize:15];
    [_button setTitle:self.BtnTitle forState:UIControlStateNormal];
    [_button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
                                     imageTitleSpace:10];
    
    //2.下面自检和历史记录按钮
    UIButton *selfCheckButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    selfCheckButton.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
    selfCheckButton.frame = CGRectMake(0, height-30, 40, 30);
    selfCheckButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [selfCheckButton setTitleColor:[UIColor colorWithHexString:@"179590"] forState:(UIControlStateNormal)];
    [selfCheckButton setTitle:@"自检" forState:UIControlStateNormal];
    
    UIButton *historyButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [historyButton setTitleColor:[UIColor colorWithHexString:@"179590"] forState:(UIControlStateNormal)];
    historyButton.frame = CGRectMake(40, height-30, width-40, 30);
    historyButton.titleLabel.font = [UIFont systemFontOfSize:12];
    historyButton.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
    [historyButton setTitle:@"历史记录" forState:UIControlStateNormal];
    
    //3.分割线
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(40, height-25, 1, 20);
    view.backgroundColor = [UIColor colorWithHexString:@"179590"];
    
    [self addSubview:_button];
    [self addSubview:selfCheckButton];
    [self addSubview:historyButton];
    [self addSubview:view];
    
    self.layer.borderColor = [UIColor colorWithHexString:@"F9F9F9"].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

-(void)refrestTheUI{

//    [_button setTitle:self.BtnTitle forState:UIControlStateNormal];
//    [_button sd_setImageWithURL:[NSURL URLWithString:self.imgurl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"cat.png"]];

}

@end
