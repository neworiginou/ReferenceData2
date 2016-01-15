//
//  HWPerfectPropertyDataVC.m
//  Community
//
//  Created by lizhongqiang on 14-9-12.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWPerfectPropertyDataVC.h"
#import "AppDelegate.h"

@interface HWPerfectPropertyDataVC ()
{
    UITextField *textFieldName;
    UITextField *textFieldPhone;
}
@end

@implementation HWPerfectPropertyDataVC
@synthesize isProperty;
@synthesize propertyId;
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

- (void)rightItem
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (textFieldName.text.length <= 0)
    {
        [Utility showToastWithMessage:@"请输入物业公司名称" inView:app.window];
        return;
    }
    else
    {
        if (textFieldName.text.length >= 4 && textFieldPhone.text.length <= 20)
        {
            if (textFieldPhone.text.length <= 0)
            {
                [Utility showToastWithMessage:@"请输入物业电话~" inView:app.window];
                return;
            }
            else
            {
                if (textFieldPhone.text.length >= 9 && textFieldPhone.text.length <= 13)
                {
                    HWUserLogin *user = [HWUserLogin currentUserLogin];
                    NSString *strAddress = [NSString stringWithFormat:@"%@%@",user.villageAddress,user.villageName];
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                    [dict setPObject:user.key forKey:@"key"];
                    [dict setPObject:strAddress forKey:@"address"];
                    [dict setPObject:textFieldName.text forKey:@"name"];
                    [dict setPObject:textFieldPhone.text forKey:@"phone"];
                    //mark 0没物业  1 修改物业
                    //cityId
                    if (isProperty)
                    {
                        [dict setPObject:@"1" forKey:@"mark"];
                        [dict setPObject:propertyId forKey:@"tenementId"];
                    }
                    else
                    {
                        [dict setPObject:@"0" forKey:@"mark"];
                    }
                    [dict setPObject:user.cityId forKey:@"cityId"];
                    self.navigationItem.rightBarButtonItem.enabled = NO;
                    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
                    [manager POST:kPerfect parameters:dict queue:nil success:^(id responseObject) {
                        NSLog(@"%@",responseObject);
                        NSString *strStatus = [responseObject stringObjectForKey:@"status"];
                        if ([strStatus isEqualToString:@"1"])
                        {
                            [Utility showToastWithMessage:@"提交成功，感谢你帮我们完善物业资料" inView:app.window];
                            [self performSelector:@selector(hidePop) withObject:nil afterDelay:2.0f];
                            
                        }
                        else
                        {
                            [Utility showToastWithMessage:[responseObject stringObjectForKey:@"detail"] inView:app.window];
                        }
                    } failure:^(NSString *code, NSString *error) {
                        NSLog(@"%@",error);
                        self.navigationItem.rightBarButtonItem.enabled = YES;
                        [Utility showToastWithMessage:error inView:app.window];
                    }];
                }
                else
                {
                    [Utility showToastWithMessage:@"请输入正确的号码" inView:app.window];
                    return;
                }
            }
        }
        else
        {
            [Utility showToastWithMessage:@"请输入正确的公司名称" inView:app.window];
            return;
        }
    }
    
//    if (textFieldName.text.length >= 4 && textFieldName.text.length <= 20)
//    {
//        if (textFieldPhone.text.length >= 9 && textFieldPhone.text.length <= 13)
//        {
//            HWUserLogin *user = [HWUserLogin currentUserLogin];
//            NSString *strAddress = [NSString stringWithFormat:@"%@%@",user.villageAddress,user.villageName];
//            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//            [dict setPObject:user.key forKey:@"key"];
//            [dict setPObject:strAddress forKey:@"address"];
//            [dict setPObject:textFieldName.text forKey:@"name"];
//            [dict setPObject:textFieldPhone.text forKey:@"phone"];
//            //mark 0没物业  1 修改物业
//            //cityId
//            if (isProperty)
//            {
//                [dict setPObject:@"1" forKey:@"mark"];
//                [dict setPObject:propertyId forKey:@"tenementId"];
//            }
//            else
//            {
//                [dict setPObject:@"0" forKey:@"mark"];
//            }
//            [dict setPObject:user.cityId forKey:@"cityId"];
//            
//            HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
//            [manager POST:kPerfect parameters:dict queue:nil success:^(id responseObject) {
//                NSLog(@"%@",responseObject);
//                NSString *strStatus = [responseObject stringObjectForKey:@"status"];
//                if ([strStatus isEqualToString:@"1"])
//                {
//                    [Utility showToastWithMessage:@"感谢提交物业资料，审核通过信息将会更新" inView:self.view];
//                    [self performSelector:@selector(hidePop) withObject:nil afterDelay:2.0f];
//                    
//                }
//                else
//                {
//                    [Utility showToastWithMessage:[responseObject objectForKey:@"detail"] inView:self.view];
//                }
//            } failure:^(NSString *error) {
//                NSLog(@"%@",error);
//                [Utility showToastWithMessage:error inView:self.view];
//            }];
//            
//        }
//        else
//        {
//            [Utility showToastWithMessage:@"请输入正确的号码" inView:self.view];
//        }
//    }
//    else
//    {
//        [Utility showToastWithMessage:@"请输入正确的公司名称" inView:self.view];
//    }
}

