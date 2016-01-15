//
//  HWMoneyPasswordController.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-7-4.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  功能描述：输入提现密码并验证的公共页面
//

#import "HWMoneyPasswordController.h"
#import "HWCashSuccessViewController.h"
#import "HWAddCardViewController.h"
#import "HWForgotMoneyPasswordController.h"
#import "SurePayController.h"
#define BLACKDOT  888
#define MAX_CONFIRM_COUNT  6

@interface HWMoneyPasswordController ()
{
    UITextView *_pwdTextView;
    int _tryCount;    // 剩余尝试次数
}

@end

@implementation HWMoneyPasswordController
@synthesize pwdModel;
@synthesize moneyNewPwd;
@synthesize tiYongInfoDic;
@synthesize bankInfo;
@synthesize money;
@synthesize totalMoney;
@synthesize logic;
@synthesize popToViewController;
@synthesize unBindCardInfo;
@synthesize tishiMode;

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
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.titleView = [Utility navTitleView:@"提现密码"];
    // 初始化 参数
    _tryCount = MAX_CONFIRM_COUNT;
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, kScreenWidth - 30, 30)];
    infoLabel.font = [UIFont fontWithName:FONTNAME size:13.0f];
    infoLabel.textColor = THEME_COLOR_TEXT;
    [self.view addSubview:infoLabel];
    
    // 绘制 密码 黑点
    for (int i = 0; i < 6; i++)
    {
        float width = 45;
        float height = 45;
        float marginLeft = (self.view.frame.size.width - width * 6 - 6 * 5) / 2.0f;  //左边距
        UIImageView *imgV = nil;
        if (marginLeft > 30)
        {
            marginLeft = 30;
            float millionWidth = (kScreenWidth - marginLeft * 2 - width * 6) / 5.0f;
            imgV = [[UIImageView alloc] initWithFrame:CGRectMake(marginLeft + i * (width + millionWidth), CGRectGetMaxY(infoLabel.frame) + 5, width, height)];
        }
        else
        {
            imgV = [[UIImageView alloc] initWithFrame:CGRectMake(marginLeft + i * (width + 6), CGRectGetMaxY(infoLabel.frame) + 5, width, height)];
        }
        
        imgV.backgroundColor = [UIColor clearColor];
        imgV.image = [UIImage imageNamed:@"passwordBlock"];
        imgV.tag = BLACKDOT + i;
        [self.view addSubview:imgV];
    }
    
    // 创建 密码输入框  设置隐藏
    _pwdTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _pwdTextView.hidden = YES;
    _pwdTextView.delegate = self;
    _pwdTextView.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_pwdTextView];
    
    // 设置提示文字
    switch (pwdModel)
    {
        case Modify_First_OldPassword:
        {
            infoLabel.text = @"请输入旧提现密码以验证身份";
            break;
        }
        case Modify_Second_NewPassword:
        {
            infoLabel.text = @"请输入新提现密码";
            break;
        }
        case Modify_Third_NewPassword:
        {
            infoLabel.text = @"请再次输入新提现密码";
            break;
        }
        case Forgot_First_NewPassword:
        {
            infoLabel.text = @"请输入新提现密码";
            break;
        }
        case Forgot_Second_NewPassword:
        {
            infoLabel.text = @"请再次输入新提现密码";
            break;
        }
        case Confirm_Password:
        {
            infoLabel.text = @"请输入提现密码";
            break;
        }
        default:
            break;
    }
    
    switch (tishiMode)
    {
        case Setting_Password:
        {
            self.navigationItem.titleView = [Utility navTitleView:@"设置提现密码"];
            infoLabel.text = @"请输入提现密码";
            break;
        }
        case SettingConfirm_Password:
        {
            self.navigationItem.titleView = [Utility navTitleView:@"设置提现密码"];
            infoLabel.text = @"请再次输入提现密码";
            break;
        }
            
        default:
            break;
    }
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    _pwdTextView.delegate = self;
    [_pwdTextView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    _pwdTextView.delegate = nil;
    [_pwdTextView resignFirstResponder];
}

#pragma mark ---------- private Method -------------

/**
 *	@brief	清空密码
 *
 *	@return	N/A
 */
- (void)clearPassword
{
    _pwdTextView.text = nil;
    for (int i = 0; i < 6; i++)
    {
        UIImageView *imgV = (UIImageView *)[self.view viewWithTag:(BLACKDOT + i)];
        imgV.image = [UIImage imageNamed:@"passwordBlock"];
    }
}

