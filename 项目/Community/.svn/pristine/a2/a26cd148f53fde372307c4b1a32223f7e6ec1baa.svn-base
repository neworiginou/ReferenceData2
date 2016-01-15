//
//  HWRentsAdvantageVC.m
//  Community
//
//  Created by lizhongqiang on 14-9-17.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWRentsAdvantageVC.h"

@interface HWRentsAdvantageVC ()

@end

@implementation HWRentsAdvantageVC

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
    
    
    self.navigationItem.titleView = [Utility navTitleView:@"服务优势"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    UIFont *bigFont = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    UIFont *smallFont = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    NSArray *bigArray = [[NSArray alloc] initWithObjects:@"无骚扰，更省心",@"手续费用少",@"成交容易", nil];
    NSArray *smallArray = [[NSArray alloc] initWithObjects:@"信息托管给物业，免去中介骚扰",@"物业做中间人，手续费减免",@"依托大数据支持，租房售房更容易", nil];
    NSArray *imgArray = [[NSArray alloc] initWithObjects:@"advantage1",@"advantage2",@"advantage3", nil];
    
    for (int i = 0; i < 3; i ++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10 + 86 * i, 49, 49)];
        [imgView setBackgroundColor:[UIColor clearColor]];
        [imgView setImage:[UIImage imageNamed:imgArray[i]]];
        [self.view addSubview:imgView];
        
        UILabel *bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 15 + 86 * i, kScreenWidth - 80, 21)];
        [bigLabel setBackgroundColor:[UIColor clearColor]];
        [bigLabel setText:[bigArray objectAtIndex:i]];
        [bigLabel setTextColor:THEME_COLOR_SMOKE];
        [bigLabel setFont:bigFont];
        [self.view addSubview:bigLabel];
        
        UILabel *smallLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 38 + 86 * i, kScreenWidth - 80, 21)];
        [smallLabel setBackgroundColor:[UIColor clearColor]];
        [smallLabel setFont:smallFont];
        [smallLabel setTextColor:THEME_COLOR_TEXT];
        [smallLabel setText:[smallArray objectAtIndex:i]];
        [self.view addSubview:smallLabel];
        
        if (i != 0)
        {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(14, 86 * i, kScreenWidth - 14 * 2, 0.5)];
            [line setBackgroundColor:THEME_COLOR_LINE];
            [self.view addSubview:line];
        }
        
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
