//
//  HWApplicationDetailViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWApplicationDetailViewController.h"

@interface HWApplicationDetailViewController ()<UIWebViewDelegate>

@end

@implementation HWApplicationDetailViewController
@synthesize appUrl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
        
    if (![self.appUrl hasPrefix:@"http://"])
    {
        self.appUrl = [NSString stringWithFormat:@"http://%@",self.appUrl];
   
    }
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.appUrl]]];
    webView.delegate = self;
    [self.view addSubview:webView];
    [Utility showMBProgress:webView message:@"加载中"];

    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [Utility hideMBProgress:webView];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [Utility hideMBProgress:webView];
    if([error code] == NSURLErrorCancelled)
    {
        return;
    }
//    [Utility showAlertWithMessage:error.localizedDescription];
    [Utility showToastWithMessage:@"网络连接错误" inView:webView];
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
