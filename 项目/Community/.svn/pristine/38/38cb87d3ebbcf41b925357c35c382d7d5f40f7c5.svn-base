//
//  HWRentsAddressVC.m
//  Community
//
//  Created by lizhongqiang on 14-9-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWRentsAddressVC.h"
#import "HWUserLogin.h"
#import "HWCoreDataManager.h"

@interface HWRentsAddressVC ()
{
    UITextField *buildTextField;
    UITextField *roomTextField;
    
    UILabel *labelVillageName;
    UILabel *labelVillageAddress;
    
    HWAreaClass *newArea;
}
@end

@implementation HWRentsAddressVC
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
    
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    
    UILabel *labelLeft = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 150, 28)];
    [labelLeft setBackgroundColor:[UIColor clearColor]];
    [labelLeft setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
    [labelLeft setTextColor:THEME_COLOR_TEXT];
    [labelLeft setText:@"填写租售人信息"];
    [self.view addSubview:labelLeft];
    
    UILabel *labelRight = [[UILabel alloc] initWithFrame:CGRectMake(110, 14, kScreenWidth - 120, 21)];
    [labelRight setBackgroundColor:[UIColor clearColor]];
    [labelRight setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
    [labelRight setTextColor:THEME_COLOR_TEXT];
    [labelRight setText:@"（我们将为你保密所有信息）"];
    [self.view addSubview:labelRight];
    
    
    labelVillageName = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(labelLeft.frame) + 10, kScreenWidth - 30, 23)];
    [labelVillageName setBackgroundColor:[UIColor clearColor]];
    [labelVillageName setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
    [labelVillageName setTextColor:THEME_COLOR_SMOKE];
    [labelVillageName setText:user.villageName];
    [self.view addSubview:labelVillageName];
    
    
    labelVillageAddress = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(labelVillageName.frame) + 10, kScreenWidth - 30, 21)];
    [labelVillageAddress setBackgroundColor:[UIColor clearColor]];
    [labelVillageAddress setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
    [labelVillageAddress setTextColor:THEME_COLOR_TEXT];
    [labelVillageAddress setText:user.villageAddress];
    [self.view addSubview:labelVillageAddress];
    
    UIButton *btnOtherCommunity = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnOtherCommunity setFrame:CGRectMake(kScreenWidth - 100, 40, 82, 36)];
    [btnOtherCommunity setBackgroundColor:[UIColor colorWithRed:100.0/255.0 green:177.0/255.0 blue:171.0/255.0 alpha:1.0]];
    [btnOtherCommunity setTitle:@"其他小区" forState:UIControlStateNormal];
    btnOtherCommunity.layer.cornerRadius = 5;
    [btnOtherCommunity.titleLabel setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
    [btnOtherCommunity setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnOtherCommunity addTarget:self action:@selector(btnOtherCommunityClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOtherCommunity];
    
    
    HWInputBackView *input = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(labelVillageAddress.frame) + 10, kScreenWidth, 45) withLineCount:1];
    [self.view addSubview:input];
    
    buildTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(labelVillageAddress.frame) + 10, kScreenWidth - 10 * 2, 45)];
    buildTextField.placeholder = @"填写楼号/单元号，例如：3号楼/1单元";
    [buildTextField setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
    buildTextField.delegate = self;
    [self.view addSubview:buildTextField];
    
    HWInputBackView *roomInput = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(buildTextField.frame) + 10, kScreenWidth, 45) withLineCount:1];
    [self.view addSubview:roomInput];
    
    roomTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(buildTextField.frame) + 10, kScreenWidth - 10 * 2, 45)];
    [roomTextField setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
    roomTextField.placeholder = @"填写房号，例如：201号";
    roomTextField.delegate = self;
    [self.view addSubview:roomTextField];
}
/**
 *  其他小区，拉小区列表
 */
- (void)btnOtherCommunityClick
{
    HWLocationChangeViewController *location = [[HWLocationChangeViewController alloc] initWithNibName:@"HWLocationChangeViewController" bundle:nil];
    location.isOtherCommunity = YES;
    location.delegate = self;
    [self.navigationController pushViewController:location animated:YES];
}

- (void)getOtherAddress:(NSString *)address Name:(NSString *)name Community:(HWAreaClass *)area
{
    labelVillageAddress.text = address;
    labelVillageName.text = name;
    newArea = area;
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (!IPHONE5)
    {
        if (textField == buildTextField)
        {
            [MobClick event:@""];
            [UIView animateWithDuration:0.7f animations:^{

                self.view.frame = CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height);
            } completion:^(BOOL finished) {

            }];
        }
        
        if (textField == roomTextField)
        {
            [MobClick event:@""];
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


- (void)btnNext:(id)sender
{
    HWRentsData *rents = [HWRentsData getRentsData];
//    HWUserLogin *user = [HWUserLogin currentUserLogin];
    if (buildTextField.text.length > 0)
    {

        rents.buildNo = buildTextField.text;
        if (roomTextField.text.length > 0)
        {
            
            rents.roomNo = roomTextField.text;
            NSMutableString *address = [[NSMutableString alloc] init];
            if (labelVillageAddress.text)
            {
                [address appendString:labelVillageAddress.text];
            }
            if (labelVillageName.text)
            {
                [address appendString:labelVillageName.text];
            }
//            NSLog(@"%@",address);
            [address appendString:buildTextField.text];
            [address appendString:roomTextField.text];
            
            rents.strAddress = address;
        }
        else
        {
            [Utility showToastWithMessage:@"请输入房间号" inView:self.view];
        }
    }
    else
    {
        [Utility showToastWithMessage:@"请输入楼号" inView:self.view];
        return;
    }
    
    if ([self.superVC isKindOfClass:[HWHouseSaleRentsVC class]])
    {
        //delegate
        [delegate getRentsAddress];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        HWRentsAreaVC *area = [[HWRentsAreaVC alloc] init];
        area.rootVC = self.rootVC;
        area.phoneHistoryId = self.phoneHistoryId;
        [self.navigationController pushViewController:area animated:YES];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
