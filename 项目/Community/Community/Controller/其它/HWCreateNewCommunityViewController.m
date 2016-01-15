//
//  HWCreateNewCommunityViewController.m
//  Community
//
//  Created by gusheng on 14-9-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWCreateNewCommunityViewController.h"
#import "HWRequestConfig.h"
#import "HWHTTPRequestOperationManager.h"
#import "MapLocationViewController.h"
@interface HWCreateNewCommunityViewController ()

@end

@implementation HWCreateNewCommunityViewController
@synthesize communityNameTextFiled,latitudeStr,longtudeStr,submitBtn,locationLabel,lineImageView,upLine,downLine,cityName;
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
    
    //设置UI控件的frame
    self.backView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth);
    self.locationImageView.frame = CGRectMake(kScreenWidth -14 -18, 68, 15, 18);
    self.communityNameTextFiled.size = CGSizeMake(256*kScreenRate, 30);
    self.locationLabel.size = CGSizeMake(256*kScreenRate, 30);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(popAllTextfiled)];
    [self.view addGestureRecognizer:tap];
    self.navigationItem.titleView = [Utility navTitleView:@"创建小区"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = UIColorFromRGB(0xececec);
    [self initMainViewAtrribution];
    latitudeStr = @"0";
    longtudeStr = @"0";
    
    if (IOS7Dot0)
    {
        CGRect frame = self.backView.frame;
        frame.origin.y += 64;
        self.backView.frame = frame;
    }
    
}
//收起所有得textFiled
-(void)popAllTextfiled
{
    [communityNameTextFiled resignFirstResponder];
    [locationLabel resignFirstResponder];
}
//初始化视图页面属性
-(void)initMainViewAtrribution
{
    submitBtn.layer.cornerRadius = 2.0f;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn setButtonOrangeStyle];
    
    lineImageView.backgroundColor =THEME_COLOR_LINE;
    upLine.backgroundColor = THEME_COLOR_LINE;
    downLine.backgroundColor = THEME_COLOR_LINE;
    locationLabel.font = [UIFont systemFontOfSize:15.0f];
    communityNameTextFiled.textColor = THEME_COLOR_SMOKE;
    communityNameTextFiled.font = [UIFont fontWithName:FONTNAME size:15];
    locationLabel.textColor = THEME_COLOR_SMOKE;
    
    //locationLabel.placeholder = @"";
}
//提交新创建的小区
//返回上一级
- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}
//开始定位
-(IBAction)startLocation
{
    MapLocationViewController *startLocationView = [[MapLocationViewController alloc]initWithNibName:@"MapLocationViewController" bundle:nil];
    [startLocationView setClickReturnLocation:^(NSString *posizition,NSString *latitude,NSString *longtitude)
     {
         locationLabel.text = posizition;
         latitudeStr = latitude;
         longtudeStr = longtitude;
     }];
    [self.navigationController pushViewController:startLocationView animated:YES];
}
//提交
-(IBAction)submitSure
{
    [self popAllTextfiled];
    if ([communityNameTextFiled.text length]==0) {
        [Utility showToastWithMessage:@"小区名不能为空" inView:self.view];
        return;
    }
    if ([locationLabel.text length]==0) {
        [Utility showToastWithMessage:@"小区地址不能为空" inView:self.view];
        return;
    }

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"感谢你的支持，我们会审核资料真实性，现在你可以" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定提交", nil];
    alert.tag = 5001;
    [alert show];
}
//提交新建小区信息
-(IBAction)submitNewCommunityRequest
{
    if ([communityNameTextFiled.text length]==0) {
        [Utility showToastWithMessage:@"小区名不能为空" inView:self.view];
        return;
    }
    if ([locationLabel.text length]==0) {
        [Utility showToastWithMessage:@"小区地址不能为空" inView:self.view];
        return;
    }
    [Utility showMBProgress:self.view message:@"提交新建小区"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[communityNameTextFiled.text stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:@"villageName"];
    [dict setPObject:[locationLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:@"address"];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:latitudeStr forKey:@"latitude"];
    [dict setPObject:longtudeStr forKey:@"longitude"];
    if ([[HWUserLogin currentUserLogin].cityName length]==0) {
        [dict setPObject:cityName forKey:@"cityName"];
    }
    else
    {
        [dict setPObject:[HWUserLogin currentUserLogin].cityName forKey:@"cityName"];

    }
        [manager POST:kCreatNewArea parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
            [Utility showToastWithMessage:@"感谢提交你的小区资料，我们会审核资料真实性，现在你可以入住附近的小区" inView:self.view];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        NSLog(@"error");
    }];
 
}
#pragma mark- alertDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 5001) {
        switch (buttonIndex) {
            case 1:
            {
                [self submitNewCommunityRequest];
                break;
            }
            default:
                break;
        }

        return;
    }
    switch (buttonIndex) {
        case 0:
        {
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        default:
            break;
    }
}
#pragma mark - textFeildDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [communityNameTextFiled resignFirstResponder];
    [locationLabel resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
