//
//  UIViewController+TTSURLRoute.m
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "UIViewController+TTSURLRoute.h"
#import "UIViewController+TTSURLRouteCallBack.h"
#import "TTSURLRouteConfig+RouteUserInfo.h"
#import <objc/runtime.h>
#import "TTSURLRoute.h"
#import "TTSURLRouteResult.h"
#import "TTSURLRouteHoldConfig.h"
//#import "TTSURLBridge.h"
#import "NSURL+URLChar.h"

NSString *const TTSURLRouteHandleErrorNotification = @"TTSURLRouteHandleErrorNotification";
NSString *const TTSURLRouteHandleCompleteNotification = @"TTSURLRouteHandleCompleteNotification";
NSString *const kURLRouteOpenAnimated = @"kURLRouteOpenAnimated";           //是否需要动画
NSString *const kURLRouteOpenAnimatedTransition = @"kURLRouteOpenAnimatedTransition"; //动画形式
NSString *const kURLRouteOpenCompletion = @"kURLRouteOpenCompletion";         //完成后回调操作

extern NSString * const kRouteOriginalURLString;

@interface TTSURLRouteHoldConfig (TTSURLRouteHold)
+ (instancetype)defaultHoldConfig;
- (id<TTSURLRouteHoldLoginDelegate>)loginDelegate;
@end
@implementation UIViewController (TTSURLRoute)
#pragma mark -
- (void)openRouteURL:(NSURL *)url options:(NSDictionary *)options {
    if (!url) return;
    NSURL *newURL = url;
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[kRouteResultLastViewController] = [self p_route_lastViewController];
    dictionary[kRouteResultUseableURL] = newURL;
    [dictionary addEntriesFromDictionary:options];
    
    [self p_route_openRouteURL:newURL options:dictionary];

}

#pragma mark -
- (UIViewController *)p_route_lastViewController {
    UIViewController *viewController = nil;
    if ([self isKindOfClass:[UINavigationController class]]) {
        viewController = ((UINavigationController *)self).topViewController;
    }
    else if ([self isKindOfClass:[UIViewController class]]) {
        viewController = self;
    }
    else {
        NSAssert(viewController, ([NSString stringWithFormat:@"CTURLRoute Tip:缺少Nav"]));
    }
    return viewController;
}

- (void)p_route_openRouteURL:(NSURL *)routeURL options:(NSDictionary *)dict
{
    BOOL success = [p_route_URLRoute() routeWithURL:routeURL options:dict completeblock:^(TTSURLRouteResult *result, NSDictionary *otherOptions) {
        NSDictionary *options = otherOptions ?: dict;
        switch (result.openType) {
            case URLRouteOpenWeb:
            case URLRouteOpenNative: {
                UIViewController *viewController = result.viewController;
                UIViewController *lastViewController = result.lastViewController;
                //设置callback值
                viewController.routeCallBackViewController = lastViewController;
                
                NSDictionary *param = result.parameter;
                if (lastViewController) {
                    //Push前回调，供对象属性参数初始化
                    if ([viewController respondsToSelector:@selector(routeWillPushControllerWithParam:)]) {
                        [viewController routeWillPushControllerWithParam:param];
                    }
                    //具体页面打开操作
                    NSArray *allOpenKeys = options.allKeys;
                    BOOL animated = YES;
                    if ([allOpenKeys containsObject:kURLRouteOpenAnimated]) {
                        animated = [options[kURLRouteOpenAnimated] boolValue];
                    }
                    TTSURLRouteOpenCompletion completion = nil;
                    if ([allOpenKeys containsObject:kURLRouteOpenCompletion]) {
                        completion = options[kURLRouteOpenCompletion];
                    }
                    URLRouteOpenAnimatedTransition openType = URLRouteOpenAnimatedPush;
                    if ([allOpenKeys containsObject:kURLRouteOpenAnimatedTransition]) {
                        openType = [options[kURLRouteOpenAnimatedTransition] integerValue];
                    }
                    switch (openType) {
                        case URLRouteOpenAnimatedPush: {
                            [lastViewController.navigationController pushViewController:viewController animated:animated];
                            if (completion) completion();
                        } break;
                        case URLRouteOpenAnimatedPresent: {
                            [lastViewController presentViewController:viewController animated:animated completion:completion];
                        } break;
                        default:
                            break;
                    }
                    //Push后回调，做一些清理操作
                    if ([viewController respondsToSelector:@selector(routeDidPushControllerWithParam:)]) {
                        [viewController routeDidPushControllerWithParam:param];
                    }
                }
                else {
                    NSAssert(lastViewController, ([NSString stringWithFormat:@"%@的NavigationController不存在，无法push", NSStringFromClass([self class])]));
                }
            }
                break;
            case URLRouteOpenExternal: {
                NSURL *URL = options[kRouteResultUseableURL];
                [[UIApplication sharedApplication] openURL:URL];
            }
                break;
            default: break;
        }
    }];
    if (success) {
        [[NSNotificationCenter defaultCenter] postNotificationName:TTSURLRouteHandleCompleteNotification object:dict];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:TTSURLRouteHandleErrorNotification object:routeURL];
    }
}

#pragma mark -
static TTSURLRoute *p_route_URLRoute() {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TTSURLRoute alloc] init];
    });
    return instance;
}

#pragma mark - interface func
- (void)openLoginWithCompletion:(TTSURLRouteOpenLoginCompletionBlock)completion {
    __weak typeof(self) weakSelf = self;
    __block NSDictionary *options = @{kRouteHoldLastViewController:weakSelf};
    if ([TTSURLRouteConfig route_isLogin]) {
        if (completion) completion(YES, options);
    }
    else {
        TTSURLRouteHoldConfig *holdConfig = [TTSURLRouteHoldConfig defaultHoldConfig];
        id<TTSURLRouteHoldLoginDelegate> loginDelegate = holdConfig.loginDelegate;
        if (loginDelegate && [loginDelegate respondsToSelector:@selector(startLoginWithSuccessBlock:options:)]) {
            
            [loginDelegate startLoginWithSuccessBlock:^(BOOL isLogin) {
                if (completion) completion(isLogin, options);
            } options:options];
        }
    }
}

- (void)openRouteURLString:(NSString *)aString options:(NSDictionary *)options {
    if (!aString.length) return;
#ifdef Debug
    NSLog(@"URLRoute已接收%@", aString);
#endif
    NSURL *url = [NSURL URLWithString:aString];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setValue:aString forKey:kRouteOriginalURLString];
    [dictionary addEntriesFromDictionary:options];
    [self openRouteURL:url options:dictionary];
}
@end

@implementation UIViewController (TTSURLRouteHoldObject)

- (id)holdObject {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setHoldObject:(id)holdObject {
    objc_setAssociatedObject(self, @selector(holdObject), holdObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
