//
//  HWRentsPeopleInfoVC.m
//  Community
//
//  Created by lizhongqiang on 14-9-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWRentsPeopleInfoVC.h"

@interface HWRentsPeopleInfoVC ()

@end

@implementation HWRentsPeopleInfoVC
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
    
    UILabel *labelLeft = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 150, 28)];
    [labelLeft setBackgroundColor:[UIColor clearColor]];
    [labelLeft setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
    [labelLeft setTextColor:THEME_COLOR_TEXT];
    [labelLeft setText:@"填写租售人信息"];
    [self.view addSubview:labelLeft];
    
    UILabel *labelRight = [[UILabel alloc] initWithFrame:CGRectMake(110, 14, kScreenWidth - 130, 21)];
    [labelRight setBackgroundColor:[UIColor clearColor]];
    [labelRight setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
    [labelRight setTextColor:THEME_COLOR_TEXT];
    [labelRight setText:@"（我们将为你保密所有信息）"];
    [self.view addSubview:labelRight];
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"业主姓名 *",@"手机号码 *", nil];
    
    for (int i = 0; i < array.count; i ++)
    {
        HWInputBackView *input = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, 49 + 55 * i, kScreenWidth, 45) withLineCount:1];
        [self.view addSubview:input];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(19, 62 + 55 * i, 140, 18)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:[array objectAtIndex:i]];
        [label setTextColor:THEME_COLOR_SMOKE];
        [label setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
        [self.view addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(115, 58 + 55 * i, kScreenWidth - 115 - 15, 30)];
        [textField setBackgroundColor:[UIColor clearColor]];
        textField.tag = i + 999;
        textField.delegate = self;
        textField.textColor = THEME_COLOR_SMOKE;
        textField.placeholder = @"必填";
        textField.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        [self.view addSubview:textField];
        
    }
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextField *textFieldPhone = (UITextField *)[self.view viewWithTag:(999 + 1)];//电话
    if (textFieldPhone == textField)
    {
        if (textFieldPhone.text.length >= 11 && range.length == 0)
        {
            return NO;
        }
    }
    return YES;
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UITextField *textFieldName = (UITextField *)[self.view viewWithTag:999];//姓名
    UITextField *textFieldPhone = (UITextField *)[self.view viewWithTag:(999 + 1)];//电话
    if (textFieldName == textField)
    {
        [MobClick event:@"get_focus_name"];
    }
    if (textFieldPhone == textField)
    {
        [MobClick event:@"get_focus_phonenumber"];
//        if (textFieldPhone.text.length > 11)
//        {
//            return NO;
//        }
        
    }
    return YES;
}

- (void)btnNext:(id)sender
{
    HWRentsData *rents = [HWRentsData getRentsData];
    
    UITextField *textFieldName = (UITextField *)[self.view viewWithTag:999];//姓名
    if (textFieldName.text.length > 0)
    {
        if ([Utility stringContainsEmoji:textFieldName.text])
        {
            [Utility showToastWithMessage:@"请输入正确的业主姓名" inView:self.view];
            return;
        }
        else
        {
            rents.strName = textFieldName.text;
        }
    }
    else
    {
        //提示
        [Utility showToastWithMessage:@"请输入业主姓名" inView:self.view];
        return;
    }
    
    UITextField *textFieldPhone = (UITextField *)[self.view viewWithTag:(999 + 1)];//电话
    
    //手机号码是否做校验
    if (textFieldPhone.text.length == 11)
    {
        BOOL phone = [Utility validateMobile:textFieldPhone.text];
        if (!phone) {
            [Utility showToastWithMessage:@"请输入正确的手机号码" inView:self.view];
            return;
        }
        else
        {
            if ([Utility stringContainsEmoji:textFieldPhone.text])
            {
                [Utility showToastWithMessage:@"请输入正确的手机号码" inView:self.view];
                return;
            }
            else
            {
                rents.strPhone = textFieldPhone.text;
            }
            
        }
    }
    else
    {
        [Utility showToastWithMessage:@"输入的手机号位数不对" inView:self.view];
        return;
    }
    
    
    if ([self.superVC isKindOfClass:[HWHouseSaleRentsVC class]])
    {
        //delegate
        [delegate getRentsPeopleInfo];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        HWRentsAddressVC *address = [[HWRentsAddressVC alloc] init];
        address.rootVC = self.rootVC;
        address.phoneHistoryId = self.phoneHistoryId;
        [self.navigationController pushViewController:address animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
