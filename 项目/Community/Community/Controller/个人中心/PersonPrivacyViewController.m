//
//  PersonPrivacyViewController.m
//  Community
//
//  Created by gusheng on 14-9-7.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "PersonPrivacyViewController.h"

@interface PersonPrivacyViewController ()
{
}
@end

@implementation PersonPrivacyViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//创建协议的视图
-(void)createPrivateTextView
{
    NSString *resPath = [[NSBundle mainBundle] pathForResource:@"隐私策略" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:resPath encoding:NSUTF8StringEncoding error:nil];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    [webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:resPath]];
    [self.view addSubview:webView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(back:)];
    self.view.backgroundColor = UIColorFromRGB(0xececec);
    self.navigationItem.titleView = [Utility navTitleView:@"隐私策略"];
    [self createPrivateTextView];
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
