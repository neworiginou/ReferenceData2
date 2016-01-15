//
//  HWAbtKalaCommunityProductIntroductionViewController.m
//  Community
//
//  Created by D on 14/12/10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWAbtKalaCommunityProductIntroductionViewController.h"

@interface HWAbtKalaCommunityProductIntroductionViewController ()

@end

@implementation HWAbtKalaCommunityProductIntroductionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"产品简介"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    [self loadUI];
}

- (void)loadUI {
    NSString * str = @"考拉社区是一款小区生活服务的移动端应用，是好屋中国2014年度又一创新产品。倡导“懒”文化，以舒适、便捷为初衷，为有理想、有态度、有智慧的懒人带来品质与轻松兼得的生活体验。\n\n考拉社区带来物业、餐饮、家政等多重服务，天天为懒人发红包福利，并提供邻里在线交流互动平台，随时共享信息。 总之，在这里，你可以懒一点。";
    
    CGFloat height = [Utility calculateStringHeight:str font:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG] constrainedSize:CGSizeMake(kScreenWidth - 30, CGFLOAT_MAX)].height;
    
    UIScrollView * scroView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    scroView.contentSize = CGSizeMake(kScreenWidth, height);
    [self.view addSubview:scroView];
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 18, kScreenWidth - 30, height)];
    lab.textColor = THEME_COLOR_SMOKE;
    lab.text = str;
    lab.numberOfLines = 0;
    lab.lineBreakMode = NSLineBreakByCharWrapping;
    lab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [scroView addSubview:lab];
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
