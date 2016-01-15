//
//  HWRentsIntentionVC.m
//  Community
//
//  Created by lizhongqiang on 14-9-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  功能描述：租售托管选择租售意向页面
//  修改记录：
//      李中强 2015-01-26 扩大按钮点击区域


#import "HWRentsIntentionVC.h"

@interface HWRentsIntentionVC ()
{
    NSArray *array;
    UIButton *oneBtn;
    UIButton *twoBtn;
    
}
@end

@implementation HWRentsIntentionVC
@synthesize delegate;
@synthesize phoneHistoryId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"租售托管"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"确定" action:@selector(btnNext:)];
    
    UILabel *labelTip = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth - 15 * 2, 21)];
    [labelTip setBackgroundColor:[UIColor clearColor]];
    [labelTip setText:@"欢迎使用租售托管服务，填写房屋信息申请，我们将为你保密所有信息"];
    [labelTip setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
    [labelTip setTextColor:THEME_COLOR_TEXT];
    [labelTip setNumberOfLines:0];
    [labelTip sizeToFit];
    [self.view addSubview:labelTip];
    
    UILabel *labelIntention = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, 150, 15)];
    [labelIntention setBackgroundColor:[UIColor clearColor]];
    [labelIntention setText:@"选择租售意向"];
    [labelIntention setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
    [labelIntention setTextColor:THEME_COLOR_TEXT];
    [self.view addSubview:labelIntention];
    
    array = [[NSArray alloc] initWithObjects:@"出租房屋",@"出售房屋", nil];
    for (int i = 0; i < 2; i ++)
    {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 94.5 + 55 * i, kScreenWidth, 0.5)];
        [line setBackgroundColor:THEME_COLOR_LINE];
        [self.view addSubview:line];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 95 + 55 * i, kScreenWidth, 45)];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:bgView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(19, 110 + 55 * i, 140, 18)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:[array objectAtIndex:i]];
        [label setTextColor:THEME_COLOR_SMOKE];
        [label setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
        [self.view addSubview:label];
        
        UIView *lineTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 140 + 55 * i, kScreenWidth, 0.5)];
        [lineTwo setBackgroundColor:THEME_COLOR_LINE];
        [self.view addSubview:lineTwo];
        
    }
    
    oneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    oneBtn.frame = CGRectMake(0, 105, kScreenWidth, 45);
    [oneBtn setImageEdgeInsets:UIEdgeInsetsMake(0, kScreenWidth - 45, 20, 20)];
    oneBtn.selected = YES;
    [oneBtn setImage:[UIImage imageNamed:@"kou"] forState:UIControlStateNormal];
    [oneBtn setImage:[UIImage imageNamed:@"gou"] forState:UIControlStateSelected];
    [oneBtn addTarget:self action:@selector(oneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:oneBtn];
    
    twoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [twoBtn setFrame:CGRectMake(0, 160, kScreenWidth, 45)];
    [twoBtn setImageEdgeInsets:UIEdgeInsetsMake(0, kScreenWidth - 45, 20, 20)];
    [twoBtn setImage:[UIImage imageNamed:@"kou"] forState:UIControlStateNormal];
    [twoBtn setImage:[UIImage imageNamed:@"gou"] forState:UIControlStateSelected];
    [twoBtn addTarget:self action:@selector(twoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twoBtn];
}


- (void)btnNext:(id)sender
{
    HWRentsData *rents = [HWRentsData getRentsData];
    
    if (oneBtn.selected)
    {
        rents.strIntention = @"出租房屋";
    }
    else
    {
        rents.strIntention = @"出售房屋";
    }
    
    //判断跳转
    if ([self.superVC isKindOfClass:[HWHouseSaleRentsVC class]])
    {
        [delegate getRentsIntention];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        HWRentsPeopleInfoVC *peopleInfo = [[HWRentsPeopleInfoVC alloc] init];
        peopleInfo.rootVC = self.rootVC;
        peopleInfo.phoneHistoryId = self.phoneHistoryId;
        [self.navigationController pushViewController:peopleInfo animated:YES];
    }
    
}


- (void)oneBtnClick:(id)sender
{
    [MobClick event:@"click_rent_house"];
    if (oneBtn.selected == YES)
    {
        oneBtn.selected = NO;
        twoBtn.selected = YES;
    }
    else
    {
        oneBtn.selected = YES;
        twoBtn.selected = NO;
    }
    
    
}

- (void)twoBtnClick:(id)sender
{
    [MobClick event:@"click_sell_house"];
    if (twoBtn.selected == YES)
    {
        twoBtn.selected = NO;
        oneBtn.selected = YES;
    }
    else
    {
        twoBtn.selected = YES;
        oneBtn.selected = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
