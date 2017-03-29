//
//  TTSRouteScheme.h
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTSRouteScheme : NSObject

@property (nonatomic, strong, readonly) NSURL *originalURL;
@property (nonatomic, strong, readonly) NSURL *useableURL;
@property (nonatomic, strong, readonly) NSString *query;
@property (nonatomic, strong, readonly) NSString *scheme;           //规则
@property (nonatomic, strong, readonly) NSString *module;           //模块
@property (nonatomic, strong, readonly) NSString *page;             //页面
@property (nonatomic, strong, readonly) NSDictionary *parameter;    //参数

- (instancetype)initWithURL:(NSURL *)URL;

+ (BOOL)isStandardURL:(NSURL *)url;
@end
