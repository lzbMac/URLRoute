//
//  TTSURLRouteConfigDelegate.h
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//
/*
 *1、此处代理由注册类执行，所需参数由业务决定
 *
 */
#import <Foundation/Foundation.h>

@protocol TTSURLRouteConfigDelegate <NSObject>

@optional
- (BOOL)route_isLogin;
- (NSString *)route_memberID;
- (NSString *)route_externalMemberID;
- (NSString *)route_version;
- (NSString *)route_versionType;
- (NSString *)route_refid;
- (NSString *)route_deviceID;

@end
