//
//  TTWebPageHold.m
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/30.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TTSWebPageHold.h"
#import "TTSURLRouteKit.h"
#import "TTSWebViewController.h"


@interface TTSWebPageHold()<TTSURLRouteHoldProtocol>

@end
@implementation TTSWebPageHold

- (void)holdWithParameters:(NSDictionary *)parameters {
    UIViewController *lastVc = parameters[kRouteHoldLastViewController];
    NSDictionary *paramDict = parameters[kRouteHoldParameter];
    TTSWebViewController *vc = [[TTSWebViewController alloc] init];
    NSString *url = paramDict[kRouteOriginalURLString];
    vc.urlString = url;
    [lastVc.navigationController pushViewController:vc animated:YES];
}
@end
