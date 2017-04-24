//
//  ViewController.m
//  URLRoute_Demo
//
//  Created by 李正兵 on 2017/3/28.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "ViewController.h"
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
    btn2.frame = CGRectMake(20, 200, 200, 50);
    [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(gotosearch:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"Search（登录拦截）" forState:UIControlStateNormal];
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
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(20, 500, 100, 50);
    [btn5 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(gotoH5) forControlEvents:UIControlEventTouchUpInside];
    [btn5 setTitle:@"web页面" forState:UIControlStateNormal];
    [self.view addSubview:btn5];
    
}
- (IBAction)gotohome:(id)sender {
    [self openRouteURLString:@"ttsclient://index/home?content=车之翼&title=首页" options:nil];
}

- (IBAction)gotosearch:(id)sender {
    [self openRouteURLString:@"ttsclient://index/search?app=天天爱车&title=搜索" options:nil];
}
- (void)login:(id)sender {
    [self openLoginWithCompletion:^(BOOL isLogin, NSDictionary *options) {
        NSLog(@"登录完成---------");
    }];

}

- (void)gotoH5 {
    //    [self openRouteURLString:@"http://www.baidu.com" options:nil];
    [self openRouteURLString:@"https://www.baidu.com" options:nil];
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
