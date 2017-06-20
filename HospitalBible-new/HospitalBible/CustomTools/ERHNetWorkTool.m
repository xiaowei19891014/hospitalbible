//
//  ERHNetWorkTool.m
//  EIntegrate
//
//  Created by xa on 16/11/23.
//  Copyright © 2016年 bocop. All rights reserved.
//

#import "ERHNetWorkTool.h"
#import "ERHNetWorkTool+HttpHeader.h"
#import "ERHLogin.h"


@implementation ERHNetWorkTool

//默认网络请求时间
static const NSUInteger kDefaultTimeoutInterval = 20;
static ERHNetWorkTool *_instanceSingle;

+ (instancetype )sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceSingle = [[ERHNetWorkTool alloc] init];
        //WithBaseURL:[NSURL URLWithString:BASEURL]];
        _instanceSingle.requestSerializer = [AFJSONRequestSerializer serializer];
        _instanceSingle.responseSerializer = [AFJSONResponseSerializer serializer];
        _instanceSingle.requestSerializer.timeoutInterval = kDefaultTimeoutInterval;
        //[sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        //sessionManager.requestSerializer.timeoutInterval = kDefaultTimeoutInterval;
        //[sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        _instanceSingle.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html",@"charset=utf-8", nil];
    });
    return _instanceSingle;
}

- (void)requestDataWithUrl:(NSString *)url
                    params:(NSDictionary *)params
                   success:(void (^)(NSDictionary *responseObject))success
                   failure:(void (^)(NSError *error))failure
{
    [self requestDataWith:POST Url:url params:params header:nil parametersUrl:nil success:^(id responseObject) {
        if (success) {
            success((NSDictionary *)responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
//            [self hanldTheLogoutWith:error];
        }
    }];
}

- (void)requestDataWith:(MethodName)methodName
                    Url:(NSString *)url
                 params:(NSDictionary *)params
                 header:(NSDictionary *)header
          parametersUrl:(NSDictionary *)parametersUrl
                success:(void (^)(id responseObject))success
                failure:(void (^)(NSError *error))failure{
    //要是有parametersUrl 则需要对URL进行拼接转换
    NSString *urlString = nil;
    if (parametersUrl && [parametersUrl count]>0) {
        urlString = [self serializeURL:url params:parametersUrl];
    }else{
        urlString = url;
    }
    NSLog(@"接口URL：%@",urlString);
    //要是有请求头则直接设置 没有传的话则需要公共请求头
    if (header) {
        [_instanceSingle.requestSerializer setCustomValueForHTTPHeaderDict:header];
        NSLog(@"接口header：%@",header);

    }else{
        [_instanceSingle.requestSerializer setCustomValueForHTTPHeaderDict:[self getERHHttpHeaders]];
        NSLog(@"接口header：%@",[self getERHHttpHeaders]);
    }
    
    
    NSLog(@"报文体：%@",params);
    if(methodName == GET){
        [_instanceSingle GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 请求成功，解析数据
            NSDictionary *headerDict = _instanceSingle.responseSerializer.headerHttpResponse;
            self.Cookie = [self setResponseCookie:headerDict];
            
            if (success) {
                id result = nil;
                if ([responseObject isKindOfClass:[NSData class]]){
                    result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                }else{
                    result = responseObject;
                }
                
                //错误码处理
                if (success) {
                    success(result);
                }            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
                //[self hanldTheLogoutWith:error];
            }
        }];
    }
    if(methodName == POST){
        [_instanceSingle POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 请求成功，解析数据
            NSDictionary *headerDict = _instanceSingle.responseSerializer.headerHttpResponse;

            self.Cookie = [self setResponseCookie:headerDict];
            if (success) {
                id result = nil;
                if ([responseObject isKindOfClass:[NSData class]]){
                    result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                }else{
                    result = responseObject;
                }
                NSLog(@"接口URL：%@",urlString);
                NSLog(@"报文体：%@",params);
                NSLog(@"返回成功数据：%@",result);
                
                if ([result isKindOfClass:[NSDictionary class]] && result[@"msg"]) {
                    [EUnit showToastWithTitle:result[@"msg"]];
                    if (failure) {
                        failure(nil);
                    }
                }else{
                    //错误码处理
                    if (success) {
                        success(result);
                    }
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                NSLog(@"接口URL：%@",urlString);
                NSLog(@"报文体：%@",params);
                NSLog(@"返回错误：%@",error);
                if (failure) {
                    failure(error);
                }
                [EUnit showToastWithTitle:@"链接服务器超时，请稍后再试"];

            }
        }];
    }
    if(methodName == PUT){
        
        
        [_instanceSingle PUT:urlString parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 请求成功，解析数据
            NSDictionary *headerDict = _instanceSingle.responseSerializer.headerHttpResponse;
            
            self.Cookie = [self setResponseCookie:headerDict];
            if (success) {
                id result = nil;
                if ([responseObject isKindOfClass:[NSData class]]){
                    result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                }else{
                    result = responseObject;
                }
                NSLog(@"返回成功数据：%@",result);
                //错误码处理
                if (result[@"msgcde"]) {
                    if (result[@"welcome"]) {
                        success(result);
                    }else{
                        NSString *messageCode = @"超时...";
                        if ([result[@"msgcde"] isKindOfClass:[NSNumber class]]) {
                            messageCode = [result[@"msgcde"] stringValue];
                        }else{
                            messageCode = result[@"msgcde"];
                        }
                        NSDictionary *errorInfo;
                        if (result[@"rtnmsg"]) {
                            errorInfo = @{@"error_code":messageCode,@"error_description":result[@"rtnmsg"]};
                        }else
                        {
                            errorInfo = @{@"error_code":messageCode,@"error_description":@""};
                        }
                        
                        NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain
                                                                    code:404
                                                                userInfo:errorInfo];
                        
                        if (failure) {
                            failure(error);
                        }
                        //[self hanldTheLogoutWith:error];
                        
                    }
                }else{
                    if (success) {
                        success(result);
                    }
                }
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failure) {
                failure(error);
                NSLog(@"%@",error);
                //[self hanldTheLogoutWith:error];
                
            }
            
        }];
    }
}
//-(void)hanldTheLogoutWith:(NSError*)error{
//    NSString *errorName =[[error userInfo] objectForKey:@"error_description"];
//    NSString *errorCode = [[error userInfo] objectForKey:@"error_code"];
//    
//    if ([errorName isEqualToString:@"您的账号已在别处登录，请注意账号安全！"] || [errorName isEqualToString:@"登录失效，请重新登录！"] || [errorCode isEqualToString:@"ASR-000003"]|| [errorCode isEqualToString:@"ASR-000004"]|| [errorCode isEqualToString:@"ASR-000005"]|| [errorCode isEqualToString:@"ASR-000006"]|| [errorCode isEqualToString:@"invalid_token"]|| [errorCode isEqualToString:@"invalid_grant"]) {
//        
//        [[NSNotificationCenter defaultCenter]postNotificationName:ERHLOGINOUT object:nil];
//    }
//}



