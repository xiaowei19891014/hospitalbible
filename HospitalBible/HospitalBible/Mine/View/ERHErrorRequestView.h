//
//  ERHErrorRequestView.h
//  EIntegrate
//
//  Created by 边瑞康 on 2017/3/14.
//  Copyright © 2017年 CGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERHErrorRequestView : NSObject
+ (UIView *_Nullable)addErrorView:(UIViewController *_Nullable)selfVC title:(NSString *_Nullable)title image:(UIImage *_Nullable)image frame:(CGRect)frame touch:(void(^_Nullable)())touchBlock;
@end
