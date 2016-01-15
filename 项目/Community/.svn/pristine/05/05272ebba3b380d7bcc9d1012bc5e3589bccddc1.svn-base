//
//  HWActivityViewController.m
//  Community
//
//  Created by zhangxun on 14-9-25.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWActivityViewController.h"

@interface HWActivityViewController ()<UIWebViewDelegate>

@end

@implementation HWActivityViewController

- (id)initWithURL:(NSString *)url{
    self = [super init];
    if (self) {
        _activityURL = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(doBack)];
    self.navigationItem.titleView = [Utility navTitleView:@"活动详情"];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    webView.scrollView.scrollsToTop = NO;
    [self.view addSubview:webView];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_activityURL]]];
    
    
}

- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [Utility showMBProgress:webView message:@"加载中"];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [Utility hideMBProgress:webView];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [Utility hideMBProgress:webView];
    [Utility showToastWithMessage:error.localizedDescription inView:webView];
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
