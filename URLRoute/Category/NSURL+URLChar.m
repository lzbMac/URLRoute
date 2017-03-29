//
//  NSURL+URLChar.m
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//


#import "NSURL+URLChar.h"

NSString *const kURLRouteCharacherWebViewLogin = @"ttsneedlogin";

@implementation NSURL (URLChar)

#pragma mark -

- (BOOL)isRouteScheme {
    NSString *scheme = @"ttsclient";
    return [[self.scheme lowercaseString] isEqualToString:scheme];
}

- (BOOL)isNeedLogin {
    NSString *URLString = [self absoluteString];
    NSRange range = [URLString rangeOfString:kURLRouteCharacherWebViewLogin];
    return !(range.location == NSNotFound);
}

@end
