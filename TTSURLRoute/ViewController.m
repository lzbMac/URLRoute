//
//  ViewController.m
//  URLRoute_Demo
//
//  Created by 李正兵 on 2017/3/28.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "IndexSearchViewController.h"
#import "TTSURLRouteKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(20, 84, 100, 50);
    [btn1 addTarget:self action:@selector(gotohome:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"Home" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(20, 200, 100, 50);
    [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(gotosearch:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"Search" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(20, 300, 100, 50);
    [btn3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitle:@"login" forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(200, 300, 180, 50);
    [btn4 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(cancleLogin) forControlEvents:UIControlEventTouchUpInside];
    [btn4 setTitle:@"点这里取消登录" forState:UIControlStateNormal];
    [self.view addSubview:btn4];
    
}
- (IBAction)gotohome:(id)sender {
    [self openRouteURLString:@"ttsclient://index/home?color=1&title=首页" options:nil];
}

- (IBAction)gotosearch:(id)sender {
    [self openRouteURLString:@"ttsclient://index/search?color=2&title=搜索" options:nil];
}
- (void)login:(id)sender {
    [self openLoginWithCompletion:^(BOOL isLogin, NSDictionary *options) {
        NSLog(@"登录完成---------");
    }];
}
- (void)routeCallBackWithParam:(NSDictionary *)callback {
    NSLog(@"这里是回调a---%@",callback);
}
- (void)cancleLogin{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已取消登录！" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"login_flag"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
