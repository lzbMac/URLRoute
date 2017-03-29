//
//  TTSURLRouteConfig+RouteUserInfo.m
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TTSURLRouteConfig+RouteUserInfo.h"
#import "TTSURLRouteConfigDelegate.h"

@interface TTSURLRouteConfig ()

+ (instancetype)defaultRouteConfig;
- (id<TTSURLRouteConfigDelegate>)configDelegate;

@end
@implementation TTSURLRouteConfig (RouteUserInfo)
+ (BOOL)route_isLogin {
    return [[TTSURLRouteConfig defaultRouteConfig].configDelegate route_isLogin];
}
+ (NSString *)route_memberID {
    return [[TTSURLRouteConfig defaultRouteConfig].configDelegate route_memberID];
}
+ (NSString *)route_externalMemberID {
    return [[TTSURLRouteConfig defaultRouteConfig].configDelegate route_externalMemberID];
}
+ (NSString *)route_version {
    return [[TTSURLRouteConfig defaultRouteConfig].configDelegate route_version];
}
+ (NSString *)route_versionType {
    return [[TTSURLRouteConfig defaultRouteConfig].configDelegate route_versionType];
}
+ (NSString *)route_refid {
    return [[TTSURLRouteConfig defaultRouteConfig].configDelegate route_refid];
}
+ (NSString *)route_deviceID {
    return [[TTSURLRouteConfig defaultRouteConfig].configDelegate route_deviceID];
}

@end
