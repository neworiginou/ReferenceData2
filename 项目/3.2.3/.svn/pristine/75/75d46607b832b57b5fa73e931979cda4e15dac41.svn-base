//
//  ExtractViewController.m
//  HaoWu_4.0
//
//  Created by zhangxun on 14-5-24.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  功能描述：提现页面
//  修改记录：
//      蔡景鹏 2014-7-8    添加验证提现密码，删除登录密码

#import "ExtractViewController.h"
#import "HWAddCardViewController.h"
#import "HWCashSuccessViewController.h"
#import "HWMoneyPasswordController.h"
#import "HWInputBackView.h"
#import "Partner_Swift-Swift.h"
#import "Define-OC.h"

@interface ExtractViewController ()
{
    UILabel *_bankCardLabel;
    UIButton *_confirmButton;
    BOOL isEnableGetMoney;
    UIScrollView *_mainSV;
}

@end

@implementation ExtractViewController

@synthesize totalMoney;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.titleView =[Utility navTitleView:@"提现"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_moneyTF resignFirstResponder];
    [_passTF resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self _selector:@selector(backMethod)];
    
    _mainSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    [self.view addSubview:_mainSV];
    
    
    isEnableGetMoney = YES;
    
    HWInputBackView *backView = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, /*CGRectGetMaxY(tipLabel.frame) +*/ 10, kScreenWidth, 90) withLineCount:2];
    [_mainSV addSubview:backView];
    
    
    _bankCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(backView.frame.origin.x + 10, backView.frame.origin.y + 7.5f, CGRectGetWidth(backView.frame) - 20, 30)];
    _bankCardLabel.backgroundColor = [UIColor clearColor];
    _bankCardLabel.font = [UIFont fontWithName:FONTNAME size:15.0f];
#warning color
//    _bankCardLabel.textColor = THEME_COLOR_SMOKE;
    [_mainSV addSubview:_bankCardLabel];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8.0f, 14.0f)];
    imgV.backgroundColor = [UIColor clearColor];
    imgV.image = [UIImage imageNamed:@"arrow_next"];
    imgV.center = CGPointMake(_bankCardLabel.center.x + 145, _bankCardLabel.center.y);
    [_mainSV addSubview:imgV];
    
    _selectBankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectBankBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectBankBtn.backgroundColor = [UIColor clearColor];
    _selectBankBtn.frame = CGRectMake(0, backView.frame.origin.y + 10, kScreenWidth - 40.0f, 30);
    [_selectBankBtn addTarget:self action:@selector(doSelectBank:) forControlEvents:UIControlEventTouchUpInside];
    [_mainSV addSubview:_selectBankBtn];
    
    _moneyTF = [[UITextField alloc]initWithFrame:CGRectMake(backView.frame.origin.x + 10, CGRectGetMaxY(_selectBankBtn.frame) + 13, kScreenWidth - 40.0f, 30)];
    _moneyTF.leftViewMode = UITextFieldViewModeAlways;
    _moneyTF.placeholder = @"请输入100整数倍的金额";
    _moneyTF.delegate = self;
    _moneyTF.font = [UIFont fontWithName:FONTNAME size:15.0f];
#warning color
//    _moneyTF.textColor = THEME_COLOR_SMOKE;
    _moneyTF.keyboardType = UIKeyboardTypeNumberPad;
    [_mainSV addSubview:_moneyTF];
    
    _infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(backView.frame) + 10 , kScreenWidth - 20.0f, 40)];
    _infoLabel.font = [UIFont fontWithName:FONTNAME size:13];
#warning color
//    _infoLabel.textColor = THEME_COLOR_TEXT;
    _infoLabel.text = [NSString stringWithFormat:@"提现：一周仅限提现一次。"];
    _infoLabel.backgroundColor =[UIColor clearColor];
    _infoLabel.numberOfLines = 0;
    _infoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_mainSV addSubview:_infoLabel];
    
    
    
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmButton.frame = CGRectMake(12.0f, CGRectGetMaxY(_infoLabel.frame) + 10, kScreenWidth - 24.0f, 50);
    [_confirmButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _confirmButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:15.0f];
//    [_confirmButton setButtonBackgroundImageandHighlightImage];
#warning color
//    [_confirmButton setButtonOrangeStyle];
    [_confirmButton setButtonRedAndOrangeBorderStyle];
    [_confirmButton addTarget:self action:@selector(doConfirm) forControlEvents:UIControlEventTouchUpInside];
    [_mainSV addSubview:_confirmButton];
    
    [self requestLastTime];
#warning warning money num
//    self.totalMoney = [HWUserLogin currentUserLogin].totalMoney;
    
}

/**
 *	@brief	获取最后提现时间及默认银行卡信息
 *
 *	@return	N/A
 */
