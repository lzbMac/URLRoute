//
//  LoginViewController.h
//  URLRoute_Demo
//
//  Created by 李正兵 on 2017/3/28.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

- (void)startLoginWithSuccessBlock:(void(^)(BOOL isLogin))block options:(NSDictionary *)options;
@end
