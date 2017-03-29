//
//  TTSCommonModuleRegister.m
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TTSCommonModuleRegister.h"
#import "TTSURLRouteKit.h"
#import "LoginMananger.h"
#import "TTSMemberManager.h"

@implementation TTSCommonModuleRegister
+ (void)registerURLRoutePlist {
    NSMutableArray *paths = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"URLRoutePlist" ofType:@"plist"];
    [paths addObject:path];
    [TTSURLRouteConfig addRouteWithPlistPaths:paths];
    
    //注册登录类
    [TTSURLRouteHoldConfig registerURLRouteHoldLoginClass:[LoginMananger class]];
    
    //注册信息类
    [TTSURLRouteConfig registerURLRouteConfigClass:[TTSMemberManager class]];
}
@end
