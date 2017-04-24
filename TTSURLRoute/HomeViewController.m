//
//  HomeViewController.m
//  URLRoute_Demo
//
//  Created by 李正兵 on 2017/3/28.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "HomeViewController.h"
#import "TTSURLRouteKit.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
{
    NSString *_content;
    NSString *_navTitle;
    __weak IBOutlet UILabel *lblContent;
}
- (void)routeWillPushControllerWithParam:(NSDictionary *)param{
    _content = param[@"content"];
    _navTitle = param[@"title"];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self routeCallBack:@{@"page":@"home"}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _navTitle;
    lblContent.text = _content;
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
