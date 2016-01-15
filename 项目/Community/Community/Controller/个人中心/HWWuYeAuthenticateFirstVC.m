//
//  HWWuYeAuthenticateFirstVC.m
//  Community
//
//  Created by niedi on 15/8/4.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYeAuthenticateFirstVC.h"
#import "HWWuYeAuthenticateScdVC.h"

@interface HWWuYeAuthenticateFirstVC ()<UITextFieldDelegate>
{
    UIButton *_authenticateBtn;
    UITextField *_nameTF;
}
@end

@implementation HWWuYeAuthenticateFirstVC

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
    
    _nameTF = [[HWTextField alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 2 * 25 - 2 * 10, 45)];
    _nameTF.placeholder = @"输入真实姓名";
    _nameTF.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    _nameTF.textColor = THEME_COLOR_SMOKE;
    _nameTF.keyboardType = UIKeyboardTypeDefault;
    _nameTF.delegate = self;
    _nameTF.returnKeyType = UIReturnKeyDone;
    _nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [tFBackV addSubview:_nameTF];
    
    _authenticateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _authenticateBtn.frame = CGRectMake(15, CGRectGetMaxY(tFBackV.frame) + 40, kScreenWidth - 30, 45);
    [_authenticateBtn setButtonOrangeStyle];
    [_authenticateBtn setTitle:@"申请认证" forState:UIControlStateNormal];
    [_authenticateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_authenticateBtn addTarget:self action:@selector(authenticateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backV addSubview:_authenticateBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)doTap:(id)sender
{
    [self.view endEditing:YES];
}

- (void)authenticateBtnClick
{
    if(_nameTF.text.length == 0)
    {
        [Utility showToastWithMessage:@"请输入姓名" inView:self.view];
        return;
    }
    
    [self.view endEditing:YES];
    
    /*URL:/hw-sq-app-web/userCertification/shortcutAuthenticationApply.do
     参数：
     applyId 申请id
     addresseeName 姓名
     key
     返回json*/
    
    [Utility hideMBProgress:self.view];
    [Utility showMBProgress:self.view message:@"请求数据"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    [parame setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [parame setPObject:[defaults objectForKey:kAuthApplyId] forKey:@"applyId"];
    [parame setPObject:_nameTF.text forKey:@"addresseeName"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KWuYeAuthenticate parameters:parame queue:nil success:^(id responese)
     {
         [Utility hideMBProgress:self.view];
         
         HWWuYeAuthenticateScdVC *svc = [[HWWuYeAuthenticateScdVC alloc] init];
         svc.isPopFourVC = YES;
         [self.navigationController pushViewController:svc animated:YES];
         
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
