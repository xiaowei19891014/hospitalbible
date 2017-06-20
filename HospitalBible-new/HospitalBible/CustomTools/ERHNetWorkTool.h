//
//  ERHNetWorkTool.h
//  EIntegrate
//
//  Created by xa on 16/11/23.
//  Copyright © 2016年 bocop. All rights reserved.
//

#import "AFNetworking.h"
//#import "CommonMethod.h"

typedef enum : NSUInteger {
    POST=0,
    GET,
    PUT
} MethodName;

@interface ERHNetWorkTool : AFHTTPSessionManager

@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSDictionary *headers;
@property (nonatomic, strong) NSDictionary *postParam;
@property (nonatomic, strong) NSString *Cookie;
@property (nonatomic, strong) NSString *urlString;

+ (instancetype)sharedManager;

/*
 header          如果有需要自定义报文头则传入自定义报文头，如果使用公共报文头则传入nil
 postUrl         输入请求路径地址
 parametersUrl   新增用户授权信息（容器）接口调用时候传入参数，和postUrl拼接上送，如果不需要则传入nil
 parametersBody  接口上送报文体
 success         请求成功返回
 failure         请求失败返回
 */
- (void)requestDataWith:(MethodName)methodName
                    Url:(NSString *)url
                 params:(NSDictionary *)params
                 header:(NSDictionary *)header
          parametersUrl:(NSDictionary *)parametersUrl
                success:(void (^)(id responseObject))success
                failure:(void (^)(NSError *error))failure;

- (void)requestDataWithUrl:(NSString *)url
                 params:(NSDictionary *)params
                success:(void (^)(NSDictionary *responseObject))success
                failure:(void (^)(NSError *error))failure;

- (void)postUploadHeadImage:(UIImage *)image;
- (void)cancleRequest;
//- (void)removeLodingView;
@end
