//
//  ChangNameViewController.m
//  Community
//
//  Created by gusheng on 14-9-6.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//      姓名         日期               修改内容
//     马一平     2015-01-22           修改昵称提交时添加去除字符串首位无效空格方法

#import "ChangNameViewController.h"
#import "HWInputBackView.h"
#import "HWRequestConfig.h"
#import "HWHTTPRequestOperationManager.h"
#import "HWCoreDataManager.h"
@interface ChangNameViewController ()
{
    UITextField *_nicknameTF;
    UIButton *_confirmBtn;
}
@end

@implementation ChangNameViewController

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
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Utility navTitleView:@"修改昵称"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    HWInputBackView *backView = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, 12, kScreenWidth, 45.0f) withLineCount:1];
    [self.view addSubview:backView];
    
    _nicknameTF = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMinY(backView.frame) + 7.5f, kScreenWidth - 30, 30)];
    _nicknameTF.textColor = THEME_COLOR_TEXT;
    _nicknameTF.placeholder = @"设置昵称";
    _nicknameTF.delegate = self;
    _nicknameTF.secureTextEntry = NO;
    _nicknameTF.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    _nicknameTF.delegate = self;
    _nicknameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nicknameTF.text = [HWUserLogin currentUserLogin].nickname;
    [self.view addSubview:_nicknameTF];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(backView.frame), kScreenWidth - 30, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    label.textColor = THEME_COLOR_TEXT;
    label.text = @"昵称长度不得大于8个中文";
    [self.view addSubview:label];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(15.0f, CGRectGetMaxY(label.frame) + 6.0f, kScreenWidth - 30.0f, 45.0f);
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_confirmBtn setButtonOrangeStyle];
    [_confirmBtn addTarget:self action:@selector(doConfirm:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
}

#pragma mark -
#pragma mark Private method
//发送修改昵称请求
- (void)sendModifyNameRequest
{
    NSString *nickname = [_nicknameTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:nickname forKey:@"nickname"];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:[HWUserLogin currentUserLogin].telephoneNum forKey:@"mobileNumber"];
    [manager POST:kSettingNickName parameters:dict queue:nil success:^(id responseObject) {
        
        [HWUserLogin currentUserLogin].nickname = nickname;
        [HWCoreDataManager saveUserInfo];
        [self.navigationController popViewControllerAnimated:YES];

    } failure:^(NSString *code, NSString *error) {
        [Utility showToastWithMessage:error inView:self.view];
        NSLog(@"error");
    }];

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
    if (_nicknameTF.text.length == 0 || [Utility isAllSpaceWithString:_nicknameTF.text])
    {
        [Utility showToastWithMessage:@"输入不能为空" inView:self.view];
        return;
    }
    
    int length = [Utility calculateTextLength:_nicknameTF.text];
    // 昵称最多8个中文字符
    if (length > 8)
    {
        [Utility showToastWithMessage:@"昵称长度不得大于8个中文" inView:self.view];
        return;
    }
    
    if ([[HWUserLogin currentUserLogin].nickname isEqualToString:_nicknameTF.text]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [self sendModifyNameRequest];
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
