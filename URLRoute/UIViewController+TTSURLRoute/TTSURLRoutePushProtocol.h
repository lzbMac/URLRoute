//
//  TTSURLRoutePushProtocol.h
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TTSURLRoutePushProtocol <NSObject>

@optional

/**
 *  url路由跳转时，对viewcontroller进行数据配置
 *
 *  @param param 传入的url字典数据，包括处理后url的key： kRouteConfigureFormatUrlKey 以及页面具体参数
 */
- (void)routeWillPushControllerWithParam:(NSDictionary *)param;

/**
 *  页面push跳转后调用
 *
 *  @param param 传入的url字典数据，包括处理后url的key： kRouteConfigureFormatUrlKey 以及页面具体参数
 */
- (void)routeDidPushControllerWithParam:(NSDictionary *)param;

@end
