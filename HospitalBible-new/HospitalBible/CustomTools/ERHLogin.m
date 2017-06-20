//
//  ERHLogin.m
//  EIntegrate
//
//  Created by xa on 16/11/23.
//  Copyright © 2016年 bocop. All rights reserved.
//

#import "ERHLogin.h"


@interface ERHLogin()
@property NSString *appKey;
@property NSString *appSecrect;
@property NSString *appLoginType;
@property NSString *serverUrl;
@property NSString *asrURL;
@end

@implementation ERHLogin
static ERHLogin *_sharedNERHLogin;

+ (ERHLogin *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //_sharedNERHLogin = [[ERHLogin alloc] initWithAppKey:APP_NFG_KEY appSecret:APP_NFG_SECRET appLoginType:@"ASR" URL:ASR_BOCOP_URL_AF asrURL:ASR_BOCOP_URL_AF];
    });
    return _sharedNERHLogin;
}



- (id)initWithAppKey:(NSString *)appKey
           appSecret:(NSString *)appSecrect
        appLoginType:(NSString *)appLoginType
                 URL:(NSString *)serverUrl
              asrURL:(NSString *)asrURL
{
    self.appKey = appKey;
    self.appSecrect = appSecrect;
    self.asrURL = asrURL;
    self.appLoginType = appLoginType;
    self.serverUrl = serverUrl;
    return self;
}
@end