//处理URL
- (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params{
    NSURL *parsedURL = [NSURL URLWithString:baseURL];
    NSString *queryPrefix = parsedURL.query ? @"&" : @"?";
    NSMutableArray *pairs = [NSMutableArray array];
    for (NSString *key in [params keyEnumerator]){
        if (([[params objectForKey:key] isKindOfClass:[UIImage class]])
            ||([[params objectForKey:key] isKindOfClass:[NSData class]])){
            continue;
        }
        NSString *escaped_value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                        NULL, /* allocator */
                                                                                                        (CFStringRef)[params objectForKey:key],
                                                                                                        NULL, /* charactersToLeaveUnescaped */
                                                                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                        kCFStringEncodingUTF8));
        
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
    }
    NSString* query = [pairs componentsJoinedByString:@"&"];
    return [NSString stringWithFormat:@"%@%@%@", baseURL, queryPrefix, query];
}

/*
 //公共报文头设置
 - (NSDictionary *)formatPOSTHeader:(ERHLoginSuccessdInfor *)authorizeInfo{
 NSDictionary *formatRequestHeader;
 if ([authorizeInfo.userId length]>0) {
 NSString *formatCookie = @"" ;
 if (authorizeInfo.Cookie.length>0) {
 formatCookie=authorizeInfo.Cookie;
 }
 formatRequestHeader = @{
 //                                @"clentid":APP_ERH_KEY,
 @"userid":authorizeInfo.userId,
 //                                @"acton":NOTNIL(authorizeInfo.accessToken),
 @"chnflg":@"1",
 @"trandt":@"",
 @"trantm":@"",
 @"cookie":formatCookie,
 @"transSeqNo":[CommonMethod createUUID],
 @"sndtranno":[CommonMethod createUUID],
 @"chnway":@""
 
 };
 return formatRequestHeader;
 
 }else{
 formatRequestHeader = @{
 //                                @"clentid":APP_ERH_KEY,
 @"userid":@"",
 //                                @"acton":NOTNIL(authorizeInfo.accessToken),
 @"chnflg":@"1",
 @"trandt":@"",
 @"transSeqNo":[CommonMethod createUUID],
 @"sndtranno":[CommonMethod createUUID],
 @"trantm":@""
 };
 return formatRequestHeader;
 }
 }*/

//获取成功返回的cookie
- (NSString *)setResponseCookie:(id )response{
    NSString *format = [response objectForKey:@"Set-Cookie"];
    NSString *cookieStr= [format substringToIndex:[format rangeOfString:@";"].location];
    return cookieStr;
}

#pragma mark -头像上传
- (void)postUploadHeadImage:(UIImage *)image{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = @"http://上传地址";
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        /*
         NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
         // 要上传保存在服务器中的名称 使用时间来作为文件名 2014-04-30 14:20:57.png 让不同的用户信息,保存在不同目录中
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         // 设置日期格式
         formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
         NSString *fileName = [formatter stringFromDate:[NSDate date]];
         [formData appendPartWithFileURL:fileURL name:@"uploadFile" fileName:fileName mimeType:@"image/png" error:NULL];
         */
        NSData *fileData = UIImageJPEGRepresentation(image, 0.5);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置日期格式
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *fileName = [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@"传入的用户ID"];
        [formData appendPartWithFileData:fileData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        NSLog(@"上传成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        NSLog(@"上传失败");
    }];
}

- (void)cancleRequest{
    [_instanceSingle.operationQueue cancelAllOperations];
    for (NSURLSessionDataTask *task in _instanceSingle.dataTasks) {
        [task cancel];
    }
}

/*
 //遇到频繁的Http请求，如何取消之前已经发送的Http请求
 //该方法保证了同一时刻只可以进行一次网络请求 有弊端
 [self.arrayOfTasks enumerateObjectsUsingBlock:^(NSURLSessionDataTask *taskObj, NSUInteger idx, BOOL *stop) {
 [taskObj cancel];
 }];
 [self.arrayOfTasks removeAllObjects];
 */
@end
