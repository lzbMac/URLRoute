//
//  TTSURLRouteConfig+RouteUserInfo.h
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TTSURLRouteConfig.h"

@interface TTSURLRouteConfig (RouteUserInfo)

+ (BOOL)route_isLogin;
+ (NSString *)route_memberID;
+ (NSString *)route_externalMemberID;
+ (NSString *)route_version;
+ (NSString *)route_versionType;
+ (NSString *)route_refid;
+ (NSString *)route_deviceID;
@end
