//
//  CommonAlertView.m
//  EIntegrate
//
//  Created by xiaowei on 2017/4/25.
//  Copyright © 2017年 CGL. All rights reserved.
//

#import "CommonAlertView.h"
#import "UIView+Action.h"
@implementation CommonAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if ( (self = [super initWithFrame:frame]) ) {
        
        [self awakeFromNib];
        
    }
    return self;
}

-(instancetype)init{

    if (self = [super init]) {
        [super awakeFromNib];

        self.frame = CGRectMake(15, SCREEN_HEIGHT-346,SCREEN_WIDTH -30 , 346);
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.frame = CGRectMake(15, SCREEN_HEIGHT,SCREEN_WIDTH -30 , 346);

    self.contentView.layer.cornerRadius = 8;
    self.contentView.layer.masksToBounds =YES;

    self.cancelBtn.layer.cornerRadius = 8;
    self.contentView.layer.masksToBounds =YES;
}
- (IBAction)btnAction:(UIButton *)sender {
    
    if (sender.tag  ==1) {
        self.clickBlock();
    }
    
    [self hiddenView];
}

-(void)showAlertView{
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    _backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0.6f;
    [window addSubview:_backView];
    [window addSubview:self];
    [window bringSubviewToFront:self];

    __weak typeof(self) weakself = self;
    [_backView setViewActionWithBlock:^{
        [weakself hiddenView];
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(15, SCREEN_HEIGHT-346,SCREEN_WIDTH -30 , 346);
    } completion:^(BOOL finished) {
        
    }];

}

-(void)hiddenView{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(15, SCREEN_HEIGHT,SCREEN_WIDTH -30 , 346);

    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_backView removeFromSuperview];

    }];

}


@end
