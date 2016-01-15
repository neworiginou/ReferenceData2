//
//  WYYCBindingAccountViewController.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/23.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCBindingAccountViewController.h"

@interface WYYCBindingAccountViewController ()
//支付宝View
@property (weak, nonatomic) IBOutlet UIView *BundingZhifubaoAccountView;
//银行View
@property (weak, nonatomic) IBOutlet UIView *BundingBankAccountView;
// 提现Veiw
@property (weak, nonatomic) IBOutlet UIView *withdrawView;


//支付宝账户
@property (weak, nonatomic) IBOutlet UITextField *zhifubaoAccount;
//支付宝用户名
@property (weak, nonatomic) IBOutlet UITextField *zhifubaoUserName;
//提交－支付宝
- (IBAction)BundingZhifubao:(id)sender;
//银行账户
@property (weak, nonatomic) IBOutlet UITextField *bankAccount;
//姓名
@property (weak, nonatomic) IBOutlet UITextField *bankUserName;
//开户行
@property (weak, nonatomic) IBOutlet UITextField *bankType;
//提交－银行
- (IBAction)bundingBankAccount:(id)sender;
//显示绑定支付宝账户View
- (IBAction)showBindingZhifubaoAccountView:(id)sender;
//显示绑定银行账户View
- (IBAction)showBindingBankAccountView:(id)sender;
//绑定支付宝button
@property (weak, nonatomic) IBOutlet UIButton *zhifubaoButton;
//绑定银行卡button
@property (weak, nonatomic) IBOutlet UIButton *bankButton;
//提现金额
@property (weak, nonatomic) IBOutlet UITextField *withdrawMoney;
//可提现金额
@property (weak, nonatomic) IBOutlet UILabel *availableWithdrawMoney;

@property (nonatomic,assign) BOOL isBundingAccount;
//提现
- (IBAction)withdraw:(id)sender;


@end

@implementation WYYCBindingAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *userDefault= [NSUserDefaults standardUserDefaults];
    self.isBundingAccount=[[userDefault valueForKey:@"isBundingAccount"] boolValue];
    
    if (self.isBundingAccount) {
        self.BundingBankAccountView.hidden=YES;
        self.BundingZhifubaoAccountView.hidden=YES;
        self.title=@"提现";
    }else{
        self.title = @"绑定账户";
        self.BundingBankAccountView.hidden = YES;
        self.zhifubaoButton.enabled = 0;
        self.withdrawView.hidden=YES;
    }
    

    
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)BundingZhifubao:(id)sender {
    
    self.isBundingAccount = YES;
    
    NSUserDefaults *userDefault= [NSUserDefaults standardUserDefaults];
    [userDefault setBool:self.isBundingAccount forKey:@"isBundingAccount"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}
- (IBAction)bundingBankAccount:(id)sender {
    
    self.isBundingAccount = YES;
   NSUserDefaults *userDefault= [NSUserDefaults standardUserDefaults];
    [userDefault setBool:self.isBundingAccount forKey:@"isBundingAccount"];
    
    [userDefault synchronize];
    

}

- (IBAction)showBindingZhifubaoAccountView:(UIButton *)sender {
    self.zhifubaoButton.enabled = 0;
    self.bankButton.enabled = 1;
    self.BundingZhifubaoAccountView.hidden = 0;
     self.BundingBankAccountView.hidden = 1;
    
}

- (IBAction)showBindingBankAccountView:(UIButton *)sender {
    self.zhifubaoButton.enabled = 1;
    self.bankButton.enabled = 0;
    self.BundingBankAccountView.hidden = 0;
    self.BundingZhifubaoAccountView.hidden = 1;
}

- (IBAction)withdraw:(id)sender {
}
@end
