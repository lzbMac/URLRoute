//
//  TTSURLBridge.h
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTSURLBridge : NSObject

/**
 *  自定义生成URL规则
 *
 *  @param module    模块
 *  @param page      页面
 *  @param parameter 参数
 *
 *  @return URL2.0规则
 */
+ (NSURL *)routeURLWithModule:(NSString *)module page:(NSString *)page parameter:(NSDictionary *)parameter;

@end
