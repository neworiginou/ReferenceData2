//
//  HWChangeViewController.m
//  Community
//
//  Created by zhangxun on 14-9-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWChangeViewController.h"
#import "HWHomePageViewController.h"
#import "AppDelegate.h"

@interface HWChangeViewController ()

@end

@implementation HWChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tf1 = [[HWChangeTextField alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 45)];
    _tf1.placeholder = @"请输入当前密码";
    _tf1.delegate = self;
    [self.view addSubview:_tf1];   
    
    _tf2 = [[HWChangeTextField alloc]initWithFrame:CGRectMake(0, 65, kScreenWidth, 45)];
    _tf2.placeholder = @"请输入新密码";
    _tf2.delegate= self;
    [self.view addSubview:_tf2];
    
    _tf3 = [[HWChangeTextField alloc]initWithFrame:CGRectMake(0, 110 - 0.5f, kScreenWidth, 45)];
    _tf3.placeholder = @"请再次输入新密码";
    _tf3.delegate = self;
    [self.view addSubview:_tf3];
    
//    self.view.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
    self.navigationItem.titleView= [Utility navTitleView:@"修改密码"];
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"提交" action:@selector(doChange)];
    
    
}


- (void)doChange{
    if (_tf1.text.length == 0) {
        [Utility showToastWithMessage:@"请输入当前密码" inView:self.view];
        return;
    }
    if (_tf2.text.length == 0) {
        [Utility showToastWithMessage:@"请输入新密码" inView:self.view];
        return;
    }
    if (_tf3.text.length == 0) {
        [Utility showToastWithMessage:@"请输入确认密码" inView:self.view];
        return;
    }
    if (![_tf2.text isEqualToString:_tf3.text]) {
        [Utility showToastWithMessage:@"两次密码输入不一致" inView:self.view];
        return;
    }
    if (![Utility validatePassword:_tf2.text]){
        [Utility showToastWithMessage:@"密码过于简单，请重新输入" inView:self.view];
        return;
    }
    if ([_tf1.text isEqualToString:_tf2.text] && [_tf1.text isEqualToString:_tf3.text]) {
        [Utility showToastWithMessage:@"新密码与原密码不能一致" inView:self.view];
        return;
    }
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dic setObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
    [dic setObject:_tf2.text forKey:@"newPass"];
    [dic setObject:_tf1.text forKey:@"oldPass"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kSetPass parameters:dic queue:nil success:^(id responseObject) {
        
        AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
        [Utility showToastWithMessage:[responseObject stringObjectForKey:@"detail"] inView:appDel.window];
        HWHomePageViewController *homePageVC = [[HWHomePageViewController alloc] init];
        HWBaseNavigationController *nav = [[HWBaseNavigationController alloc] initWithRootViewController:homePageVC];
        [appDel.window.rootViewController presentViewController:nav animated:NO completion:nil];
        //        [homePageVC toLogin:nil];
        [homePageVC gotoLogin:[HWUserLogin currentUserLogin].telephoneNum];
        
        [[HWUserLogin currentUserLogin] userLogout];
        
    } failure:^(NSString *code, NSString *error) {
        [Utility showToastWithMessage:error inView:self.view];
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *beStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (beStr.length > 20) {
        return NO;
    }
    return YES;
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
