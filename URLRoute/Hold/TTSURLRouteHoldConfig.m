//
//  TTSURLRouteHoldConfig.m
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TTSURLRouteHoldConfig.h"

NSString * const kRouteHoldLastViewController = @"TTSURLRouteHoldLastViewController";
NSString * const kRouteHoldViewController = @"kRouteHoldViewController";
NSString * const kRouteHoldParameter = @"kRouteHoldParameter";

@interface TTSURLRouteHoldConfig ()

@property (nonatomic, strong) id<TTSURLRouteHoldLoginDelegate> loginDelegate;

@end
@implementation TTSURLRouteHoldConfig

+ (instancetype)defaultHoldConfig {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = self.new;
    });
    return instance;
}

+ (void)registerURLRouteHoldLoginClass:(Class<TTSURLRouteHoldLoginDelegate>)loginClass {
    id<TTSURLRouteHoldLoginDelegate> login = loginClass.new;
    [TTSURLRouteHoldConfig defaultHoldConfig].loginDelegate = login;
}
@end
