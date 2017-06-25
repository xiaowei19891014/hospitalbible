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
#import "UIImage+Extension.h"
#import "UIImageView+WebCache.h"

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
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height-30)];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,60,45)];
    self.imageView.image = [UIImage imageNamed:@"feibu_icon"];
    self.imageView.center = CGPointMake(width/2.0, 35);
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0,65, width, 30)];
    _label.textColor = [UIColor colorWithHexString:@"000000"];
    _label.text = @"支气管哮喘";
//    _label.adjustsFontSizeToFitWidth = YES;
    _label.textAlignment =NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:14];
    
    [topView addSubview:_label];
    [topView addSubview:self.imageView];
    
    //2.下面自检和历史记录按钮
    UIButton *selfCheckButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    selfCheckButton.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
    selfCheckButton.frame = CGRectMake(0, height-30, 40, 30);
    selfCheckButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [selfCheckButton setTitleColor:[UIColor colorWithHexString:@"179590"] forState:(UIControlStateNormal)];
    [selfCheckButton setTitle:@"自检" forState:UIControlStateNormal];
    [selfCheckButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *historyButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [historyButton setTitleColor:[UIColor colorWithHexString:@"179590"] forState:(UIControlStateNormal)];
    historyButton.frame = CGRectMake(40, height-30, width-40, 30);
    historyButton.titleLabel.font = [UIFont systemFontOfSize:11];
    historyButton.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
    [historyButton setTitle:@"历史记录" forState:UIControlStateNormal];
    [historyButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //3.分割线
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(40, height-25, 1, 20);
    view.backgroundColor = [UIColor colorWithHexString:@"179590"];
    
    [self addSubview:topView];
    [self addSubview:selfCheckButton];
    [self addSubview:historyButton];
    [self addSubview:view];
    
    self.layer.borderColor = [UIColor colorWithHexString:@"F9F9F9"].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

- (void)tapAction:(UIButton *)btn
{
    if ([btn.currentTitle isEqualToString:@"自检"]) {
        if (self.clicked) {
            self.clicked(YES,self.index);
        }
    }else{
        if (self.clicked) {
            self.clicked(NO,self.index);
        }
    }
}

-(void)refrestTheUI
{
    self.label.text = self.BtnTitle;
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imgurl] placeholderImage:[UIImage imageNamed:@"feibu_icon"]];
}



@end
