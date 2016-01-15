//
//  HWOrderTimeVC.m
//  Community
//
//  Created by lizhongqiang on 14-9-3.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  预约物业上门时间

#import "HWOrderTimeVC.h"

@interface HWOrderTimeVC ()
{
    NSArray *arrTime;
    
}
@end

@implementation HWOrderTimeVC
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnSure
{
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:1000];
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:1001];
    UIButton *btn3 = (UIButton *)[self.view viewWithTag:1002];
    
    NSString *strTime;
    if (btn1.selected == YES)
    {
        strTime = [arrTime objectAtIndex:btn1.tag - 1000];
    }
    else if (btn2.selected == YES)
    {
        strTime = [arrTime objectAtIndex:btn2.tag - 1000];
    }
    else if (btn3.selected == YES)
    {
        strTime = [arrTime objectAtIndex:btn3.tag - 1000];
    }
    strTime = [NSString stringWithFormat:@"%@上门",strTime];
    HWOrderData *order = [HWOrderData getOrderData];
    order.time = strTime;
    [delegate getOrderTime];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Utility navTitleView:@"物业上门"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(back:)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"确定" action:@selector(btnSure)];
    
    
    UILabel *labTip = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth - 30, 21)];
    [labTip setBackgroundColor:[UIColor clearColor]];
    [labTip setText:@"请选择期望上门时间"];
    [labTip setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
    [labTip setTextColor:THEME_COLOR_TEXT];
    [self.view addSubview:labTip];
    
    arrTime = [NSArray arrayWithObjects:@"工作日晚间",@"双休日全天",@"任何时间", nil];
    NSArray *arrNormal = [[NSArray alloc] initWithObjects:@"night",@"daytime",@"anytime", nil];
    NSArray *arrSelected = [[NSArray alloc] initWithObjects:@"night_sel",@"daytime_sel",@"anytime_sel", nil];
    CGFloat colWidth = kScreenWidth / 3;
    for (int i = 0; i < [arrTime count]; i ++)
    {
        UIButton *btnTime = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnTime setFrame:CGRectMake(24 + colWidth * i, 60, 59, 59)];
        [btnTime setBackgroundColor:[UIColor clearColor]];
        [btnTime setBackgroundImage:[UIImage imageNamed:[arrNormal objectAtIndex:i]] forState:UIControlStateNormal];
        [btnTime setBackgroundImage:[UIImage imageNamed:[arrSelected objectAtIndex:i]] forState:UIControlStateSelected];
        [btnTime setTag:i + 1000];
        if (i == 0)
        {
            btnTime.selected = YES;
        }
        [btnTime addTarget:self action:@selector(btnTimeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnTime];
        
        //24 24 checkTime
        UIImageView *imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(24 + 36 + colWidth * i, 60 + 35, 24, 24)];
        [imgIcon setBackgroundColor:[UIColor clearColor]];
        [imgIcon setImage:[UIImage imageNamed:@"checkTime"]];
        [imgIcon setTag:i + 100];
        if (i != 0)
        {
            imgIcon.hidden = YES;
        }
        [self.view addSubview:imgIcon];
        
        UILabel *labelTime = [[UILabel alloc] initWithFrame:CGRectMake(18 + colWidth * i, 60 + 70, 80, 21)];
        [labelTime setBackgroundColor:[UIColor clearColor]];
        [labelTime setText:arrTime[i]];
        [labelTime setTextAlignment:NSTextAlignmentCenter];
        [labelTime setTextColor:THEME_COLOR_TEXT];
        if (i == 0)
        {
            [labelTime setTextColor:[UIColor blackColor]];
        }
        [labelTime setTag:i + 10];
        [labelTime setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
        [self.view addSubview:labelTime];
        
    }
    
}

- (void)btnTimeClick:(id)sender
{
//    for (UIView *view in self.view.subviews) {
//        if (view.tag == 999) {
//            
//        }else{
//            
//        }
//    }
    //点击的是哪个？其他都变相反色
    UIButton *currentBtn = (UIButton *)sender;
    NSInteger index = currentBtn.tag;
    
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:1000];
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:1001];
    UIButton *btn3 = (UIButton *)[self.view viewWithTag:1002];
    
    UIImageView *img1 = (UIImageView *)[self.view viewWithTag:100];
    UIImageView *img2 = (UIImageView *)[self.view viewWithTag:101];
    UIImageView *img3 = (UIImageView *)[self.view viewWithTag:102];
    
    UILabel *label1 = (UILabel *)[self.view viewWithTag:10];
    UILabel *label2 = (UILabel *)[self.view viewWithTag:11];
    UILabel *label3 = (UILabel *)[self.view viewWithTag:12];
    
    if (index == btn1.tag)
    {
        [MobClick event:@"click_weekdays_night"];
        btn1.selected = YES;
        btn2.selected = NO;
        btn3.selected = NO;
        img1.hidden = NO;
        img2.hidden = YES;
        img3.hidden = YES;
        label1.textColor = THEME_COLOR_SMOKE;
        label2.textColor = THEME_COLOR_TEXT;
        label3.textColor = THEME_COLOR_TEXT;
    }
    else if (index == btn2.tag)
    {
        [MobClick event:@"click_weekends_day"];
        btn2.selected = YES;
        btn1.selected = NO;
        btn3.selected = NO;
        img2.hidden = NO;
        img1.hidden = YES;
        img3.hidden = YES;
        label2.textColor = THEME_COLOR_SMOKE;
        label1.textColor = THEME_COLOR_TEXT;
        label3.textColor = THEME_COLOR_TEXT;
    }
    else if (index == btn3.tag)
    {
        [MobClick event:@"click_anytime"];
        btn3.selected = YES;
        btn1.selected = NO;
        btn2.selected = NO;
        img3.hidden = NO;
        img1.hidden = YES;
        img2.hidden = YES;
        label3.textColor = THEME_COLOR_SMOKE;
        label1.textColor = THEME_COLOR_TEXT;
        label2.textColor = THEME_COLOR_TEXT;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
