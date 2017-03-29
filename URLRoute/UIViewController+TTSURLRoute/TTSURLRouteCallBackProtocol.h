//
//  TTSURLRouteCallBackProtocol.h
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TTSURLRouteCallBackProtocol <NSObject>

@optional

/**
 *  route回调数据，A->URLRoute[->Hold]->B，则A需要实现
 *
 *  @param callback B页面回传的数据
 */
- (void)routeCallBackWithParam:(NSDictionary *)callback;

@end
