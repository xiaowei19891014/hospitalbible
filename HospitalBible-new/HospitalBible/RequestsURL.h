//
//  RequestsURL.h
//  EIntegrate
//
//  Created by Delano on 16/4/20.
//  Copyright © 2016年 bocop. All rights reserved.
//

#ifndef RequestsURL_h
#define RequestsURL_h

//#define kURL    @"http://120.77.215.208:8081"
#define kURL    @"http://192.168.1.102:8080"
/*************PUBLIC MEDIA QUERY*************/
//1.1广告
#define ADVERTISEMENT_LIST [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/advertisement/list"]
//1.2
// /api/chr/diseasequestion/three
#define DISEASEQUEASETION_THREE [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/adthree"]
//1.3题库
// /api/chr/diseasequestion/list
#define DISEASEQUEASETION_LIST [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/diseasequestion/list"]

//题库答案提交
#define DISEASEQUEASETION_SAVE [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/result/save"]

//是否收藏
#define DISEASEQUEASETION_COLLECTION_LIST [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/collection/diseasequestionlist"]

//题库历史记录
#define DISEASEQUEASETION_HISTORY_LIST [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/result/list"]

//我的信息
#define USER_INFO [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/user/user/id"]

//添加反馈
#define FEEDBACK_SAVE  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/feedback/save"]
//查看所有反馈
#define FEEDBACK_LIST  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/feedback/list"]
//版本更新
#define UPDATES_LAST  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/updates/last"]
//登录
#define USER_LOGIN  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/user/login"]


//获取验证码
#define VERIFY_SENDSMS  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/verify/sendsms"]

//验证密码
#define USER_ISEFFECTIVE  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/verify/iseffective"]

//设置密码
#define USER_PASSWORD  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/user/password"]

//重置密码
#define USER_RessREPASSWORD  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/user/repassword"]

//注册
#define USER_REGIST  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/user/regist"]
//我的预约列表
#define APPOPINTMENT_SEARCH  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/appointment/search"]
//预约详情
#define APPOPINTMENT_ONE  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/appointment/one"]
//收藏微课堂
#define COLLECTION_DISCOVER  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/collection/discover"]
//取消微课堂
#define COLLECTION_DELETE  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/collection/delete"]

///api/chr/collection/diseasequestion
#define COLLECTION_DISCOVERLIST  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/collection/diseasequestion"]


//我的收藏-题库
#define COLLECTION_LIST_DISEASEQUESTION  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/collection/list/diseasequestion"]
//我的收藏-微课堂
#define COLLECTION_LIST_DISCOVER  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/collection/list/discover"]
//我的信息编辑 (可用，上送那个字段就修改那个字段，只修改一个字段没必要全部上送)/api/chr/user/user/update
#define USER_USER_UPDATE  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/user/user/update"]
//添加患者
#define PATIENT_SAVE  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/patient/save"]
//患者删除
#define PATIENT_DELETE  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/patient/delete"]
//退出登录
#define USER_LOGOUT  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/user/logout"]
//自检上送结果
#define RESULT_SAVE  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/result/save"]
//历史记录列表
#define RESULT_LIST  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/result/list"]
//历史记录详情
#define RESULT_ONE  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/result/one"]
//微课堂数据列表
#define DISCOVER_LIST  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/discover/list"]

//微课堂数据是否收藏
#define DISCOVER_ISEFFECTIVE  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/collectiondiscover/iseffective"]


//患者列表
#define PATIENT_LIST  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/patient/list"]

#endif /* RequestsURL_h */
