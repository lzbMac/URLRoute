//
//  TTSURLBridge.m
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TTSURLBridge.h"

@implementation TTSURLBridge
+ (NSURL *)routeURLWithModule:(NSString *)module page:(NSString *)page parameter:(NSDictionary *)parameter {
    NSMutableString *paramString = [NSMutableString string];
    [parameter enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [paramString appendFormat:@"%@=%@&", key, obj];
    }];
    NSString *param = [paramString substringToIndex:(paramString.length-1)];    //去掉最后一位&
    NSString *URLString = [NSString stringWithFormat:@"%@://%@/%@?%@", @"ttsclient", module, page, param];
    return [NSURL URLWithString:URLString];
}
@end