#pragma mark ------------ TextView Delegate ----------------

/**
 *	@brief	textview 输入回调 根据输入字符数控制视图中黑点个数 当输入字符为6个时执行下一步操作
 *
 *	@param 	textView 	实例变量
 *
 *	@return	N/A
 */
- (void)textViewDidChange:(UITextView *)textView
{
    
    //遍历 黑色圆点 同步输入字符个数
    for (int i = 0; i < 6; i++)
    {
        UIImageView *imgV = (UIImageView *)[self.view viewWithTag:(BLACKDOT + i)];
        if (i < textView.text.length)
        {
            imgV.image = [UIImage imageNamed:@"passwordBlock2"];
        }
        else
        {
            imgV.image = [UIImage imageNamed:@"passwordBlock"];
        }
    }
    
    //输入完成后自动执行下一步
    if (textView.text.length == 6)
    {
        // 验证密码
        if (pwdModel == Modify_First_OldPassword)
        {
            [Utility showMBProgress:self.view message:LOADING_TEXT];
            HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
            [param setPObject:textView.text forKey:@"withdrawPasswd"];
            [param setPObject:@"1" forKey:@"channel"];
            
            [manager redPacketPost:kCheckMoneyPassword parameters:param queue:nil success:^(id responseObject) {
                [Utility hideMBProgress:self.view];
                
                // 验证成功 执行下一步
                HWMoneyPasswordController *moneyPwdVC = [[HWMoneyPasswordController alloc] init];
                moneyPwdVC.PwdModel = Modify_Second_NewPassword;
                [self.navigationController pushViewController:moneyPwdVC animated:YES];

            } failure:^(NSString *code, NSString *error) {
                [Utility hideMBProgress:self.view];
                //弹出alert
                if ([error hasPrefix:@"输入密码错误"] || [error hasPrefix:@"账户已被锁定"])
                {
                    [self clearPassword];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"忘记密码", nil];
                    [alert show];
                }
                else
                {
                    [Utility showToastWithMessage:error inView:self.view];
                }

            }];
        }
        else if (pwdModel == Modify_Second_NewPassword)
        {
            HWMoneyPasswordController *moneyPwdVC = [[HWMoneyPasswordController alloc] init];
            moneyPwdVC.PwdModel = Modify_Third_NewPassword;
            moneyPwdVC.moneyNewPwd = textView.text;
            [self.navigationController pushViewController:moneyPwdVC animated:YES];
        }
        else if (pwdModel == Modify_Third_NewPassword)
        {
            if (![self.moneyNewPwd isEqualToString:textView.text])
            {
                [Utility showToastWithMessage:@"密码不一致" inView:self.view];
                [self clearPassword];
                return;
            }
            //  设置新密码
            
            [Utility showMBProgress:self.view message:LOADING_TEXT];
            HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
            [param setPObject:textView.text forKey:@"withdrawPasswd"];
            [param setPObject:@"1" forKey:@"channel"];
            
            [manager redPacketPost:kSetNewMoneyPassword parameters:param queue:nil success:^(id responseObject) {
                [Utility hideMBProgress:self.view];
                //成功修改密码
                [Utility showToastWithMessage:@"设置成功" inView:self.view];
                [self.navigationController popToRootViewControllerAnimated:YES];

            } failure:^(NSString *code, NSString *error) {
                [Utility hideMBProgress:self.view];
                [Utility showToastWithMessage:error inView:self.view];

            }];
        }
        else if (pwdModel == Forgot_First_NewPassword)
        {
            HWMoneyPasswordController *moneyPwdVC = [[HWMoneyPasswordController alloc] init];
            moneyPwdVC.PwdModel = Forgot_Second_NewPassword;
            moneyPwdVC.moneyNewPwd = textView.text;
            moneyPwdVC.logic = self.logic;
            moneyPwdVC.popToViewController = self.popToViewController;
            moneyPwdVC.tishiMode = SettingConfirm_Password;
            [self.navigationController pushViewController:moneyPwdVC animated:YES];
        }
        else if (pwdModel == Forgot_Second_NewPassword)
        {
            if (![self.moneyNewPwd isEqualToString:textView.text])
            {
                [Utility showToastWithMessage:@"密码不一致" inView:self.view];
                [self clearPassword];
                return;
            }
            //  设置新密码
            
            [Utility showMBProgress:self.view message:LOADING_TEXT];
            HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
            [param setPObject:textView.text forKey:@"withdrawPasswd"];
            [param setPObject:@"1" forKey:@"channel"];
            
            [manager redPacketPost:kSetNewMoneyPassword parameters:param queue:nil success:^(id responseObject) {
                [Utility hideMBProgress:self.view];
                [Utility showToastWithMessage:@"设置成功" inView:self.view];
                
                if (self.logic == LogicLine_GetMoney)
                {
                    HWAddCardViewController *bindVC = [[HWAddCardViewController alloc] init];
                    bindVC.logic = self.logic;
                    [self.navigationController pushViewController:bindVC animated:YES];
                }
                else if (self.logic == LogicLine_BindCard)
                {
                    HWAddCardViewController *bindVC = [[HWAddCardViewController alloc] init];
                    bindVC.logic = LogicLine_BindCard;
                    bindVC.popToViewController = self.popToViewController;
                    [self.navigationController pushViewController:bindVC animated:YES];
                }
                else
                {
                    if (self.popToViewController != nil)
                    {
                        [self.navigationController popToViewController:self.popToViewController animated:YES];
                    }
                }
                

            } failure:^(NSString *code, NSString *error) {
                [Utility hideMBProgress:self.view];
                [Utility showToastWithMessage:error inView:self.view];

            }];
        }
        else if (pwdModel == Confirm_Password)
        {
            [Utility showToastWithMessage:@"密码验证中..." inView:self.view];
            
            if (self.logic == LogicLine_BindCard)
            {
                HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
                [param setPObject:textView.text forKey:@"withdrawPasswd"];
                [param setPObject:@"1" forKey:@"channel"];
                
                [manager redPacketPost:kCheckMoneyPassword parameters:param queue:nil success:^(id responseObject) {
                    [Utility hideMBProgress:self.view];
                    
                    // 验证成功 执行下一步
                    HWAddCardViewController *bindCardVC = [[HWAddCardViewController alloc] init];
                    if (self.popToViewController != nil)
                    {
                        bindCardVC.popToViewController = self.popToViewController;
                    }
                    bindCardVC.logic = LogicLine_BindCard;
                    [self.navigationController pushViewController:bindCardVC animated:YES];

                } failure:^(NSString *code, NSString *error) {
                    [Utility hideMBProgress:self.view];
                    
                    if ([error hasPrefix:@"输入密码错误"] || [error hasPrefix:@"账户已被锁定"])
                    {
                        [self clearPassword];
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"忘记密码", nil];
                        [alert show];
                    }
                    else
                    {
                        [Utility showToastWithMessage:error inView:self.view];
                    }

                }];
            }
            else if (self.logic == LogicLine_GetMoney)
            {
                HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
                [param setPObject:textView.text forKey:@"withdrawPasswd"];
                [param setPObject:@"1" forKey:@"channel"];
                
                [manager redPacketPost:kCheckMoneyPassword parameters:param queue:nil success:^(id responseObject) {
                    [Utility hideMBProgress:self.view];
                    
                    // 验证成功 执行下一步
                    HWAddCardViewController *bindCardVC = [[HWAddCardViewController alloc] init];
                    bindCardVC.logic = LogicLine_GetMoney;
                    [self.navigationController pushViewController:bindCardVC animated:YES];
                    

                } failure:^(NSString *code, NSString *error) {
                    [Utility hideMBProgress:self.view];
                    
                    if ([error hasPrefix:@"输入密码错误"] || [error hasPrefix:@"账户已被锁定"])
                    {
                        [self clearPassword];
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"忘记密码", nil];
                        [alert show];
                    }
                    else
                    {
                        [Utility showToastWithMessage:error inView:self.view];
                    }

                }];
            }
            else if (self.logic == LoginLine_UnBindCard)
            {
                HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
                [param setPObject:textView.text forKey:@"withdrawPasswd"];
                [param setPObject:@"1" forKey:@"channel"];
                
                [manager redPacketPost:kCheckMoneyPassword parameters:param queue:nil success:^(id responseObject) {
                    [Utility hideMBProgress:self.view];
                    
                    // 验证成功 执行下一步
                    if (self.unBindCardInfo != nil)
                    {
                        [self deleteCard];
                    }

                } failure:^(NSString *code, NSString *error) {
                    [Utility hideMBProgress:self.view];
                    
                    if ([error hasPrefix:@"输入密码错误"] || [error hasPrefix:@"账户已被锁定"])
                    {
                        [self clearPassword];
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"忘记密码", nil];
                        [alert show];
                    }
                    else
                    {
                        [Utility showToastWithMessage:error inView:self.view];
                    }

                }];
            }
            else
            {
                // 验证成功 执行下一步
                [self getMoneyMethod];
            }
        }
    }
    else if (textView.text.length > 6)
    {
        // 保障输入为6位数字
        textView.text = [textView.text substringToIndex:6];
    }
    
}
-(void)delayMethod
{
    NSArray *controlS = [self.navigationController viewControllers];
    
    for(id viewController in controlS)
    {
        if ([viewController isKindOfClass:[SurePayController class]])
        {
            [self.navigationController popToViewController:viewController animated:YES];
        }
    }

}
/**
 *	@brief	执行提现操作
 *
 *	@return	N/A
 */
