//
//  HWLoginViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWLoginViewController.h"
#import "HWInputBackView.h"
#import "HWForgetFirstViewController.h"
#import "HWHTTPRequestOperationManager.h"
#import "HWRequestConfig.h"
#import "HWCoreDataManager.h"
#import "AppDelegate.h"
#import "APService.h"
#import "HWRegisterFirstViewController.h"
#import "HWRegisterFourthViewController.h"
#import "HWRegisterViewController.h"
#import "HWCustomGuideAlertView.h"

@interface HWLoginViewController ()
{
    UIButton *_loginBtn;
//    UITextField *_usernameTF;
    UITextField *_passwordTF;
}
@end

@implementation HWLoginViewController
@synthesize usernameTF;

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
    [super backMethod];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Utility navTitleView:@"登录"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    self.navigationController.navigationBarHidden = NO;
    
    HWInputBackView *backView = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 90) withLineCount:2];
    [self.view addSubview:backView];
    
    usernameTF = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMinY(backView.frame) + 7.5f + (!IOS7 ? 5 : 0), kScreenWidth - 30, 30)];
    usernameTF.backgroundColor = [UIColor clearColor];
    usernameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    usernameTF.keyboardType = UIKeyboardTypeNumberPad;
    usernameTF.delegate = self;
    usernameTF.font = [UIFont fontWithName:FONTNAME size:15.0f];
    usernameTF.placeholder = @"请输入手机号";
    usernameTF.textColor = THEME_COLOR_SMOKE;
    if (!IOS8)
    {
        usernameTF.keyboardType = UIKeyboardTypeNamePhonePad;
    }
    
    [self.view addSubview:usernameTF];
    
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMidY(backView.frame) + 7.5f + (!IOS7 ? 5 : 0), kScreenWidth - 30, 30)];
    _passwordTF.secureTextEntry = YES;
    _passwordTF.backgroundColor = [UIColor clearColor];
    _passwordTF.textColor = THEME_COLOR_SMOKE;
    _passwordTF.delegate = self;
    _passwordTF.font = [UIFont fontWithName:FONTNAME size:15.0f];
    _passwordTF.placeholder = @"请输入密码";
    [self.view addSubview:_passwordTF];
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(15, CGRectGetMaxY(backView.frame) + 20, kScreenWidth - 30, 45);
    [_loginBtn setButtonOrangeStyle];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if ([Utility validateMobile:self.usernameTF.text])
    {
        [_loginBtn setActiveState];
    }
    else
    {
        [_loginBtn setInactiveState];
    }
    
    [_loginBtn addTarget:self action:@selector(doLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"忘记密码 ?"];
    [string addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_TEXT range:NSMakeRange(0, [string length])];
    [string addAttribute:NSUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, [string length])];