- (void)hidePop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"完善物业资料"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"确定" action:@selector(rightItem)];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    UIFont *bigFont = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    UIFont *smallFont = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    
    UILabel *labelAddress = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth, 28)];
    [labelAddress setBackgroundColor:[UIColor clearColor]];
    [labelAddress setFont:bigFont];
    [labelAddress setText:@"当前小区地址"];
    [self.view addSubview:labelAddress];
    
    HWUserLogin *user = [HWUserLogin currentUserLogin];

    
    UILabel *labelVillageName = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(labelAddress.frame) + 10, kScreenWidth - 30, 21)];
    [labelVillageName setBackgroundColor:[UIColor clearColor]];
    [labelVillageName setFont:bigFont];
    [labelVillageName setTextColor:THEME_COLOR_TEXT];
    [labelVillageName setText:user.villageName];
    [self.view addSubview:labelVillageName];
    
    
    UILabel *labelVillageAddress = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(labelVillageName.frame) + 10, kScreenWidth - 30, 21)];
    [labelVillageAddress setBackgroundColor:[UIColor clearColor]];
    [labelVillageAddress setFont:smallFont];
    [labelVillageAddress setTextColor:THEME_COLOR_TEXT];
    [labelVillageAddress setText:user.villageAddress];
    [self.view addSubview:labelVillageAddress];
    
    
    
    HWInputBackView *input = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(labelVillageAddress.frame) + 10, kScreenWidth, 44) withLineCount:1];
    [self.view addSubview:input];
    
    textFieldName = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(labelVillageAddress.frame) + 10, kScreenWidth - 30, 44)];
    [textFieldName setBackgroundColor:[UIColor clearColor]];
    [textFieldName setPlaceholder:@"填写物业公司名称，一般为XXX小区物业"];
    [textFieldName setFont:bigFont];
    textFieldName.delegate = self;
    [self.view addSubview:textFieldName];
    
    
    HWInputBackView *inputBg = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textFieldName.frame) + 10, kScreenWidth, 44) withLineCount:1];
    [self.view addSubview:inputBg];
    
    textFieldPhone = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(textFieldName.frame) + 10, kScreenWidth - 30, 44)];
    [textFieldPhone setPlaceholder:@"填写物业公司电话"];
    [textFieldPhone setFont:bigFont];
    textFieldPhone.delegate = self;
    [self.view addSubview:textFieldPhone];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (!IPHONE5)
    {
        if (textField == textFieldName)
        {
            [UIView animateWithDuration:0.7f animations:^{
                
                self.view.frame = CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height);
            } completion:^(BOOL finished) {
                
            }];
        }
        
        if (textField == textFieldPhone)
        {
            
            [UIView animateWithDuration:0.7f animations:^{
                self.view.frame = CGRectMake(0, -40, self.view.frame.size.width, self.view.frame.size.height);
            } completion:^(BOOL finished) {
                
            }];
            
        }
    }
    
    
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];//判断所点击view是否是UITextField或UITextView
    if (![[touch view] isKindOfClass:[UITextField class]] && ![[touch view] isKindOfClass:[UITextView class]]) {
        for (UIView* view in self.view.subviews) {
            if ([view isKindOfClass:[UITextField class]]) {
                [view resignFirstResponder];
                [UIView animateWithDuration:0.7f animations:^{
                    
                    self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
                } completion:^(BOOL finished) {
                    self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
                }];
            }
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textFieldName == textField)
    {
        [textFieldPhone becomeFirstResponder];
    }
    if (textFieldPhone == textField)
    {
        [textField resignFirstResponder];
        [UIView animateWithDuration:0.7f animations:^{
            
            self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
