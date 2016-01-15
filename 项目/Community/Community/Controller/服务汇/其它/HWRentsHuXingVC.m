//
//  HWRentsHuXingVC.m
//  Community
//
//  Created by lizhongqiang on 14-9-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWRentsHuXingVC.h"

@interface HWRentsHuXingVC ()
{
    NSArray *array;
    
}
@end

@implementation HWRentsHuXingVC
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
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Utility navTitleView:@"租售托管"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"确定" action:@selector(btnNext:)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 150, 21)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setText:@"选择户型"];
    [label setTextColor:THEME_COLOR_TEXT];
    [label setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
    [self.view addSubview:label];
    
    array = [[NSArray alloc] initWithObjects:@"卧室",@"客厅",@"厨房",@"卫生间",@"阳台",@"花园", nil];
    for (int i = 0; i < array.count; i ++)
    {
        UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(34, 67 + 50 * i, 120, 18)];
        [labelName setBackgroundColor:[UIColor clearColor]];
        [labelName setText:[array objectAtIndex:i]];
        [labelName setFont:[UIFont fontWithName:FONTNAME size:15.0f]];
        [self.view addSubview:labelName];
        
        HWNumberButton *numberBtn;
        if (i == 0)
        {
            numberBtn = [[HWNumberButton alloc] initWithFrame:CGRectMake(110, 55, 180, 30) Number:2 LimitNum:1];
        }
        else
        {
            numberBtn = [[HWNumberButton alloc] initWithFrame:CGRectMake(110, 55 + 50 * i, 180, 30) Number:1 LimitNum:0];
        }
        numberBtn.strType = [array objectAtIndex:i];
        numberBtn.tag = 1000 + i;
        
        [self.view addSubview:numberBtn];
        
    }
    
}

- (void)btnNext:(id)sender
{
    [MobClick event:@"click_submit_button"];
    NSMutableString *strHuXing = [[NSMutableString alloc] init];
    HWNumberButton *btn1 = (HWNumberButton *)[self.view viewWithTag:1000];
    NSString *str = [NSString stringWithFormat:@"%i室",[btn1 getButtonNumber]];
    [strHuXing appendString:str];
    
    HWNumberButton *btn2 = (HWNumberButton *)[self.view viewWithTag:1001];
    if ([btn2 getButtonNumber] > 0)
    {
        NSString *strValue = [NSString stringWithFormat:@"%i厅",[btn2 getButtonNumber]];
        [strHuXing appendString:strValue];
    }
    
    HWNumberButton *btn3 = (HWNumberButton *)[self.view viewWithTag:1002];
    if ([btn3 getButtonNumber] > 0)
    {
        NSString *strValue = [NSString stringWithFormat:@"%i厨",[btn3 getButtonNumber]];
        [strHuXing appendString:strValue];
    }
    
    HWNumberButton *btn4 = (HWNumberButton *)[self.view viewWithTag:1003];
    if ([btn4 getButtonNumber] > 0)
    {
        NSString *strValue = [NSString stringWithFormat:@"%i卫",[btn4 getButtonNumber]];
        [strHuXing appendString:strValue];
    }
    
    HWNumberButton *btn5 = (HWNumberButton *)[self.view viewWithTag:1004];
    if ([btn5 getButtonNumber] > 0)
    {
        NSString *strValue = [NSString stringWithFormat:@"%i阳台",[btn5 getButtonNumber]];
        [strHuXing appendString:strValue];
    }
    
    HWNumberButton *btn6 = (HWNumberButton *)[self.view viewWithTag:1005];
    if ([btn6 getButtonNumber] > 0)
    {
        NSString *strValue = [NSString stringWithFormat:@"%i花园",[btn6 getButtonNumber]];
        [strHuXing appendString:strValue];
    }
    
    HWRentsData *rents = [HWRentsData getRentsData];
    rents.strHuXing = strHuXing;
    
    if ([self.superVC isKindOfClass:[HWHouseSaleRentsVC class]])
    {
        //delegate
        [delegate getRentsHuXing];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        HWHouseSaleRentsVC *house = [[HWHouseSaleRentsVC alloc] init];
        house.rootVC = self.rootVC;
        house.phoneHistoryId = self.phoneHistoryId;
        [self.navigationController pushViewController:house animated:YES];
    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
