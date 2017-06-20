//
//  HistoryDetailSectionHeaderView.m
//  HB
//
//  Created by LIFEI on 2017/5/24.
//  Copyright © 2017年 break. All rights reserved.
//

#import "HistoryDetailSectionHeaderView.h"
@interface HistoryDetailSectionHeaderView()
@property(nonatomic,strong) UILabel *indexLabel;
@property(nonatomic,strong) UILabel *titleLabel;
@end
@implementation HistoryDetailSectionHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    UILabel *indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, SCREEN_WIDTH - 40, 20)];
    indexLabel.textColor = [UIColor colorWithHexString:@"D34759"];
    indexLabel.backgroundColor = [UIColor clearColor];
    indexLabel.font = [UIFont systemFontOfSize:14];
    indexLabel.numberOfLines = 0;
    [self addSubview:indexLabel];
    self.indexLabel = indexLabel;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, SCREEN_WIDTH - 40, 20)];
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor colorWithHexString:@"001627"];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
}
-(void)setIndexText:(NSString*)indexText titleText:(NSString*)titleText{
    CGFloat indexTextCaltH = [self calculateRowHeight:indexText fontSize:14 textWidth:SCREEN_WIDTH-40];
    CGFloat titleTextCaltH = [self calculateRowHeight:titleText fontSize:12 textWidth:SCREEN_WIDTH-40];
    if(indexTextCaltH > 20){
        self.indexLabel.frame = CGRectMake(20, 15, SCREEN_WIDTH - 40, indexTextCaltH);
    }else{
        self.indexLabel.frame = CGRectMake(20, 15, SCREEN_WIDTH - 40, 20);
    }
    
    if(titleTextCaltH > 20){
        self.titleLabel.frame = CGRectMake(20, CGRectGetMaxY(self.indexLabel.frame)+10, SCREEN_WIDTH - 40, titleTextCaltH);
    }else{
        self.titleLabel.frame = CGRectMake(20, CGRectGetMaxY(self.indexLabel.frame)+10, SCREEN_WIDTH - 40, 20);
    }
    self.titleLabel.text = titleText;
    self.indexLabel.text = indexText;
}

-(CGFloat)calculateRowHeight:(NSString*)string fontSize:(CGFloat)fontSize textWidth:(CGFloat)textWidth{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(textWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}

@end
