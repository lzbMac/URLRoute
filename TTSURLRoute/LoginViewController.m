//
//  LoginViewController.m
//  URLRoute_Demo
//
//  Created by 李正兵 on 2017/3/28.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
{
    void(^loginBlock)(BOOL isLogin);
}
- (void)startLoginWithSuccessBlock:(void(^)(BOOL isLogin))block options:(NSDictionary *)options {
    loginBlock = block;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)back:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)login:(id)sender {
    loginBlock(YES);
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
