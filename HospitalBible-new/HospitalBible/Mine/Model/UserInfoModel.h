//
//  UserInfoModel.h
//  HospitalBible
//
//  Created by 边瑞康 on 2017/6/4.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject
@property(nonatomic,strong) NSString *id;
@property(nonatomic,strong) NSString *cellphone;
@property(nonatomic,strong) NSString *imgurl;
@property(nonatomic,strong) NSString *sex;
@property(nonatomic,strong) NSString *weight;
@property(nonatomic,strong) NSString *weChat;
@property(nonatomic,strong) NSString *idcard;
@property(nonatomic,strong) NSString *qQNum;
@property(nonatomic,strong) NSString *address;
@property(nonatomic,strong) NSString *regdate;
@property(nonatomic,strong) NSString *idtype;
@property(nonatomic,strong) NSString *height;
@property(nonatomic,strong) NSString *birthDay;
@property(nonatomic,strong) NSString *accountstatus;
@property(nonatomic,strong) NSString *nickname;
@property(nonatomic,strong) NSString *email;
@property(nonatomic,strong) NSString *patientId;
@property(nonatomic,strong) NSString *phoneNum;
@property(nonatomic,strong) NSString *pdescribe;
@property(nonatomic,strong) NSString *birthday;
@property(nonatomic,strong) NSString *age;
@property(nonatomic,strong) NSString *pCardId;


//患者信息扩充
@property(nonatomic,strong) NSString *pname;
@end
