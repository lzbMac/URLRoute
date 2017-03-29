//
//  NSURL+URLWithStringEncode.m
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "NSURL+URLWithStringEncode.h"
#import "NSDictionary+URLQuery.h"
#import "NSString+URLCode.h"
#import <objc/runtime.h>

@implementation NSURL (URLWithStringEncode)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        const char* class_name = class_getName([self class]);
        Class metaClass = objc_getMetaClass(class_name);
        
        SEL originalSelector = @selector(URLWithString:);
        SEL newSelector = @selector(p_URLWithString:);
        
        Method originalMethod = class_getInstanceMethod(metaClass, originalSelector);
        Method newMethod = class_getInstanceMethod(metaClass, newSelector);
        
        BOOL methodAdded = class_addMethod([metaClass class],
                                           originalSelector,
                                           method_getImplementation(newMethod),
                                           method_getTypeEncoding(newMethod));
        
        if (methodAdded) {
            class_replaceMethod([metaClass class],
                                newSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        }
        else {
            method_exchangeImplementations(originalMethod, newMethod);
        }
    });
}

+ (instancetype)p_URLWithString:(NSString *)URLString {
    NSURL *url = [NSURL p_URLWithString:URLString];
    if (!url) {
        NSArray *markArray = [URLString componentsSeparatedByString:@"?"];
        if (markArray.count == 2) {
            NSString *query = markArray.lastObject;
            NSDictionary *dict = [NSDictionary dictionaryWithURLQuery:query];
            NSMutableString *aParameter = [NSMutableString string];
            [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [aParameter appendFormat:@"%@=%@&", key, [obj URLEncodedString]];
            }];
            [aParameter deleteCharactersInRange:NSMakeRange([aParameter length] - 1, 1)];
            NSString *newURLString = [NSString stringWithFormat:@"%@?%@", markArray.firstObject, aParameter];
            return [NSURL p_URLWithString:newURLString];
        }
    }
    return url;
}

@end
