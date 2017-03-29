//
//  TTSURLRouteHold.m
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TTSURLRouteHold.h"
#import "TTSURLRouteHoldConfig.h"
#import "TTSURLRouteConfig+RouteUserInfo.h"

@interface TTSURLRouteHoldConfig (TTSURLRouteHold)
+ (instancetype)defaultHoldConfig;
- (id<TTSURLRouteHoldLoginDelegate>)loginDelegate;
@end

@interface TTSURLRouteHold ()

@property (nonatomic, strong) TTSURLRouteResult *routeResult;
@property (nonatomic, copy)TTSURLRouteHoldCompleteBlock completeBlock;

@end
@implementation TTSURLRouteHold
- (void)dealHoldWithRouteResult:(TTSURLRouteResult *)routeResult completeBlock:(TTSURLRouteHoldCompleteBlock)completeBlock {
    //验证登录情况
    __block typeof(self) weakSelf = self;
    TTSURLRouteHoldConfig *holdConfig = [TTSURLRouteHoldConfig defaultHoldConfig];
    if (self.wantLogin) {
        NSString *memberID = [TTSURLRouteConfig route_memberID];
        if (memberID.length) {
            self.wantLogin = NO;
            [self dealHoldWithRouteResult:routeResult completeBlock:completeBlock];
        }
        else {
            id<TTSURLRouteHoldLoginDelegate> loginDelegate = holdConfig.loginDelegate;
            if (loginDelegate && [loginDelegate respondsToSelector:@selector(startLoginWithSuccessBlock:options:)]) {
                NSDictionary *options = @{kRouteHoldLastViewController:routeResult.lastViewController};
                [loginDelegate startLoginWithSuccessBlock:^(BOOL isLogin) {
                    if (isLogin) {
                        weakSelf.wantLogin = NO;
                        [weakSelf dealHoldWithRouteResult:routeResult completeBlock:completeBlock];
                    }
                } options:options];
            }
        }
    }
    else {
        //检查passKeys
        [self.passKeys enumerateObjectsUsingBlock:^(NSString *propertyName, NSUInteger idx, BOOL *stop) {
            if ([propertyName isKindOfClass:[NSString class]]) {
                id lastViewController = routeResult.lastViewController;
                SEL selector = NSSelectorFromString(propertyName);
                if ([lastViewController respondsToSelector:selector]) {
                    id viewController = routeResult.viewController;
                    id propertyValue = [lastViewController valueForKey:propertyName];
                    if ([viewController respondsToSelector:selector]) {
                        [viewController setValue:propertyValue forKey:propertyName];
                    }
                }
            }
        }];
        //检查属性
        [self.checkKeys enumerateObjectsUsingBlock:^(NSString *propertyName, NSUInteger idx, BOOL *stop) {
            if ([propertyName isKindOfClass:[NSString class]]) {
                NSDictionary *param = routeResult.parameter;
                id obj = param[propertyName];
                if (!obj) {
                    NSAssert(obj, ([NSString stringWithFormat:@"链接未提供页面%@值", propertyName]));
                }
            }
        }];
        //自定义操作
        BOOL dontHold = YES;
        if (self.holdController.length > 0) {
            Class cls = NSClassFromString(self.holdController);
            id<TTSURLRouteHoldProtocol> holdObj = cls.new;
            if ([holdObj respondsToSelector:@selector(holdWithParameters:)]) {
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                if (routeResult.viewController) [param setValue:routeResult.viewController forKey:kRouteHoldParameter];
                if (routeResult.lastViewController) [param setValue:routeResult.lastViewController forKey:kRouteHoldLastViewController];
                if (routeResult.parameter) [param setValue:routeResult.parameter forKey:kRouteHoldParameter];
                
                dontHold = NO;
                [holdObj holdWithParameters:param];
            }
        }
        //正常回调
        if (dontHold && completeBlock) {
            completeBlock(routeResult, routeResult.parameter);
        }
    }
}
@end
