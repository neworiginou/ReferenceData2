//
//  HWAbtKalaCommunityFunctionIntroductionViewController.m
//  Community
//
//  Created by D on 14/12/10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWAbtKalaCommunityFunctionIntroductionViewController.h"

@interface HWAbtKalaCommunityFunctionIntroductionViewController ()

@end

@implementation HWAbtKalaCommunityFunctionIntroductionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"功能介绍"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    [self loadUI];
}

- (void)loadUI {
    NSString * str = @"懒人必备手机应用，致力于营造惬意生活，倡导“懒”是人类必备的生活便利。优选蔬果、餐饮、上门、周边便利店、家政保洁、干洗等服务，邻里二手交易、社区活动等，丰富的生活体验，动动手指轻松享。\n\n懒人有懒福！每天发红包，懒人的福利，开启懒人舒适赚钱新方式！\n\n懒得出门？社区公告、邻里八卦随时看，和周围的懒人做手机里的老朋友。\n\n懒得折腾？足不出户，吃喝玩乐送上门。从早餐到宵夜，周边美食任你点。";
    
    CGFloat height = [Utility calculateStringHeight:str font:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL] constrainedSize:CGSizeMake(kScreenWidth - 30, CGFLOAT_MAX)].height;
    
    UIScrollView * scroView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    scroView.contentSize = CGSizeMake(kScreenWidth, height);
    [self.view addSubview:scroView];
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, kScreenWidth - 30, height)];
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
