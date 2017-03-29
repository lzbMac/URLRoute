//
//  UIViewController+TTSURLRouteCallBack.h
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <UIKit/UIKit.h>
/** B -> A参数中包含B的class，告诉A回调来源类 */
extern NSString *TTSURLRouteCallBackSourceClass;

@interface UIViewController (TTSURLRouteCallBack)

/** 需要回调的ViewController
 *  A->URLRoute->B，默认会设置B的routeCallBackViewController为A
 *  A->URLRoute->Hold->B，需在Hold中设置B routeCallBackViewController为A
 *  A需要实现 TTSURLRouteCallBackProtocol
 */
@property (nonatomic, weak) UIViewController *routeCallBackViewController;

/**
 *  route回调数据，A->URLRoute[->Hold]->B，则B在需要传参数给A时调用
 *
 *  @param callback 传给A的数据，可能包含TTSURLRouteCallBackSourceClass参数
 */
- (void)routeCallBack:(NSDictionary *)callback;

@end
