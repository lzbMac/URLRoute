//
//  TTSURLRoute.m
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TTSURLRoute.h"
#import <UIKit/UIViewController.h>
#import "TTSURLRouteConfig.h"
#import "TTSURLRouteResult.h"
#import "TTSURLRouteHold.h"
#import "TTSRouteScheme.h"
#import "NSURL+URLChar.h"

static NSMutableDictionary *routeControllersMap = nil;

@interface TTSURLRoute ()

@property (nonatomic, strong) NSDictionary *routeDictionary;

@end
@implementation TTSURLRoute
+ (instancetype)defaultURLRoute {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = self.new;
    });
    return instance;
}

- (NSDictionary *)routeDictionary {
    return _routeDictionary ?: ({ _routeDictionary = [TTSURLRouteConfig routeDictionary]; });
}

- (BOOL)routeWithURL:(NSURL *)URL options:(NSDictionary *)options completeblock:(TTSURLRouteCompleteBlock)completeBlock {
    BOOL isStandard = [TTSRouteScheme isStandardURL:URL];
    if (isStandard) {   //新规则
        NSMutableDictionary *blockParam = [NSMutableDictionary dictionary];
        [blockParam addEntriesFromDictionary:options];
        //根据URL在TTSRoute得到dict，或者是一个对象，可以得到项目、页面
        TTSRouteScheme *routeScheme = [[TTSRouteScheme alloc] initWithURL:URL];
        //根据规则修改成可用URL
        [blockParam addEntriesFromDictionary:routeScheme.parameter];
        blockParam[kRouteResultUseableURL] = routeScheme.useableURL;
        blockParam[kRouteResultOriginalURL] = routeScheme.originalURL;
        
        TTSURLRouteResult *routeResult = [[TTSURLRouteResult alloc] initWithScheme:routeScheme.scheme];
        routeResult.lastViewController = blockParam[kRouteResultLastViewController];
        routeResult.parameter = blockParam;
        
        switch (routeResult.openType) {
            case URLRouteOpenNative: {
                //根据这个对象在routeDictionary里获取对应的ViewController类
                NSDictionary *schemeDictionary = self.routeDictionary[routeScheme.scheme];
                if (!schemeDictionary) return NO;
                NSDictionary *moduleDictionary = schemeDictionary[routeScheme.module];
                if (!moduleDictionary) {
                    NSLog(@"%@", [NSString stringWithFormat:@"TTSURLRoute module值错误：“%@”不存在", routeScheme.module]);
                    return NO;
                }
                NSDictionary *pageDictionary = moduleDictionary[routeScheme.page];
                if (!pageDictionary) {
                    NSLog(@"%@", [NSString stringWithFormat:@"TTSURLRoute page值错误：“%@”不存在", routeScheme.page]);
                    return NO;
                }
                
                NSString *bundleName = pageDictionary[kRouteConfigBundle] ?: moduleDictionary[kRouteConfigBundle];
                routeResult.viewController = [self viewControllerWithPageDictionary:pageDictionary withBundleName:bundleName];
                
                TTSURLRouteHold *routeHold = [self routeHoldWithPageDictionary:pageDictionary];
                //从链接中获取是否需要登录
                BOOL needLogin = [URL isNeedLogin];
                if (needLogin) routeHold.wantLogin = YES;
                if (routeHold) {
                    [routeHold dealHoldWithRouteResult:routeResult completeBlock:completeBlock];
                }
                else {
                    if (completeBlock) completeBlock(routeResult, blockParam);
                }
            }
                break;
            case URLRouteOpenWeb: {
                NSDictionary *pageDictionary = self.routeDictionary[routeScheme.scheme];
                if (!pageDictionary) {
                    NSLog(@"%@", [NSString stringWithFormat:@"TTSURLRoute page值错误：“%@”不存在", routeScheme.scheme]);
                    return NO;
                }
                routeResult.viewController = [self viewControllerWithPageDictionary:pageDictionary withBundleName:nil];
                routeResult.parameter = blockParam;    //将UseableURL传出去
                
                TTSURLRouteHold *routeHold = [self routeHoldWithPageDictionary:pageDictionary];
                BOOL needLogin = [URL isNeedLogin]; //
                if (needLogin) routeHold.wantLogin = YES;
                if (routeHold) {
                    [routeHold dealHoldWithRouteResult:routeResult completeBlock:completeBlock];
                }
                else {
                    if (completeBlock) completeBlock(routeResult, blockParam);
                }
            }
                break;
            case URLRouteOpenExternal: {
                if (completeBlock) completeBlock(routeResult, blockParam);
            }
                break;
            default: {
                //FIXME:默认操作，打开一个网址，传入无法解析的URL
            }
                break;
        }
    }
    else {  //20160307 错误规则直接跳转外部
        NSString *scheme = @"http";
        TTSURLRouteResult *routeResult = [[TTSURLRouteResult alloc] initWithScheme:scheme];
        routeResult.lastViewController = options[kRouteResultLastViewController];
        routeResult.parameter = options;
        
        NSDictionary *pageDictionary = self.routeDictionary[scheme];
        routeResult.viewController = [self viewControllerWithPageDictionary:pageDictionary withBundleName:nil];
        routeResult.parameter = options;    //将UseableURL传出去
        
        TTSURLRouteHold *routeHold = [self routeHoldWithPageDictionary:pageDictionary];
        if (routeHold) {
            [routeHold dealHoldWithRouteResult:routeResult completeBlock:completeBlock];
        }
        else {
            if (completeBlock) completeBlock(routeResult, options);
        }
        return NO;
    }
    return YES;
}

- (UIViewController *)viewControllerWithPageDictionary:(NSDictionary *)pageDictionary withBundleName:(NSString *)bundleName {
    NSString *pageClassName = pageDictionary[kRouteConfigClass];
    if (pageClassName.length) {
        NSString *pageBundleName = pageDictionary[kRouteConfigBundle] ?: bundleName;
        NSString *pageNibName = pageDictionary[kRouteConfigNib] ?: pageClassName;
        
        Class cls = NSClassFromString(pageClassName);
        if (cls && [cls isSubclassOfClass:[UIViewController class]]) {
            NSBundle *bundle = nil;
            if (pageBundleName.length) {
                bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:pageBundleName ofType:@"bundle"]];
            }
            pageNibName = [pageNibName length] > 0 ? pageNibName : nil;
            id retObj = bundle ? ([[cls alloc] initWithNibName:pageNibName bundle:bundle]) : ([[cls alloc] init]);
            return retObj;
        }
        else {
            NSLog(@"%@", [NSString stringWithFormat:@"TTSURLRoute %@类不存在", pageClassName]);
        }
    }
    return nil;
}

- (TTSURLRouteHold *)routeHoldWithPageDictionary:(NSDictionary *)pageDictionary {
    NSDictionary *pageHoldDictionary = pageDictionary[kRouteConfigHold];
    if ([pageHoldDictionary isKindOfClass:[NSDictionary class]]) {
        TTSURLRouteHold *routeHold = TTSURLRouteHold.new;
        routeHold.holdController = pageHoldDictionary[kRouteConfigClass];    //类最后处理
        routeHold.wantLogin = [pageHoldDictionary[kRouteConfigWantLogin] boolValue];
        routeHold.passKeys = pageHoldDictionary[kRouteConfigPassKeys];
        routeHold.checkKeys = pageHoldDictionary[kRouteConfigCheckKeys];
        return routeHold;
    }
    return nil;
}

@end
