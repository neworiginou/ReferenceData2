//
//  HWWuYeAuthenticateScdVC.m
//  Community
//
//  Created by niedi on 15/8/4.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYeAuthenticateScdVC.h"
#import "AppDelegate.h"

@interface HWWuYeAuthenticateScdVC ()<UITextFieldDelegate>
{
    UIButton *_authenticateBtn;
    UITextField *_passWordTF;
}
@end

@implementation HWWuYeAuthenticateScdVC

- (void)viewWillAppear:(BOOL)animated
{
    if (self.isPopFourVC)
    {
        MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
        navigation.canDragBack = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.isPopFourVC)
    {
        MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
        navigation.canDragBack = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"认证"];
    
    DView *backV = [DView viewFrameX:0 y:10.0f w:kScreenWidth h:CONTENT_HEIGHT - 10];
    backV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backV];
    
    DView *tFBackV = [DView viewFrameX:25.0f y:25.0f w:kScreenWidth - 2 * 25 h:45.0f];
    tFBackV.layer.borderColor = THEME_COLOR_LINE.CGColor;
    tFBackV.layer.cornerRadius = 2.5f;
    tFBackV.layer.borderWidth = 0.5f;
    [backV addSubview:tFBackV];
    
    _passWordTF = [[HWTextField alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 2 * 25 - 2 * 10, 45)];
    _passWordTF.placeholder = @"输入验证码";
    _passWordTF.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    _passWordTF.textColor = THEME_COLOR_SMOKE;
    _passWordTF.delegate = self;
    _passWordTF.keyboardType = UIKeyboardTypeDefault;
    _passWordTF.returnKeyType = UIReturnKeyDone;
    _passWordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [tFBackV addSubview:_passWordTF];
    
    DLable *infoLab = [DLable LabTxt:@"如无验证码，咨询物业工作人员" txtFont:TF12 txtColor:THEME_COLOR_TEXT frameX:35.0f y:CGRectGetMaxY(tFBackV.frame) w:kScreenWidth - 35 - 15 h:25];
    [backV addSubview:infoLab];
    
    _authenticateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _authenticateBtn.frame = CGRectMake(15, CGRectGetMaxY(tFBackV.frame) + 40, kScreenWidth - 30, 45);
    [_authenticateBtn setButtonOrangeStyle];
    [_authenticateBtn setTitle:@"认证" forState:UIControlStateNormal];
    [_authenticateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_authenticateBtn addTarget:self action:@selector(authenticateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backV addSubview:_authenticateBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)backMethod
{
    if (self.isPopFourVC)
    {
        NSArray *vcArr = self.navigationController.viewControllers;
        UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 5];
        [self.navigationController popToViewController:lastScdVC animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)doTap:(id)sender
{
    [self.view endEditing:YES];
}

- (void)authenticateBtnClick
{
    if(_passWordTF.text.length == 0)
    {
        [Utility showToastWithMessage:@"请输入验证码" inView:self.view];
        return;
    }
    
    [self.view endEditing:YES];
    
    /*URL:/hw-sq-app-web/userCertification/shortcutAuthentication.do
     参数：
     applyId 申请id
     password 验证码
     key
     返回json*/
    
    [Utility hideMBProgress:self.view];
    [Utility showMBProgress:self.view message:@"请求数据"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    [parame setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [parame setPObject:[defaults objectForKey:kAuthApplyId] forKey:@"applyId"];
    [parame setPObject:_passWordTF.text forKey:@"password"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KWuYeAuthenticateConfirm parameters:parame queue:nil success:^(id responese)
     {
         [Utility hideMBProgress:self.view];
         
         AppDelegate *del = (AppDelegate *)SHARED_APP_DELEGATE;
         [Utility showToastWithMessage:@"认证成功" inView:del.window];
         [HWUserLogin currentUserLogin].isAuth = @"0";
         [self backMethod];
         
     } failure:^(NSString *code, NSString *error) {
         
         [Utility hideMBProgress:self.view];
         [Utility showToastWithMessage:error inView:self.view];
     }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
