//
//  QRScanViewController.h
//  EIntegrate
//
//  Created by 张东伟 on 16/12/6.
//  Copyright © 2016年 ZDW. All rights reserved.
//

#import "BaseViewController.h"
@interface QRScanViewController : BaseViewController
@property (nonatomic,copy) void(^scanResult)(NSString *result);
@end
