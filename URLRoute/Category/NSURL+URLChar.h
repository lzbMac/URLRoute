//
//  NSURL+URLChar.h
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//
/*1、此处判断功能可以根据项目需求添加
 *2、添加时，务必写清楚注释
 */
#import <Foundation/Foundation.h>

@interface NSURL (URLChar)

/** scheme是否为ttsclient */
- (BOOL)isRouteScheme;
/** 是否包含需要登录 */
- (BOOL)isNeedLogin;

@end
