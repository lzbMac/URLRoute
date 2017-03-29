//
//  UIViewController+TTSURLRouteCallBack.m
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "UIViewController+TTSURLRouteCallBack.h"
#import <objc/runtime.h>
#import "TTSURLRouteCallBackProtocol.h"

NSString *TTSURLRouteCallBackSourceClass = @"TTSURLRouteCallBackSourceClass";

@implementation UIViewController (TTSURLRouteCallBack)

- (UIViewController *)routeCallBackViewController {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setRouteCallBackViewController:(UIViewController *)routeCallBackViewController {
    objc_setAssociatedObject(self, @selector(routeCallBackViewController), routeCallBackViewController, OBJC_ASSOCIATION_ASSIGN);
}

//B页面调用，将callback数据给前一个页面
- (void)routeCallBack:(NSDictionary *)callback {
    UIViewController *lastViewController = self.routeCallBackViewController;
    if ([lastViewController respondsToSelector:@selector(routeCallBackWithParam:)]) {
        [(UIViewController<TTSURLRouteCallBackProtocol> *)lastViewController routeCallBackWithParam:callback];
    }
}
@end
