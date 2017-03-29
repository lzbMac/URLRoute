//
//  TTSRouteResult.h
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIViewController;

extern NSString * const kRouteResultLastViewController;
extern NSString * const kRouteResultUseableURL;
extern NSString * const kRouteResultOriginalURL;
extern NSString * const kRouteOriginalURLString;

typedef NS_ENUM(NSUInteger, TTSURLRouteOpenType) {
    URLRouteOpenUndefine,
    URLRouteOpenWeb,
    URLRouteOpenNative,
    URLRouteOpenExternal
};
@interface TTSURLRouteResult : NSObject

@property (nonatomic, assign, readonly) TTSURLRouteOpenType openType;

/** 将要打开的页面控制器 */
@property (nonatomic, strong) UIViewController *viewController;
/** 上一个页面控制器 */
@property (nonatomic, strong) UIViewController *lastViewController;
/** 代理给页面控制器的参数 */
@property (nonatomic, strong) NSDictionary *parameter;

/** 根据TTSRouteScheme.scheme初始化Result，生成openType */
- (instancetype)initWithScheme:(NSString *)scheme;

@end
