//
//  IndexSearchHold.m
//  URLRoute_Demo
//
//  Created by 李正兵 on 2017/3/28.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "IndexSearchHold.h"
#import "IndexSearchViewController.h"
#import "TTSURLRouteKit.h"

@implementation IndexSearchHold

- (void)holdWithParameters:(NSDictionary *)parameters {
    UIViewController *lastVc = parameters[kRouteHoldLastViewController];
    IndexSearchViewController *vc = [IndexSearchViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.routeCallBackViewController = lastVc;
    [lastVc.navigationController pushViewController:vc animated:YES];
}
@end
