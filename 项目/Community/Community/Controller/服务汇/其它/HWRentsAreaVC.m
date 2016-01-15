//
//  HWRentsAreaVC.m
//  Community
//
//  Created by lizhongqiang on 14-9-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWRentsAreaVC.h"

@interface HWRentsAreaVC ()

@end

@implementation HWRentsAreaVC
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
    
    
    UILabel *labelTip = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth - 15 * 2, 15)];
    [labelTip setBackgroundColor:[UIColor clearColor]];
    [labelTip setTextColor:THEME_COLOR_TEXT];
    [labelTip setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
    [labelTip setText:@"填写使用面积，同样也是保密的哦~"];
    [self.view addSubview:labelTip];
    
    
    HWInputBackView *input = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, 47, kScreenWidth, 44) withLineCount:1];
    [self.view addSubview:input];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 47, kScreenWidth - 150, 44)];
    textField.backgroundColor = [UIColor clearColor];
    textField.placeholder = @"大于0的数字";
    textField.tag = 999;
    textField.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    [self.view addSubview:textField];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 110, 47, 120, 38)];
    [label setText:@"单位（㎡）"];
    label.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    [self.view addSubview:label];
    
}

- (void)btnNext:(id)sender
{
    HWRentsData *rents = [HWRentsData getRentsData];
    UITextField *textFieldArea = (UITextField *)[self.view viewWithTag:999];
    if ([textFieldArea.text intValue] > 0)
    {
        rents.strArea = textFieldArea.text;
    }
    else
    {
        [Utility showToastWithMessage:@"请输入正确的面积" inView:self.view];
        return;
    }
    
    if ([self.superVC isKindOfClass:[HWHouseSaleRentsVC class]])
    {
        //delegate
        [delegate getRentsArea];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        HWRentsHuXingVC *huxing = [[HWRentsHuXingVC alloc] init];
        huxing.rootVC = self.rootVC;
        huxing.phoneHistoryId = self.phoneHistoryId;
        [self.navigationController pushViewController:huxing animated:YES];
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
