//
//  TTSURLRouteConfig.m
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TTSURLRouteConfig.h"
NSString * const kRouteConfigClass      = @"_class";
NSString * const kRouteConfigBundle     = @"_bundle";
NSString * const kRouteConfigNib        = @"_nib";

NSString * const kRouteConfigHold       = @"_hold";
NSString * const kRouteConfigWantLogin  = @"_login";
NSString * const kRouteConfigCheckKeys  = @"_checkKeys";
NSString * const kRouteConfigPassKeys   = @"_passKeys";

extern NSString *const kRouteResultNative;
extern NSString *const kRouteResultWeb;
extern NSString *const kRouteResultFile;
extern NSString *const kRouteResultSECWeb;

@interface TTSURLRouteConfig ()

@property (nonatomic, strong) NSMutableDictionary *p_routeDictionary;
@property (nonatomic, strong) id<TTSURLRouteConfigDelegate> configDelegate;


@end
@implementation TTSURLRouteConfig
+ (instancetype)defaultRouteConfig {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)addRouteDictionary:(NSDictionary *)routeDictionary{
    if ([routeDictionary isKindOfClass:[NSDictionary class]]) {
        TTSURLRouteConfig *routeConfig = [TTSURLRouteConfig defaultRouteConfig];
        [@[kRouteResultNative, kRouteResultWeb, kRouteResultFile, kRouteResultSECWeb] enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
            NSMutableDictionary *oldDict = [routeConfig.p_routeDictionary[key] mutableCopy] ?: [NSMutableDictionary dictionary];
            NSDictionary *newDict = routeDictionary[key];
            if (newDict) {
                [oldDict addEntriesFromDictionary:newDict];
            }
            if (oldDict) {
                routeConfig.p_routeDictionary[key] = oldDict;
            }
        }];
    }
}

+ (void)addRouteWithPlistPath:(NSString *)path {
    if ([path isKindOfClass:[NSString class]]) {
        NSData *plistData = [NSData dataWithContentsOfFile:path];
        if (plistData) {
            NSDictionary *dictionary = [NSPropertyListSerialization propertyListWithData:plistData
                                                                                 options:NSPropertyListImmutable
                                                                                  format:nil
                                                                                   error:nil];
            [self addRouteDictionary:dictionary];
        }
        else {
            NSAssert(plistData, ([NSString stringWithFormat:@"%@文件不存在", path]));
        }
    }
}

+ (void)addRouteWithPlistPaths:(NSArray *)paths {
    [paths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addRouteWithPlistPath:obj];
    }];
}

+ (NSDictionary *)routeDictionary {
    TTSURLRouteConfig *routeConfig = [TTSURLRouteConfig defaultRouteConfig];
    NSDictionary *routeDictionary = [routeConfig.p_routeDictionary copy];
    return routeDictionary;
}

+ (void)registerURLRouteConfigClass:(Class<TTSURLRouteConfigDelegate>)configClass {
    NSAssert(configClass, ([NSString stringWithFormat:@"%@ Class：不存在", NSStringFromClass(configClass)]));
    TTSURLRouteConfig *routeConfig = [TTSURLRouteConfig defaultRouteConfig];
    routeConfig.configDelegate = configClass.new;
}

#pragma mark - get
- (NSMutableDictionary *)p_routeDictionary {
    return _p_routeDictionary ?: ({
        _p_routeDictionary = [NSMutableDictionary dictionary];
    });
}

@end