//    [string addAttribute:NSFontAttributeName value:(id)[UIFont fontWithName:FONTNAME size:14.0f] range:NSMakeRange(0, [string length])];
    [string addAttribute:NSFontAttributeName value:(id)[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, [string length])];
    UILabel *forgetLab = [[UILabel alloc] initWithFrame:CGRectMake(17, CGRectGetMaxY(_loginBtn.frame) + 15, 100, 25)];
    forgetLab.backgroundColor = [UIColor clearColor];
    forgetLab.attributedText = string;
    [self.view addSubview:forgetLab];
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = forgetLab.frame;
    [forgetBtn addTarget:self action:@selector(doForget:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    [self.view addGestureRecognizer:tap];
    
    if (self.telephone != nil)
    {
        usernameTF.text = self.telephone;
        [_passwordTF becomeFirstResponder];
        [_loginBtn setActiveState];
        [MobClick event:@"get_focus_phonenumber"];
    }
    
}

#pragma mark -
#pragma mark Private method

- (void)doTap:(id)sender
{
    [self.view endEditing:YES];
}

- (void)doLogin:(id)sender
{
    [MobClick event:@"click_submit_login"];
    
    [self.view endEditing:YES];
    if(_passwordTF.text.length < 6)
    {
        [Utility showToastWithMessage:@"密码长度不能小于6位" inView:self.view];
        return;
    }
    [Utility showMBProgress:self.view message:@"登录中"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:usernameTF.text forKey:@"mobileNumber"];
    [dict setPObject:_passwordTF.text forKey:@"password"];
    [manager POST:kLogin parameters:dict queue:nil success:^(id responseObject){
        
        [Utility hideMBProgress:self.view];
        
        //普通登录 关闭新手游客引导
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:-1 forKey:kGuideStep];
        [defaults synchronize];
        
        
        NSDictionary *dataDic = (NSDictionary *)[responseObject objectForKey:@"data"];
        //用户数据保存本地
        [[HWUserLogin currentUserLogin] handleLoginInfo:dataDic operationController:self];
        
        //历史搜索存本地---yang
        NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:ksearchArr];
        if (array == nil || array.count == 0)
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSArray array] forKey: ksearchArr];
        }
        
        
    }failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        
        //用户未注册跳转到注册页面4
        
        
        if (code.intValue == kStatusQiangQianBao)
        {
//            HWRegisterFirstViewController *regVC = [[HWRegisterFirstViewController alloc] init];
//            regVC.telephoneTF.text = usernameTF.text;
            
            HWRegisterViewController *regVC = [[HWRegisterViewController alloc]init];
            [self.navigationController pushViewController:regVC animated:YES];
            AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
            [Utility showToastWithMessage:@"用户不存在,请注册" inView:appDel.window];
        }
        else
        {
            if ([error isEqual: @"密码输入错误"])
            {
                [Utility showToastMBProgress:self.view message:error imageName:@"login_error"];
            }
            else if ([error isEqual:@"您今日已经连续5次输入密码错误，该账号已被冻结，请在明日尝试登录或者点击“忘记密码”"])
            {
                HWCustomGuideAlertView *alert = [[HWCustomGuideAlertView alloc]initWithAlertType:2];
                [alert showCustomGuideAlertViewWithCompleteBlock:^(NSInteger buttonTag) {
                    
                }];
            }
            else
            {
                [Utility showToastWithMessage:error inView:self.view];
            }
        }
        
        NSLog(@"error %@",error);
    }];

}
/*
#pragma - mark 获取钱包余额
- (void)getWalletMoney
{
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager accountManager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.key forKey:@"key"];
    
    [manage POST:kWalletRemainMoney parameters:dict queue:nil success:^(id responseObject) {
        NSDictionary *respDic = (NSDictionary *)[responseObject dictionaryObjectForKey:@"data"];
        [HWUserLogin currentUserLogin].totalMoney = [respDic stringObjectForKey:@"amount"];
        NSString * _walletMoneyStr = [respDic stringObjectForKey:@"amount"];
        if([_walletMoneyStr length]==0)
        {
            _walletMoneyStr = @"0";
            [HWUserLogin currentUserLogin].totalMoney = _walletMoneyStr;
        }
        else
        {
            [HWUserLogin currentUserLogin].totalMoney = _walletMoneyStr;
        }
    } failure:^(NSString *code, NSString *error) {
        [HWUserLogin currentUserLogin].totalMoney = @"0";
    }];
}

////获取城市列表
-(void)getCityNewestList
{
    //获取所在城市的区域
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"city.txt"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSMutableArray *fileDataArry = [NSMutableArray arrayWithContentsOfFile:filePath];
        [self handleDataWithArry:fileDataArry];
    }
    else
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"txt"];
        NSMutableArray *fileDataArry = [NSMutableArray arrayWithContentsOfFile:path];
        [self handleDataWithArry:fileDataArry];
    }
    HWHTTPRequestOperationManager *managerTemp = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *dataVersionStr  =  [HWUserLogin currentUserLogin].dataVersion;
    if ([dataVersionStr isEqualToString:@""]) {
        [dict setPObject:@"0" forKey:@"dateVersion"];
    }
    else
    {
        [dict setPObject:dataVersionStr forKey:@"dateVersion"];
    }
    [HWUserLogin currentUserLogin].dataVersion = dataVersionStr;
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [managerTemp POST:kGetCityList parameters:dict queue:nil success:^(id responseObject){
        NSDictionary *dataDic = (NSDictionary*)[responseObject objectForKey:@"data"];     NSMutableArray *allCitys = [dataDic objectForKey:@"cityList"];
        [self handleDataWithArry:allCitys];
        
        dispatch_queue_t queue = dispatch_queue_create("com.dispatch.concurrent", NULL);
        dispatch_async(queue, ^{
            
            NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *savedPath=[documentsDirectory stringByAppendingPathComponent:@"city.txt"];
            [allCitys writeToFile:savedPath atomically:YES];
            NSString *cityId = [Utility getCityId:[HWUserLogin currentUserLogin].gpsCityName];
            [HWUserLogin currentUserLogin].gpsCityId = cityId;
            [HWCoreDataManager saveUserInfo];
        });
        
        [HWUserLogin currentUserLogin].dataVersion = [dataDic stringObjectForKey:@"dataVersion"];
        [HWCoreDataManager saveUserInfo];
    } failure:^(NSString *error) {
        NSLog(@"error");
        //[self startLocating];
    }];
}
 
- (void)handleDataWithArry:(NSMutableArray *)dataArry
{
    NSMutableArray *allCity = [NSMutableArray array];
    NSMutableArray *hotCity = [NSMutableArray array];
    for (int j = 0; j < dataArry.count; j++)
    {
        NSDictionary *cityDic = [dataArry pObjectAtIndex:j];
        HWCityClass *cityClass = [[HWCityClass alloc] initWithDictionary:cityDic];
        [allCity addObject:cityClass];
        
        if ([cityClass.hotStr isEqualToString:@"1"]) {
            [hotCity addObject:cityClass];
        }
    }
    [HWUserLogin currentUserLogin].cities = allCity;
    [HWUserLogin currentUserLogin].hotArry = hotCity;
}

//判断是否跳出选择区域页面（上行短信是没有选择的）
-(void)judgePopAreaPage:(NSDictionary *)dic
{
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    
    if ([user.nickname isEqualToString:@""])
    {
        HWRegisterFourthViewController *nickVC = [[HWRegisterFourthViewController alloc] init];
        nickVC.telephoneNum = user.telephoneNum;
        [self.navigationController pushViewController:nickVC animated:YES];
    }
    else if ([user.villageId isEqualToString:@""])
    {
        HWLocationChangeViewController *communityView = [[HWLocationChangeViewController alloc]init];
        communityView.locationChangeFlag = NO;
        [self.navigationController pushViewController:communityView animated:YES];
    }
    else
    {
        [APService setTags:[NSSet set] alias:@"" callbackSelector:nil object:nil];
        [APService setTags:[NSSet setWithObjects:[Utility getCityNameById:[HWUserLogin currentUserLogin].cityId], [HWUserLogin currentUserLogin].villageId, nil] alias:[HWUserLogin currentUserLogin].telephoneNum callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}
 */

