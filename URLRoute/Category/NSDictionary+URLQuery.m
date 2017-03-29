//
//  NSDictionary+URLQuery.m
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "NSDictionary+URLQuery.h"

@implementation NSDictionary (URLQuery)
+ (instancetype)dictionaryWithURLQuery:(NSString *)query {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (query.length && [query rangeOfString:@"="].location != NSNotFound) {
        NSArray *keyValuePairs = [query componentsSeparatedByString:@"&"];
        for (NSString *keyValuePair in keyValuePairs) {
            NSArray *pair = [keyValuePair componentsSeparatedByString:@"="];
            NSString *paramValue = pair.count == 2 ? pair.lastObject : @"";
            parameters[pair.firstObject] = ({
                NSString *input = [paramValue stringByReplacingOccurrencesOfString:@"+" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, paramValue.length)];
                [input stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }) ?: @"";
        }
    }
    return parameters;
}
@end
