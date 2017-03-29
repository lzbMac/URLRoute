//
//  TTSURLRouteHoldConfig.h
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <Foundation/Foundation.h>
/** options的一些KEY */
extern NSString * const kRouteHoldLastViewController;   //堆栈的最后一个页面控制器
extern NSString * const kRouteHoldViewController;       //URL生成的ViewController
extern NSString * const kRouteHoldParameter;            //URL生成的属性参数

@protocol TTSURLRouteHoldLoginDelegate <NSObject>

/**
 *  注册登录的类需要实现的协议方法
 *
 *  @param block  isLogin判断登录还是失败
 */
- (void)startLoginWithSuccessBlock:(void(^)(BOOL isLogin))block options:(NSDictionary *)options;

@end

@interface TTSURLRouteHoldConfig : NSObject

/**
 *  注册登录协议，由URLRoute默认实现
 *
 *  @param loginClass Hold登录类，类需实现TTSURLRouteHoldLoginDelegate协议
 */
+ (void)registerURLRouteHoldLoginClass:(Class<TTSURLRouteHoldLoginDelegate>)loginClass;



@end
