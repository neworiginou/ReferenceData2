//
//  HWOrderAddressVC.m
//  Community
//
//  Created by lizhongqiang on 14-9-5.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWOrderAddressVC.h"

@interface HWOrderAddressVC ()
{
    UITextField *textField;

}
@end

@implementation HWOrderAddressVC
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)btnSure
{
    HWOrderData *order = [HWOrderData getOrderData];
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    if (textField.text.length > 0)
    {
        if ([Utility stringContainsEmoji:textField.text])
        {
            
            [Utility showToastWithMessage:@"请输入正确的地址" inView:self.view];
            return;
        }
        else
        {
            NSMutableString *strAddress = [[NSMutableString alloc] init];
            
            if (user.villageAddress)
            {
                [strAddress appendString:user.villageAddress];
            }
            
            if (user.villageName)
            {
                [strAddress appendString:user.villageName];
            }
            [strAddress appendString:textField.text];
            
            order.address = strAddress;
            [delegate getOrderAddress];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    else
    {
        [Utility showToastWithMessage:@"请输入您的楼号门牌号" inView:self.view];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.titleView = [Utility navTitleView:@"物业上门"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"确定" action:@selector(btnSure)];
    [self.view setBackgroundColor:THEME_COLOR_TEXTBACKGROUND];
    
    
    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth - 10 * 2, 21)];
    [labTitle setBackgroundColor:[UIColor clearColor]];
    [labTitle setText:@"填写地址，您的住址只有物业公司可以看见，不会泄露给任何人。"];
    [labTitle setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
    [labTitle setTextColor:THEME_COLOR_TEXT];
    labTitle.numberOfLines = 0;
    [labTitle sizeToFit];
    [self.view addSubview:labTitle];
    
    
    UIFont *bigFont = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    
    UILabel *labelVillageName = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(labTitle.frame) + 10, kScreenWidth - 30, 21)];
    [labelVillageName setBackgroundColor:[UIColor clearColor]];
    [labelVillageName setFont:bigFont];
    [labelVillageName setTextColor:THEME_COLOR_TEXT];
    [labelVillageName setText:user.villageName];
    [self.view addSubview:labelVillageName];
    
    
    UILabel *labelVillageAddress = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(labelVillageName.frame) + 10, kScreenWidth - 30, 21)];
    [labelVillageAddress setBackgroundColor:[UIColor clearColor]];
    [labelVillageAddress setFont:bigFont];
    [labelVillageAddress setTextColor:THEME_COLOR_TEXT];
    [labelVillageAddress setText:user.villageAddress];
    [self.view addSubview:labelVillageAddress];
    
    
    HWInputBackView *input = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(labelVillageAddress.frame) + 10, kScreenWidth, 45) withLineCount:1];
    [self.view addSubview:input];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 117, kScreenWidth - 30, 45)];
    textField.tag = 999;
    textField.delegate = self;
    [textField setBackgroundColor:[UIColor clearColor]];
    textField.font = [UIFont fontWithName:FONTNAME size:14.0f];
    textField.placeholder = @"填写楼号门牌号，例如：3号楼2020";
    [self.view addSubview:textField];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];//判断所点击view是否是UITextField或UITextView
    if (![[touch view] isKindOfClass:[UITextField class]] && ![[touch view] isKindOfClass:[UITextView class]]) {
        for (UIView* view in self.view.subviews) {
            if ([view isKindOfClass:[UITextField class]]) {
                [view resignFirstResponder];
            }
        }
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [MobClick event:@"get_focus_address"];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
