//
//  NSDictionary+URLQuery.h
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (URLQuery)
/**
 *  根据URL.query查询参数的值
 *
 *  @param query URL.query
 *
 *  @return dictionary
 */
+ (instancetype)dictionaryWithURLQuery:(NSString *)query;

@end
