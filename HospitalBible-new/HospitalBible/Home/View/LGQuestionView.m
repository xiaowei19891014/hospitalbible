//
//  LGQuestionView.m
//  HospitalBible
//
//  Created by Walker on 2017/6/19.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "LGQuestionView.h"

@interface LGQuestionView()
@property (nonatomic,strong)UILabel *titleLabel;
//@property (nonatomic,strong)UILabel *desLabel;
@property (nonatomic,strong)NSMutableArray *labels;
@end

@implementation LGQuestionView


- (void)setModel:(DiseaseQuestionModel *)model
{
    _model = model;
    _labels = [NSMutableArray arrayWithCapacity:0];
    NSArray *viewArr = self.subviews;
    [viewArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = (UIView *)obj;
        [view removeFromSuperview];
    }];

    [self reconfigUI:model];
}

- (void)reconfigUI:(DiseaseQuestionModel *)model
{
    CGFloat coodY = 10;
    CGFloat leftSpace = 30;
    CGFloat coodX = SCREEN_WIDTH - 2*leftSpace;
    CGFloat space = 5.0;
    
    NSString *titleContent = [NSString stringWithFormat:@"%ld .%@",(long)self.index+1,model.title];
    CGSize titleSize = [titleContent boundingRectWithSize:CGSizeMake(coodX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, coodY, coodX, titleSize.height+space)];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.text = titleContent;
    self.titleLabel.numberOfLines = 0;//多行显示，计算高度
    self.titleLabel.textColor = UIColorFromRGB(0x001627);
    [self addSubview:self.titleLabel];
    
    coodY = coodY + self.titleLabel.height + 10;
    
//    NSString *desContent = @"近来，世界正呈现出新的力量格局变化。中国目前是世界上最大的发展中国家，亚洲第一大国，其先锋是领导人习近平。因地理位置而对朝鲜半岛具有巨大影响力的中国领导人习近平，他追求的是什么，这对朝鲜半岛局势和韩国究竟有什么样的影响";
//    CGSize desSize = [desContent boundingRectWithSize:CGSizeMake(coodX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
//    
//    self.desLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, coodY, coodX, desSize.height+space+5)];
//    self.desLabel.font = [UIFont systemFontOfSize:12];
//    self.desLabel.text = desContent;
//    self.desLabel.numberOfLines = 0;//多行显示，计算高度
//    self.desLabel.textColor = UIColorFromRGB(0x9B9B9B);
//    [self addSubview:self.desLabel];
//
//    coodY = coodY + self.desLabel.height + 5;
    
    NSInteger count = model.choiceList.count;
    for (int i = 0; i<count; i++) {
        UIView *baseView = [[UIView alloc] init];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
        label.text = [NSString stringWithFormat:@"%d",i+1];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.layer.cornerRadius = 10;
        label.backgroundColor = [UIColor lightGrayColor];
        label.clipsToBounds = YES;
        [baseView addSubview:label];

        DiseaseQuestionChoiceModel *tempModel = (DiseaseQuestionChoiceModel *)model.choiceList[i];
        NSString *questionText = tempModel.fContext;
        CGSize queSize = [questionText boundingRectWithSize:CGSizeMake(coodX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;;
        UILabel *questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, coodX-30, queSize.height+1)];
        questionLabel.font = [UIFont systemFontOfSize:12];
        questionLabel.text = questionText;
        questionLabel.numberOfLines = 0;//多行显示，计算高度
        questionLabel.textColor = UIColorFromRGB(0x9B9B9B);
        [baseView addSubview:questionLabel];
        
        baseView.frame = CGRectMake(leftSpace, coodY, coodX, questionLabel.height);
        [self addSubview:baseView];
        coodY = coodY + questionLabel.height+15;
        baseView.tag = i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [baseView addGestureRecognizer:tap];
        
        [_labels addObject:label];
    }
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:UIColorFromRGB(0x00A49F) forState:UIControlStateNormal];
    self.nextBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    self.nextBtn.backgroundColor = [UIColor whiteColor];
    self.nextBtn.layer.cornerRadius = 22;
    self.nextBtn.clipsToBounds = YES;
    self.nextBtn.layer.borderColor = UIColorFromRGB(0x00A49F).CGColor;
    self.nextBtn.layer.borderWidth = 1.0f;
    
    CGFloat heigh = SCREEN_HEIGHT -160;
    if ((coodY + 20 + 44 +15)<=heigh) {
        coodY = SCREEN_HEIGHT - 160  - 44 - 15;
    }else{
        coodY = coodY + 20;
    }
    self.nextBtn.frame = CGRectMake(0, coodY, 135, 44);
    self.nextBtn.center = CGPointMake(SCREEN_WIDTH/2.0, self.nextBtn.center.y);
    coodY = coodY + 44 + 15;
    [self addSubview:self.nextBtn];
    [self.nextBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.contentSize = CGSizeMake(0, coodY);
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    UIView *view = tap.view;
    NSLog(@"tapAction---%ld",view.tag);
    
    [self.labels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *l = (UILabel *)obj;
        l.backgroundColor = [UIColor lightGrayColor];
        if (idx == view.tag) {
            l.backgroundColor = UIColorFromRGB(0x00A49F);
        }
    }];
    
    if (self.tapAction) {
        self.tapAction(self.index,view.tag+1);
    }
}

- (void)clickAction
{
    if (self.nextBtnClickAction) {
        self.nextBtnClickAction(self.index);
    }
}

- (void)setCurrentSelectedIndex:(NSInteger)currentSelectedIndex
{
    _currentSelectedIndex = currentSelectedIndex;
    if (_currentSelectedIndex == 0) {
        return;
    }else{
        UILabel *label = self.labels[currentSelectedIndex-1];
        label.backgroundColor = UIColorFromRGB(0x00A49F);
    }
}

//- (NSString *)getSelectedByIndex:(NSInteger)index
//{
//    NSArray *arr = @[@"A",
//                    @"B",
//                    @"C",
//                    @"D",
//                    @"E",
//                    @"F",
//                    @"G",
//                    @"H",
//                    @"I",
//                    @"J",
//                    @"K",
//                    @"L",
//                    @"M",
//                    @"N"];
//    return arr[index];
//}

@end
