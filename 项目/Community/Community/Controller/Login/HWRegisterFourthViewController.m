//
//  HWRegisterFourthViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWRegisterFourthViewController.h"
#import "HWInputBackView.h"
#import "HWRequestConfig.h"
#import "HWHTTPRequestOperationManager.h"
#import "HWCoreDataManager.h"
#import "HWLocationChangeViewController.h"
#import "AppDelegate.h"
#import "HWCustomGuideAlertView.h"
@interface HWRegisterFourthViewController ()
{
    UITextField *_nicknameTF;
    UIButton *_confirmBtn;
}

@end

@implementation HWRegisterFourthViewController
@synthesize telephoneNum;
@synthesize password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    if (commeInMainViewFlag == YES) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Utility navTitleView:@"设置昵称"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationController.navigationBarHidden = NO;

    
    HWInputBackView *backView = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 45.0f) withLineCount:1];
    [self.view addSubview:backView];
    
    _nicknameTF = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMinY(backView.frame) + 7.5f + (!IOS7 ? 5 : 0), kScreenWidth - 30 - 44, 30)];
    _nicknameTF.textColor = THEME_COLOR_SMOKE;
    _nicknameTF.placeholder = @"设置昵称/点击右方按钮随机生成";
    _nicknameTF.delegate = self;
    _nicknameTF.secureTextEntry = NO;
    _nicknameTF.font = [UIFont fontWithName:FONTNAME size:15.0f];
    _nicknameTF.delegate = self;
    _nicknameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_nicknameTF];
    
    //随机生成昵称按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"iconloding3"] forState:UIControlStateNormal];
    [backView addSubview:btn];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:backView];
    [btn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_nicknameTF.superview withOffset:-15];
    //[btn autoSetDimensionsToSize:CGSizeMake(44, 44)];
    [btn addTarget:self action:@selector(randomNameRequest) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(backView.frame) + 20, kScreenWidth - 30, 20)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:FONTNAME size:15.0f];
    label.textColor = THEME_COLOR_TEXT;
    label.text = @"昵称长度不得大于8个中文";
    [self.view addSubview:label];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(15.0f, CGRectGetMaxY(label.frame) + 20.0f, kScreenWidth - 30.0f, 45.0f);
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_confirmBtn setButtonOrangeStyle];
    [_confirmBtn addTarget:self action:@selector(doConfirm:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    commeInMainViewFlag = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    [self.view addGestureRecognizer:tap];
}

-(void)randomNameRequest
{
    [Utility showMBProgress:self.view message:@"随机昵称生成中..."];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    [manager POST:kGetRandomNickName parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
        NSDictionary *dic = [responseObject dictionaryObjectForKey:@"data"];;
        _nicknameTF.text = [dic stringObjectForKey:@"nickName"];
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
    }];
}

#pragma mark -
#pragma mark Private method

- (void)doTap:(id)sender
{
    [self.view endEditing:YES];
}


//设置密码

- (void)backMethod
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}
- (void)sendSubmitRequest
{
    if (_nicknameTF.text.length == 0)
    {
        [Utility showToastWithMessage:@"请输入昵称" inView:self.view];
        return;
    }
    
    [self.view endEditing:YES];
    
    if (self.isGuest == YES)
    {
        [Utility showMBProgress:self.view message:LOADING_TEXT];
        HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setPObject:_nicknameTF.text forKey:@"nickname"];
        [dict setPObject:telephoneNum forKey:@"mobileNumber"];
        [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
        [dict setPObject:password forKey:@"password"];
        [dict setPObject:[Utility getUUIDWithoutSymbol] forKey:@"deviceId"];
        
        [manager POST:kGuestBindNewMobile parameters:dict queue:nil success:^(id responseObject) {
            [Utility hideMBProgress:self.view];
            [[HWUserLogin currentUserLogin]initUserLogin:[responseObject objectForKey:@"data"]];
            [HWCoreDataManager saveUserInfo]; // 保存数据库
            
            NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"绑定成功，"];
            NSString *content = [[[responseObject objectForKey:@"detail"] componentsSeparatedByCharactersInSet:set]componentsJoinedByString:@""];
            HWCustomGuideAlertView *alertView = [[HWCustomGuideAlertView alloc]initWithAlertType:3 customContent:content];
            [alertView showCustomGuideAlertViewWithCompleteBlock:^(NSInteger buttonTag)
            {
                if (buttonTag == 0)
                {
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    [userDefault setObject:@"0" forKey:kAgreeProtocol];
                    [userDefault synchronize];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:RELOAD_APP_DATA object:nil];
                    HWLocationChangeViewController *selectCommunityView = [[HWLocationChangeViewController alloc]init];
                    selectCommunityView.locationChangeFlag = NO;
                    selectCommunityView.isCheckIPBindVillageId = YES;
                    [self.navigationController pushViewController:selectCommunityView animated:YES];
                }
            }];
        } failure:^(NSString *code, NSString *error) {
            [Utility hideMBProgress:self.view];
            [Utility showToastWithMessage:error inView:self.view];
        }];
    }
    else
    {
        [Utility showMBProgress:self.view message:LOADING_TEXT];
        HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setPObject:_nicknameTF.text forKey:@"nickname"];
        [dict setPObject:telephoneNum forKey:@"mobileNumber"];
        [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
        
        [manager POST:kSettingNickName parameters:dict queue:nil success:^(id responseObject) {
            [Utility hideMBProgress:self.view];
            [HWUserLogin currentUserLogin].nickname = _nicknameTF.text;
            [HWCoreDataManager saveUserInfo]; // 保存数据库
            HWLocationChangeViewController *selectCommunityView = [[HWLocationChangeViewController alloc]init];
            selectCommunityView.locationChangeFlag = NO;
            selectCommunityView.isNickVCPush = YES;
            selectCommunityView.isCheckIPBindVillageId = YES;
            commeInMainViewFlag = YES;
            [self.navigationController pushViewController:selectCommunityView animated:YES];
        } failure:^(NSString *code, NSString *error) {
            [Utility hideMBProgress:self.view];
            [Utility showToastWithMessage:error inView:self.view];
        }];
    }
}

/**
 *	@brief	提交注册
 *
 *	@param 	sender
 *
 *	@return
 */
- (void)doConfirm:(id)sender
{
    [MobClick event:@"click_submit"];
    
    if (_nicknameTF.text.length == 0 || [Utility isAllSpaceWithString:_nicknameTF.text])
    {
        [Utility showToastWithMessage:@"请输入昵称" inView:self.view];
        return;
    }
    [_nicknameTF resignFirstResponder];
    [self sendSubmitRequest];
}

#pragma mark -
#pragma mark TextField Delegate method

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *text = [textField.text mutableCopy];
    [text replaceCharactersInRange:range withString:string];
    int length = [Utility calculateTextLength:text];
    // 昵称最多8个中文字符
    if (length > 8)
    {
        [_confirmBtn setInactiveState];
    }
    else
    {
        [_confirmBtn setActiveState];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [MobClick event:@"get_focus_nickname"];
    return YES;
}

#pragma mark -
#pragma mark System method

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
