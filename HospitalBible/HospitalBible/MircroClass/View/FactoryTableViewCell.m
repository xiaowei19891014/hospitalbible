//
//  FactoryTableViewCell.m
//  HospitalBible
//
//  Created by me on 17/5/14.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "FactoryTableViewCell.h"

@implementation FactoryTableViewCell
+ (BaseTableViewCell *)createCellWith:(NSString *)reusedID
                            tableView:(UITableView *)tableView
                            indexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:reusedID forIndexPath:indexPath];
}
@end
