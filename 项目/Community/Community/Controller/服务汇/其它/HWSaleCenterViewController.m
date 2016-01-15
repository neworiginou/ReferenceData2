//
//  HWSaleCenterViewController.m
//  Community
//
//  Created by lizhongqiang on 15/4/17.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWSaleCenterViewController.h"
#import "WebViewJavascriptBridge.h"

@interface HWSaleCenterViewController ()<UIWebViewDelegate>
@property WebViewJavascriptBridge* bridge;
@end

@implementation HWSaleCenterViewController
@synthesize strUrl;

//- (void)viewWillAppear:(BOOL)animated
//{
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
//    self.navigationItem.titleView = [Utility navTitleView:@"租售中心"];
//    
//    UIWebView *saleWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    
//    [self.view addSubview:saleWeb];
    [self.view setBackgroundColor:THEME_COLOR_TEXTBACKGROUND];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    if (IOS7)
//    {
//        saleWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT + 64)];
//    }
//    else
//    {
        saleWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, CONTENT_HEIGHT + 64 - 20)];
//    }
    saleWeb.delegate = self;
    [saleWeb.scrollView setScrollEnabled:NO];
    [self.view addSubview:saleWeb];
    
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:saleWeb webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        NSLog(@"testObjcCallback called: %@", data);
        if ([data isEqualToString:@"exit"])
        {
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            [self.navigationController popViewControllerAnimated:YES];
        }
//        responseCallback(@"Response for message from ObjC");
    }];
    
    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback)
     {
         NSLog(@"testObjcCallback called: %@", data);
         if ([data isEqualToString:@"exit"])
         {
             [self.navigationController popViewControllerAnimated:YES];
         }
     }];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.strUrl]];
    [saleWeb loadRequest:request];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    [Utility showMBProgress:self.view message:@"加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [Utility hideMBProgress:self.view];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    [Utility hideMBProgress:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
