//
//  HistoryDetailViewModel.h
//  HB
//
//  Created by LIFEI on 2017/5/24.
//  Copyright © 2017年 break. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HistoryDetailViewModel : NSObject
+(CGFloat)calculateSectionViewHeightWithIndexText:(NSString*)indexText andTitleText:(NSString*)titleText;
@end
