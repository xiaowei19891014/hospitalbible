//
//  ERHLogin.h
//  EIntegrate
//
//  Created by xa on 16/11/23.
//  Copyright © 2016年 bocop. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "CONSTS.h"

@interface ERHLogin : NSObject
//登陆信息写成一个单例 保证全局通用
+ (ERHLogin *)sharedManager;
@end
