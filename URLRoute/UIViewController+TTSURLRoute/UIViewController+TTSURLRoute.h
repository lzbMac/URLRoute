//
//  UIViewController+TTSURLRoute.h
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TTSURLRoutePopProtocol.h"
#import "TTSURLRoutePushProtocol.h"

/** URL规则处理失败 */
extern NSString * const TTSURLRouteHandleErrorNotification;
/** URL规则处理完成 */
extern NSString * const TTSURLRouteHandleCompleteNotification;

typedef void(^TTSURLRouteOpenCompletion)(void); //->kURLRouteOpenCompletion
typedef void(^TTSURLRouteOpenLoginCompletionBlock)(BOOL isLogin, NSDictionary *options);

extern NSString *const kURLRouteOpenAnimated;           //是否需要动画，默认@YES
extern NSString *const kURLRouteOpenAnimatedTransition; //动画形式，默认@(URLRouteOpenAnimatedPush)
extern NSString *const kURLRouteOpenCompletion;         //完成后回调操作，默认nil

typedef NS_ENUM(NSUInteger, URLRouteOpenAnimatedTransition) {
    URLRouteOpenAnimatedPush,
    URLRouteOpenAnimatedPresent
};

@interface UIViewController (TTSURLRoute)<TTSURLRoutePopProtocol,TTSURLRoutePushProtocol>

/**
 根据URL打开页面

 @param aString urlString 例如：scheme://module/page[?][key=value&key=value]
 @param options 自定义kURLRouteOpen参数
 */
- (void)openRouteURLString:(NSString *)aString options:(NSDictionary *)options;

/**
 *  打开登录
 *
 *  @param completion 登录完成后调用completion & 已登录直接调用completion
 */
- (void)openLoginWithCompletion:(TTSURLRouteOpenLoginCompletionBlock)completion;
@end

@interface UIViewController (TTSURLRouteHoldObject)

/**
 *  维持处理Hold的对象的生命周期
 *  需要重新获取则使用NSDictionary
 *  只需要位置使用NSArray
 *  默认NSObject
 */
@property (nonatomic, strong) id holdObject;

@end

