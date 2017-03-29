//
//  TTSMemberManager.m
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TTSMemberManager.h"
#import "TTSURLRouteConfigDelegate.h"
@interface TTSMemberManager()<TTSURLRouteConfigDelegate>

@end

@implementation TTSMemberManager

- (BOOL)route_isLogin{
    NSString *loginFlag = [[NSUserDefaults standardUserDefaults] objectForKey:@"login_flag"];
    if (loginFlag.length && [loginFlag isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}

- (NSString *)route_memberID{
    NSString *loginFlag = [[NSUserDefaults standardUserDefaults] objectForKey:@"login_flag"];
    if (loginFlag.length && [loginFlag isEqualToString:@"1"]) {
        return @"route_memberID";
    }
    return nil;
}
- (NSString *)route_externalMemberID{
    return @"hhah";
}
- (NSString *)route_version{
    return @"hhah";
}

- (NSString *)route_versionType{
    return @"hhah";
}

- (NSString *)route_refid{
    return @"hhah";
}

- (NSString *)route_deviceID{
    return @"hhah";
}


@end