- (void)requestLastTime
{
//    [Utility showMBProgress:self.view message:LOADING_TEXT];
    HWHttpRequestOperationManager *manager = [HWHttpRequestOperationManager baseManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:@"1" forKey:@"channel"];

    [manager postHttpRequest:kGetLastPay parameters:param queue:nil success:^(NSDictionary *responseObject) {
        [Utility hideMBProgress:self.view];
        
        NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
        
        if ([[dataDic stringObjectForKey:@"time"] isEqualToString:@""])
        {
            _infoLabel.text = @"提示：一周仅限提现一次。";
#warning color
//            [_confirmButton setButtonOrangeStyle];
            _confirmButton.userInteractionEnabled = YES;
            isEnableGetMoney = YES;
        }
        else
        {
            NSString *time = [dataDic stringObjectForKey:@"time"];
            NSDateFormatter *formate = [[NSDateFormatter alloc] init];
            [formate setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSDate *date = [formate dateFromString:time];
            NSDate *tDate = [date dateByAddingTimeInterval:7*24*60*60];
            NSDate *today = [NSDate date];
            if ([today compare:tDate] == NSOrderedAscending)
            {
                isEnableGetMoney = NO;
            }
            else
            {
                isEnableGetMoney = YES;
            }
            _infoLabel.text = [NSString stringWithFormat:@"提示：您上次提现日期%@，\n一周仅限提现一次。",[dataDic stringObjectForKey:@"time"]];
        }
        
        if ([[dataDic objectForKey:@"bankCardBean"] isKindOfClass:[NSNull class]])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还未绑定银行卡，需要添加银行卡吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            return ;
        }
        else if ([[dataDic objectForKey:@"bankCardBean"] isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dic = [dataDic objectForKey:@"bankCardBean"];
            NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
            [tempDic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"bankId"]] forKey:@"brokerBankId"];
            [tempDic setObject:[dic objectForKey:@"cardNo"] forKey:@"cardNo"];
            [tempDic setObject:[dic objectForKey:@"bankName"] forKey:@"bankName"];
            
            _selectBankInfo = tempDic;
            [self reloadBankButton];
        }

    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
    }];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        HWAddCardViewController *addCardVC = [[HWAddCardViewController alloc] init];
        addCardVC.popToViewController = self.popToViewController;
        [self.navigationController pushViewController:addCardVC animated:YES];
    }
}

/**
 *	@brief	点击选择银行卡
 *
 *	@param 	sender
 *
 *	@return	N/A
 */
- (void)doSelectBank:(id)sender
{
//    [MobClick event:@"change_card"];
    HWMyCardViewController *cardVC = [[HWMyCardViewController alloc] init];
    cardVC.isSelectMode = YES;
    cardVC.delegate = self;
    cardVC.selectedBank = _selectBankInfo;
    [self.navigationController pushViewController:cardVC animated:YES];
    
}

/**
 *	@brief	选择银行卡回调函数
 *
 *	@param 	cardInfo 	所选银行卡信息
 *
 *	@return	N/A
 */
- (void)selectedMyCardWithInfo:(NSDictionary *)cardInfo
{
    _selectBankInfo = cardInfo;
    [self reloadBankButton];
}

/**
 *	@brief	刷新银行卡按钮title
 *
 *	@return	N/A
 */
- (void)reloadBankButton
{
    NSMutableString *cardNo = [NSMutableString stringWithString:[_selectBankInfo stringObjectForKey:@"cardNo"]];
    NSString *str;
    if (cardNo.length > 4)
    {
        str = [cardNo substringFromIndex:(cardNo.length - 4)];
    }
    else
    {
        str = cardNo;
    }
    _bankCardLabel.text = [NSString stringWithFormat:@"%@(尾号%@)",[_selectBankInfo stringObjectForKey:@"bankName"],str];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    [MobClick event:@"cash_amount"];
}

/**
 *	@brief	确认提现
 *
 *	@return	N/A
 */
- (void)doConfirm
{
//    [MobClick event:@"click_next_cash"];
    
    if (!isEnableGetMoney)
    {
        [Utility showToastWithMessage:@"一周只能提现一次" _view:self.view];
        return;
    }
    int money = _moneyTF.text.intValue;
    if (money == 0)
    {
        [Utility showToastWithMessage:@"提现金额不能为空" _view:self.view];
        return;
    }
//    else if (money > totalMoney.floatValue)
//    {
//        [Utility showToastWithMessage:@"账户余额不足" _view:self.view];
//        return;
//    }
    else if (money % 100 != 0 || money < 100)
    {
        [Utility showToastWithMessage:@"请输入100整数倍的金额" _view:self.view];
        return;
    }
    
    //入参：key[],  amount[提取金额]&loginPassword[登录密码]&bankId[银行卡Id]&balance[余额]
    //出参: {-2 密码错误 -1 不可以提取佣金 1申请提取成功}
//    [MobClick event:@"click_finish_cash"];
    NSMutableDictionary *postDict = [NSMutableDictionary dictionary];
    [postDict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [postDict setPObject:_moneyTF.text forKey:@"amount"];
    [postDict setPObject:[NSString stringWithFormat:@"%@",[_selectBankInfo objectForKey:@"brokerBankId"]] forKey:@"bankId"];
    //    [postDict setPObject:@"123123" forKey:@"bankId"];
    [postDict setPObject:totalMoney forKey:@"balance"];
    
    // 验证提现密码
    HWMoneyPasswordController *checkPwdVC = [[HWMoneyPasswordController alloc] init];
    checkPwdVC.pwdModel = Confirm_Password;
    checkPwdVC.tiYongInfoDic = postDict;
    checkPwdVC.bankInfo = _selectBankInfo;
    checkPwdVC.money = _moneyTF.text;
    checkPwdVC.totalMoney = totalMoney;
    checkPwdVC.popToViewController = self.popToViewController;
    [self.navigationController pushViewController:checkPwdVC animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
