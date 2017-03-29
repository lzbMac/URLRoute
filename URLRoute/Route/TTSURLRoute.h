//
//  TTSURLRoute.h
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTSURLRouteResult;

typedef void (^TTSURLRouteCompleteBlock)(TTSURLRouteResult *result, NSDictionary *options);

@interface TTSURLRoute : NSObject

- (BOOL)routeWithURL:(NSURL *)URL options:(NSDictionary *)options completeblock:(TTSURLRouteCompleteBlock)completeBlock;
@end
