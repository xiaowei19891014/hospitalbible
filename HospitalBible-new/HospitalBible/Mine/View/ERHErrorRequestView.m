//
//  ERHErrorRequestView.m
//  EIntegrate
//
//  Created by 边瑞康 on 2017/3/14.
//  Copyright © 2017年 CGL. All rights reserved.
//

#import "ERHErrorRequestView.h"

@interface ImageView : UIView

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image;
@end

@implementation ImageView

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image
{
    if (self = [super init]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        UIImage *image1;
        
        imageView.image = image == nil ? image1 : image;
        imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:imageView];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageView)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:-60]];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.textColor = UIColorHex(#999999);
        label.text = title.length != 0 ? title : @"加载失败，轻触屏幕重新加载";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        [self addSubview:label];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[label]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView]-19-[label]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageView, label)]];
    }
    return self;
}

@end

UIViewController *__oldVC ;
ImageView *__oldImageView ;

@implementation ERHErrorRequestView

+ (UIView *_Nullable)addErrorView:(UIViewController *_Nullable)selfVC title:(NSString *_Nullable)title image:(UIImage *_Nullable)image frame:(CGRect)frame touch:(void(^_Nullable)())touchBlock;
{
    ImageView *view = [[ImageView alloc] initWithTitle:title image:image];
    view.backgroundColor = [UIColor whiteColor];
    view.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
//        [view removeFromSuperview];
//        touchBlock();
//    }];
    
//    [view addGestureRecognizer:tap];
    __oldVC = selfVC;
    __oldImageView = view;
    if ([selfVC isKindOfClass:[UITableViewController class]]) {
        UITableViewController *tvc = (id)selfVC;
        view.translatesAutoresizingMaskIntoConstraints = YES;
        [tvc.tableView addSubview:view];
        view.frame = CGRectMake(0, tvc.tableView.contentOffset.y, SCREEN_WIDTH, SCREEN_HEIGHT);
        tvc.tableView.scrollEnabled = NO;
    }
    else if ([selfVC isKindOfClass:[UIViewController class]]) {
        [selfVC.view addSubview:view];

        if (!(frame.size.height==0)) {
            view.frame =frame;
        }else{
         view.frame = CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT);
        }
        
    }
    
    return view;
}
@end
