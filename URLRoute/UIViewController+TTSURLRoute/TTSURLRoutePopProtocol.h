//
//  TTSURLRoutePopProtocol.h
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const URLRouteVersion;

@protocol TTSURLRoutePopProtocol <NSObject>

@optional

/**
 *  使用url路由返回时，对viewcontroller进行数据配置
 *
 *  @param param 传入的url字典数据，包括页面具体参数
 */
- (void)routePopOutWithParam:(NSDictionary *)param;
@end
