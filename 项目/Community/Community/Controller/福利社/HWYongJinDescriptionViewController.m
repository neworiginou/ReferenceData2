//
//  HWYongJinDescriptionViewController.m
//  Community
//
//  Created by niedi on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：佣金说明页面
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪          2015-1-16                 创建文件
//      吴晓红        2015-1-17                  文案修改
//      杨庆龙        2015-1-26                 电话可以点击

#import "HWYongJinDescriptionViewController.h"
#import "RTLabel.h"
@interface HWYongJinDescriptionViewController ()<RTLabelDelegate>

@end

@implementation HWYongJinDescriptionViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.titleView = [Utility navTitleView:@"佣金说明"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    [self initView];
}

-(void)initView
{
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth - 30, 15)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.textColor = THEME_COLOR_TEXT;
    titleLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    titleLab.text = @"佣金收益说明:";
    [self.view addSubview:titleLab];
    
    NSString * str = @"1. 佣金：由激活提成与有效消费分成两部分组成\n2. 激活提成：玩家通过推广链接首次下载并且成功打开游戏，可以获得考拉币或者人民币\n3. 有效消费：玩家在游戏中的付费\n4. 佣金结算：有考拉币和人民币两种方式结算方式\n5. 结算方式：佣金实时发放至个人钱包，由于系统原因可能延迟几分钟到账\n6. 如遇到问题可以拨打客服电话:<a href='400-180-8116'><u>400-180-8116</u></a>（9:00-17:30 节假日除外）咨询";
    
    
    RTLabel * lab = [[RTLabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLab.frame) + 3, kScreenWidth - 30,  400)];
    lab.delegate = self;
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = THEME_COLOR_TEXT;
    lab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [lab setText:str];
    lab.linkAttributes = @{@"color":@"#8acf1c",@"underline":@"#8acf1c"};
    lab.selectedLinkAttributes = @{@"color":@"#77b218",@"underline":@"#77b218"};
    [self.view addSubview:lab];
}

- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL *)url
{
    UIWebView *callView = [[UIWebView alloc]init];
    [self.view addSubview:callView];
    NSURL *urlStr = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",url]];
    [callView loadRequest:[NSURLRequest requestWithURL:urlStr]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