- (void)getMoneyMethod
{
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    //入参：key[],  amount[提取金额]&loginPassword[登录密码]&bankId[银行卡Id]&balance[余额]
    //出参: {-2 密码错误 -1 不可以提取佣金 1申请提取成功}
//    [MobClick event:@"click_finish_cash"];
    
    if (self.tiYongInfoDic == nil)
    {
        [Utility hideMBProgress:self.view];
        NSLog(@"提现参数为空");
        return;
    }
    
    [self.tiYongInfoDic setPObject:_pwdTextView.text forKey:@"loginPassword"];
    [self.tiYongInfoDic setPObject:@"1" forKey:@"channel"];
    
    [manager redPacketPost:kTiyong parameters:self.tiYongInfoDic queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
        
        NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
        NSString *code = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"code"]];
        
        if ([code integerValue] == -2)
        {
            [Utility showToastWithMessage:@"密码错误" inView:self.view];
        }
        else if ([code integerValue] == -1)
        {
            [Utility showToastWithMessage:@"提现失败" inView:self.view];
        }
        else if ([code integerValue] == -3)
        {
            [Utility showToastWithMessage:@"提现金额不能大于总金额" inView:self.view];
        }
        else if ([code integerValue] == -4)
        {
            [Utility showToastWithMessage:@"未实名认证" inView:self.view];
        }
        else if ([code integerValue]==-5)
        {
            [Utility showToastWithMessage:@"实名认证，正在审核中" inView:self.view];
        }
        else if ([code integerValue]==-6)
        {
            [Utility showToastWithMessage:@"实名认证,未通过" inView:self.view];
        }
        else if ([code integerValue]==1)
        {
            [Utility showToastWithMessage:@"提佣成功" inView:self.view];
            
            NSDictionary *applyDic = [dataDic dictionaryObjectForKey:@"applyMoneyBean"];
            NSString *recordId = [NSString stringWithFormat:@"%@",[applyDic objectForKey:@"recordId"]];
            
            HWCashSuccessViewController *cashVC = [[HWCashSuccessViewController alloc] init];
            cashVC.bank = self.bankInfo;
            cashVC.money = self.money;
            cashVC.restMoney = [NSString stringWithFormat:@"%.1f",([self.totalMoney floatValue] - [self.money floatValue])];
            cashVC.cashDetailID = recordId;
            //        cashVC.restMoney = [NSString stringWithFormat:@"%d",_totalMoney.intValue - _moneyTF.text.intValue];
            [self.navigationController pushViewController:cashVC animated:YES];
        }

    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        
        if ([error hasPrefix:@"输入密码错误"] || [error hasPrefix:@"账户已被锁定"])
        {
            [self clearPassword];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"忘记密码", nil];
            [alert show];
        }
        else
        {
            [Utility showToastWithMessage:error inView:self.view];
        }

    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        //忘记密码
        HWForgotMoneyPasswordController *forgotVC = [[HWForgotMoneyPasswordController alloc] init];
        forgotVC.navigationItem.titleView = [Utility navTitleView:@"忘记提现密码"];
        [self.navigationController pushViewController:forgotVC animated:YES];
    }
}

/**
 *	@brief	解除绑定银行卡
 *
 *	@return	N/A
 */
- (void)deleteCard
{
    // 解除绑定
    [Utility showMBProgress:self.view message:@"发送数据"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    [self.unBindCardInfo setPObject:@"1" forKey:@"channel"];
    [self.unBindCardInfo setObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    [manager redPacketPost:kDeleteCard parameters:self.unBindCardInfo queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:@"解绑成功" inView:self.view.window];
        [self.navigationController popToViewController:self.popToViewController animated:YES];
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view.window];

    }];
}


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
