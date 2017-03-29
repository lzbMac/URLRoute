//
//  IndexSearchViewController.m
//  URLRoute_Demo
//
//  Created by 李正兵 on 2017/3/28.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "IndexSearchViewController.h"
#import "TTSURLRouteKit.h"

@interface IndexSearchViewController ()

@end

@implementation IndexSearchViewController
{
    UIColor *_bgColor;
    NSString *_navTitle;
}
- (void)routeWillPushControllerWithParam:(NSDictionary *)param{
    NSString *color = param[@"color"];
    _navTitle = param[@"title"];
    if ([color isEqualToString:@"1"]) {
        _bgColor = [UIColor redColor];
    }else if ([color isEqualToString:@"2"]) {
        _bgColor = [UIColor greenColor];
    }else {
        _bgColor = [UIColor whiteColor];
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self routeCallBack:@{@"page":@"search"}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view .backgroundColor = _bgColor;
    self.title = _navTitle;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
