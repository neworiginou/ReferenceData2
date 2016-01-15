//
//  CustomerProtocolViewController.m
//  Community
//
//  Created by gusheng on 14-9-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "CustomerProtocolViewController.h"

@interface CustomerProtocolViewController ()
{
}
@end

@implementation CustomerProtocolViewController
@synthesize textView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(back:)];
    if (IOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = UIColorFromRGB(0xececec);
    self.navigationItem.titleView = [Utility navTitleView:@"用户协议"];
    [self createProtocalTextView];
    
}
//创建协议的视图
-(void)createProtocalTextView
{
    
    NSString *resPath = [[NSBundle mainBundle] pathForResource:@"用户注册协议" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:resPath encoding:NSUTF8StringEncoding error:nil];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    [webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:resPath]];
    [self.view addSubview:webView];
}
//返回上一级
-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
