//
//  SubmitTaskView.h
//  HB
//
//  Created by LIFEI on 2017/5/17.
//  Copyright © 2017年 break. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitTaskView : UITableViewCell
+(SubmitTaskView*)loadFromXibView;
-(void)updateUIWithTaskTotalCount:(NSInteger)totalCount completeTaskCount:(NSInteger)completeCount correctCount:(NSInteger)correctCount;
@end
