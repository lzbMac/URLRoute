//
//  TTSURLRouteHold.h
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTSURLRouteResult.h"
#import "TTSURLRouteHoldProtocol.h"

typedef void (^TTSURLRouteHoldCompleteBlock)(TTSURLRouteResult *result, NSDictionary *options);
@interface TTSURLRouteHold : NSObject

@property (nonatomic, assign) BOOL wantLogin;
@property (nonatomic, strong) NSArray *checkKeys;
@property (nonatomic, strong) NSArray *passKeys;
@property (nonatomic, strong) NSString *holdController;

- (void)dealHoldWithRouteResult:(TTSURLRouteResult *)routeResult completeBlock:(TTSURLRouteHoldCompleteBlock)completeBlock;

@end