- (void)doForget:(id)sender
{
    HWForgetFirstViewController *forgetVC = [[HWForgetFirstViewController alloc] init];
    forgetVC.navigationItem.titleView = [Utility navTitleView:@"忘记密码"];
    if ([Utility validateMobile:usernameTF.text])
    {
        forgetVC.telephoneNum = usernameTF.text;
    }
    forgetVC.popToViewController = self;
    [self.navigationController pushViewController:forgetVC animated:YES];
}

#pragma mark -
#pragma mark textfield delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == usernameTF)
    {
        NSMutableString *text = [textField.text mutableCopy];
        [text replaceCharactersInRange:range withString:string];
        
        if (text.length > 11 && range.length == 0)
        {
            return NO;
        }
        
//        NSLog(@"%d %d",range.location, range.length);
        
        if (text.length != 11 && IOS7)
        {
            [_loginBtn setInactiveState];
        }
        else if (![Utility validateMobile:text])
        {
            [_loginBtn setInactiveState];
        }
        else if (_passwordTF.text.length == 0)
        {
            [_loginBtn setInactiveState];
        }
        else
        {
            [_loginBtn setActiveState];
        }
    }
    else if(textField == _passwordTF)
    {
        NSMutableString *text = [textField.text mutableCopy];
        [text replaceCharactersInRange:range withString:string];
        if (usernameTF.text.length != 11 && IOS7)
        {
            [_loginBtn setInactiveState];
        }
        else if (![Utility validateMobile:usernameTF.text])
        {
            [_loginBtn setInactiveState];
        }
        else if (text.length == 0)
        {
            [_loginBtn setInactiveState];
        }
        else
        {
            [_loginBtn setActiveState];
        }
        
        if ([textField.text length] >= 20 &&range.length==0)
        {
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_passwordTF resignFirstResponder];
    [usernameTF resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (textField == usernameTF)
    {
        [_loginBtn setInactiveState];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == usernameTF)
    {
        [MobClick event:@"get_focus_phonenumberlogin"]; //maidian_1.2.1
        [MobClick event:@"get_focus_phonenumber"];
    }
    else if (textField == _passwordTF)
    {
        [MobClick event:@"get_focus_password"];
    }
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
