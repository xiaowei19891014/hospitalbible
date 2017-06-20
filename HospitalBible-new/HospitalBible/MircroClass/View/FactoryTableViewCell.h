//
//  FactoryTableViewCell.h
//  HospitalBible
//
//  Created by me on 17/5/14.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTableViewCell.h"
@interface FactoryTableViewCell : NSObject

/**
 根据resusedID不同,返回继承于基类的cell

 @param reusedID  重用ID
 @param tableView tableView
 @param indexPath 索引

 @return <#return value description#>
 */
+ (BaseTableViewCell *)createCellWith:(NSString *)reusedID
                            tableView:(UITableView *)tableView
                            indexPath:(NSIndexPath *)indexPath;
@end
