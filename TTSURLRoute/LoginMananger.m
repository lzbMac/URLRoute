//
//  LoginMananger.m
//  URLRoute_Demo
//
//  Created by 李正兵 on 2017/3/28.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "LoginMananger.h"
#import "LoginViewController.h"

@implementation LoginMananger
- (void)startLoginWithSuccessBlock:(void(^)(BOOL isLogin))block options:(NSDictionary *)options {
    UIViewController *lastViewController = options[kRouteHoldLastViewController];
    LoginViewController* login = [[LoginViewController alloc] init];

    [login startLoginWithSuccessBlock:block options:options];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
    [lastViewController.navigationController presentViewController:nav animated:YES completion:nil];
    

}

@end
