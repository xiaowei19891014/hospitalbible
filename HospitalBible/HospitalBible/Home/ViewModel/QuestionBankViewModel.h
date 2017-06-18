//
//  QuestionBankViewModel.h
//  HB
//
//  Created by LIFEI on 2017/5/15.
//  Copyright © 2017年 break. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface QuestionBankViewModel : NSObject

+(CGFloat)calculateAnswersRowHeightWithText:(NSString*)string fontSize:(CGFloat)fontSize textWidth:(CGFloat)textWidth;
@end
