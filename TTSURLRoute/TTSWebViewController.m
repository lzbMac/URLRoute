//
//  TTSWebViewController.m
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/30.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TTSWebViewController.h"
#import "TTSURLRouteKit.h"

@interface TTSWebViewController ()<TTSURLRoutePushProtocol>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TTSWebViewController

- (void)routeWillPushControllerWithParam:(NSDictionary *)param {
    self.urlString = param[kRouteOriginalURLString];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSURL *url = [NSURL URLWithString:self.urlString];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
