//
//  TTSRouteResult.m
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TTSURLRouteResult.h"
NSString * const kRouteResultNative     = @"ttsclient";     //跳转native页面
NSString * const kRouteResultExternal   = @"external";      //跳转外部
NSString * const kRouteResultWeb        = @"http";          //跳转web
NSString * const kRouteResultSECWeb     = @"https";         //跳转web
NSString * const kRouteResultFile       = @"file";          //等价web
NSString * const kRouteResultClient     = @"ttsicar";      //外部浏览器启动客户端

NSString * const kRouteResultLastViewController = @"kRouteResultLastViewController";
NSString * const kRouteResultUseableURL = @"kRouteResultUseableURL";
NSString * const kRouteResultOriginalURL = @"kRouteResultOriginalURL";
NSString * const kRouteOriginalURLString = @"kRouteOriginalURLString";

@interface TTSURLRouteResult ()

@property (nonatomic, assign, readwrite) TTSURLRouteOpenType openType;

@end
@implementation TTSURLRouteResult

- (instancetype)initWithScheme:(NSString *)scheme {
    self = [self init];
    if (self) {
        if ([scheme isEqualToString:kRouteResultNative]) {
            self.openType = URLRouteOpenNative;
        }
        else if ([scheme isEqualToString:kRouteResultExternal]) {
            self.openType = URLRouteOpenExternal;
        }
        else if ([scheme isEqualToString:kRouteResultWeb] ||
                 [scheme isEqualToString:kRouteResultFile] ||
                 [scheme isEqualToString:kRouteResultSECWeb]) {
            self.openType = URLRouteOpenWeb;
        }
        else {
            self.openType = URLRouteOpenUndefine;
        }
    }
    return self;
}

@end
