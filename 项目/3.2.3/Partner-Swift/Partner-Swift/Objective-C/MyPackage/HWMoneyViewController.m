//
//  HWMoneyViewController.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-20.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//


#import "HWMoneyViewController.h"
#import "PurseTableViewCell.h"
#import "WalletDetailViewController.h"
#import "HWForgotMoneyPasswordController.h"
#import <CoreText/CoreText.h>
#import "HWMyCardViewController.h"
#import "HWMoneyPasswordManagerController.h"
#import "HWAddCardViewController.h"
#import "HWMoneyPasswordController.h"
#import "ExtractViewController.h"
#import "Partner_Swift-Swift.h"
#import "Define-OC.h"
#import "Utility-OC.h"


#define SELECT_VIEW_TAG         777
#define kBackHeight             (165 + 38)//add by
#define kCalculateTime          15
#define kRedCountTag            999
#define ALERT_GETMONEY_TAG      1001
#define ALERT_BIND_TAG          1002
#define MONEY_TAG               1003

@interface HWMoneyViewController ()
{
    NSString *typeStr;
    NSString *redPaperNum;//红包数量
}
@end

@implementation HWMoneyViewController
@synthesize totalMoney;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryListData) name:kRefreshWallet object:nil];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self queryListData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self hideSelectView];
}

-(void)backMethod
{
//    HWPersonalCenterViewController * VC = [[HWPersonalCenterViewController alloc]init];
//    [self.navigationController popToViewController:VC animated:true];
      [[NSNotificationCenter defaultCenter]postNotificationName:@"kGetIntegral" object:nil];
      [self.navigationController popViewControllerAnimated:true];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"我的钱包"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self _selector:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self _title:@"提现" _selector:@selector(doExtract)];
    
    redPaperNum = @"0";//红包数
    //_fillArray = @[@"所有",@"分享返现",@"提现记录"];
    
    //MYP add v3.2.3 钱包列表筛选条件变更
    
    //需根据角色来判断是否有"佣金奖励"这个选项
    if ([[HWUserLogin currentUserLogin].brokerType  isEqualToString: @"B"])
    {
        _fillArray = @[@"所有",@"提现纪录",@"红包奖励",@"佣金奖励",@"福利日奖励",@"其他奖励"];
    }
    else
    {
        _fillArray = @[@"所有",@"提现纪录",@"红包奖励",@"福利日奖励",@"其他奖励"];
    }
    
    _backIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kBackHeight)];
    _backIV.backgroundColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_backIV];
    
    UILabel *myMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 38)];
    myMoneyLabel.backgroundColor = [UIColor clearColor];
    myMoneyLabel.text = @"我的资产";
    myMoneyLabel.textColor = [UIColor whiteColor];
    myMoneyLabel.font = [UIFont fontWithName:FONTNAME size:14];
    [_backIV addSubview:myMoneyLabel];
    
    UILabel *RMBLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 35, 60, _backIV.frame.size.height - 35 - 40)];
    [RMBLabel setBackgroundColor:[UIColor clearColor]];
    [RMBLabel setFont:[UIFont fontWithName:FONTNAME size:40]];
    [RMBLabel setText:@"￥"];
    [RMBLabel setTextColor:[UIColor whiteColor]];
    [_backIV addSubview:RMBLabel];
    
    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 35, kScreenWidth - 70, _backIV.frame.size.height - 35 - 40)];
//  _moneyLabel.font = [UIFont fontWithName:@"Helvetica Neue LT Pro" size:70];
    _moneyLabel.font = [UIFont fontWithName:FONTNAME size:40];
    _moneyLabel.text = @"0";
    _moneyLabel.adjustsFontSizeToFitWidth = YES;
    _moneyLabel.textColor = [UIColor whiteColor];
    _moneyLabel.backgroundColor = [UIColor clearColor];
    _moneyLabel.textAlignment = NSTextAlignmentCenter;
    [_backIV addSubview:_moneyLabel];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, _backIV.frame.size.height - 76, kScreenWidth, 38)];
    [imgV setImage:[UIImage imageNamed:@"bg021"]];
    imgV.userInteractionEnabled = YES;
    _backIV.userInteractionEnabled = YES;
    [_backIV addSubview:imgV];

    UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeToRedPaper)];
    [imgV addGestureRecognizer:imgTap];
    
    //add by
    redPaperLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 38)];
    redPaperLab.userInteractionEnabled = YES;
    redPaperLab.font = [UIFont fontWithName:FONTNAME size:14];
    redPaperLab.backgroundColor = [UIColor clearColor];
    redPaperLab.text = @"    红包";
    redPaperLab.textColor = [UIColor whiteColor];
    [imgV addSubview:redPaperLab];
    
    UIImageView *arrowRightV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 20 - 8, 12, 8, 14)];
    arrowRightV.image = [UIImage imageNamed:@"arrow_next"];
    [imgV addSubview:arrowRightV];
    
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imgV.frame), kScreenWidth, 38)];
    backV.backgroundColor = [UIColor whiteColor];
    [backV drawBottomLine];
    [_backIV addSubview:backV];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 38)];
    label.userInteractionEnabled = YES;
    label.font = [UIFont fontWithName:FONTNAME size:14];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"    钱包明细";
    label.textColor = TITLE_COLOR_33;
    [backV addSubview:label];
    
    _selectButton = [[FiltButton alloc] initWithFrame:CGRectMake(kScreenWidth - 10 - 90, 0, 90, 38)];
    _selectButton.backgroundColor = [UIColor clearColor];
    _selectButton.titleLabe.font = [UIFont fontWithName:FONTNAME size:14];
    _selectButton.titleLabe.textColor = CD_Btn_MainColor;
    [_selectButton setTitle:typeStr.length <= 0 ? @"所有" : typeStr];
    [_selectButton setTitleRightAlignment];
    [_selectButton addTarget:self action:@selector(selectType)];
    [backV addSubview:_selectButton];
    
    self.baseTableView.frame = CGRectMake(0, CGRectGetMaxY(_backIV.frame), kScreenWidth, CONTENT_HEIGHT - kBackHeight);
    UIView *view = [[UIView alloc]init];
    baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.tableFooterView = view;

    _isFirstTime = YES;
    _cashType = @"0";
    //[self getRedNum];
}

//add by
//跳到红包列表页面
- (void)changeToRedPaper
{
    HWRedPaperViewController *redPaperVC = [[HWRedPaperViewController alloc]init];
    [self.navigationController pushViewController:redPaperVC animated:YES];
}

- (void)doExtract
{
//    [MobClick event:@"click_others"];
    UIActionSheet *moneyActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"提现",@"我的银行卡",@"提现密码", nil];
    [moneyActionSheet showInView:self.view];
}

/**
 *	@brief	筛选类型
 *
 *	@return	N/A
 */
- (void)selectType
{
//    [MobClick event:@"filter_sum_type"];
    
    if (!_selectTableView || _selectTableView.frame.size.height == 0)
    {
        [self showSelectView];
    }
    else
    {
        [self hideSelectView];
    }
}

/**
 *	@brief	显示筛选视图
 *
 *	@return	N/A
 */
- (void)showSelectView
{
    if (!_selectTableView)
    {
        _selectTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.baseTableView.frame.origin.y + 3, kScreenWidth, 0) style:UITableViewStylePlain];
        _selectTableView.dataSource = self;
        _selectTableView.delegate = self;
        _selectTableView.backgroundColor = UIColorFromRGB(0xf0f0f0);
        _selectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_selectTableView];
    }
    [self.view bringSubviewToFront:_selectTableView];
    
    [UIView animateWithDuration:0.3f animations:^{
        _selectTableView.frame = CGRectMake(0, _selectTableView.frame.origin.y, kScreenWidth, self.baseTableView.frame.size.height - 3);
    } completion:^(BOOL finished) {
        
    }];
}

/**
 *	@brief	隐藏筛选视图
 *
 *	@return	N/A
 */
- (void)hideSelectView
{
    [UIView animateWithDuration:0.3f animations:^{
        _selectTableView.frame = CGRectMake(0, _selectTableView.frame.origin.y, kScreenWidth, 0);
    } completion:^(BOOL finished) {
        
    }];
}

/**
 *	@brief	刷新函数
 *
 *	@return	N/A
 */
- (void)getNewList
{
    _isFirstTime = YES;
    [self queryListData];
}

/**
 *	@brief	加载钱包数据
 *
 *	@return	N/A
 */
- (void)queryListData
{
    [Utility hideMBProgress:self.view];
    [Utility showMBProgress:self.view _message:@"请求数据"];
    
    HWHttpRequestOperationManager *manage = [HWHttpRequestOperationManager baseManager];
//    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    //合伙人要使用的类型    所有 提现记录 成交佣金 7 上线奖励 8  权证、金融奖励 9 其他奖励 10
//    [param setPObject:_cashType forKey:@"type"];//0全部 1分享返现 2推荐返现 3团队返现 4提现,5红包返现，6邀约返现 不填也是全部
    [param setPObject:[Utility_OC getMoneyTypeWithStr:typeStr] forKey:@"type"];
    [param setPObject:[NSString stringWithFormat:@"%d",_currentPage+1] forKey:@"pageNumber"];
    [param setPObject:[NSString stringWithFormat:@"%d",kPageCount] forKey:@"pageSize"];
    [param setPObject:@"1" forKey:@"channel"];
    [manage postHttpRequest:kMyYongjin parameters:param queue:nil success:^(NSDictionary *responseObject) {
        [Utility hideMBProgress:self.view];
        self.totalMoney = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"balance"] stringValue]];
//        [HWUserLogin currentUserLogin].totalMoney = self.totalMoney;
        [self reCalculate];
        //        // 如果金额大于100 并且 未设置提现密码 只判断一次
//        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
//        if (self.totalMoney.floatValue > 100 && ![userdefaults objectForKey:kFirstGetMoney])
//        {
//            [self checkSetMoneyPassword];
//            [userdefaults setObject:@"1" forKey:kFirstGetMoney];
//        }
        NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
        
        if (_currentPage == 0)
        {
            self.dataList = [NSMutableArray arrayWithArray:[dataDic arrayObjectForKey:@"content"]];
        }
        else
        {
            [self.dataList addObjectsFromArray:[dataDic arrayObjectForKey:@"content"]];
        }
        if (!_yearArray)
        {
            _yearArray = [NSMutableArray array];
        }
        [_yearArray removeAllObjects];
        
        for (int i = 0; i < [self.dataList count]; i ++)
        {
            if (![_yearArray containsObject:[NSString stringWithFormat:@"%@",[[self.dataList objectAtIndex:i] objectForKey:@"date"]]])
            {
                [_yearArray addObject:[NSString stringWithFormat:@"%@",[[self.dataList objectAtIndex:i] objectForKey:@"date"]]];
            }
        }
        if (!_returnCellArray)
        {
            _returnCellArray = [NSMutableArray array];
        }
        [_returnCellArray removeAllObjects];
        
        
        for (int i = 0; i < [_yearArray count]; i ++)
        {
            NSMutableArray *array = [NSMutableArray array];
            for (int j = 0; j < [self.dataList count]; j ++)
            {
                if ([[NSString stringWithFormat:@"%@",[[self.dataList objectAtIndex:j] objectForKey:@"date"]] isEqualToString:[_yearArray objectAtIndex:i]])
                {
                    [array addObject:[self.dataList objectAtIndex:j]];
                }
            }
            [_returnCellArray addObject:array];
        }
        NSArray *array = [dataDic arrayObjectForKey:@"content"];
        if(array.count < kPageCount)
        {
            isLastPage = YES;
        }
        else
        {
            isLastPage = NO;
        }
        
        for (UILabel *label in _redPacketView.subviews)
        {
            if (label.tag == kRedCountTag)
            {
                label.text = [NSString stringWithFormat:@"红包 %@ 个",[responseObject stringObjectForKey:@"redPackageNum"]];
            }
        }
        
        if(self.dataList.count == 0)
        {
            [self showEmpty:@"暂无收支明细" withOffset:40];
        }
        else
        {
            [self hideEmpty];
        }
        [self.baseTableView reloadData];
        [self doneLoadingTableViewData];
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [self doneLoadingTableViewData];
        
        if (_moneyLabel.text.length <= 0)
        {
            _moneyLabel.text = @"0";
        }
        if ([error isKindOfClass:[NSNull class]])
        {
            [Utility showToastWithMessage:@"请求出错" _view:self.view];
        }
        else if (_currentPage == 0 && [error isEqualToString:@"没有符合条件的"])
        {
            [self.dataList removeAllObjects];
            [self.baseTableView reloadData];
            [self showEmpty:@"暂无收支明细" withOffset:30];
        }
        else if(self.dataList.count == 0)
        {
            [self showEmpty:@"暂无收支明细" withOffset:30];
        }
        else
        {
            [Utility showToastWithMessage:@"请求出错" _view:self.view];
        }
    }];

}

- (void)getRedNum
{
//    [Utility hideMBProgress:self.view];
//    [Utility showMBProgress:self.view _message:@"请求数据"];
    
    HWHttpRequestOperationManager *manage = [HWHttpRequestOperationManager baseManager];
    //    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [manage postHttpRequest:kGetNewRed parameters:param queue:nil success:^(NSDictionary *responseObject) {
        NSDictionary *resultDic = [responseObject objectForKey:@"data"];
        redPaperLab.text = [NSString stringWithFormat:@"    红包%@个",[self convertString:resultDic key:@"newRedNum"]];
        
        [Utility hideMBProgress:self.view];
        
    } failure:^(NSString *code, NSString *error) {
//        [Utility hideMBProgress:self.view];
//        [Utility showToastWithMessage:@"请求出错" _view:self.view];
    }];
    
}
-(NSString *)convertString:(NSDictionary *)dic key:(NSString *)key
{
    id obj = [dic objectForKey:key];
    if([obj isKindOfClass:[NSNull class]] || obj == nil)
        return @"";
    else
        return [NSString stringWithFormat:@"%@",obj];
}

/**
 *	@brief	提示提现
 *
 *	@return	N/A
 */
- (void)checkSetMoneyPassword
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的资产已达100元，可以提现了！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:@"立即提现", nil];
    alert.tag = MONEY_TAG;
    [alert show];
}



- (void)checkCash
{
    HWHttpRequestOperationManager *manage = [HWHttpRequestOperationManager baseManager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:@"1" forKey:@"channel"];
    
    [manage postHttpRequest:kBindValidate parameters:dict queue:nil success:^(NSDictionary *responseObject) {
        [Utility hideMBProgress:self.view];
        NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
        
        NSString *state = [NSString stringWithFormat:@"%@", [dataDic objectForKey:@"state"]];
        if ([state isEqualToString:@"101"])
        {
            // 未设置提现密码
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"设置提现密码可有效保护您的资产安全，是否现在设置？" delegate:self cancelButtonTitle:@"暂不设置" otherButtonTitles:@"现在设置", nil];
            alert.tag = ALERT_GETMONEY_TAG;
            [alert show];
        }
        else if ([state isEqualToString:@"103"])
        {
            // 未绑定银行卡
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"绑定银行卡才能提现，是否现在绑定？"     delegate:self cancelButtonTitle:@"暂不绑定" otherButtonTitles:@"现在绑定", nil];
            alert.tag = ALERT_BIND_TAG;
            [alert show];
        }
        else
        {
            // 绑定过银行卡  跳转提现页面
            ExtractViewController *extractVC = [[ExtractViewController alloc] init];
            extractVC.popToViewController = self;
            [self.navigationController pushViewController:extractVC animated:YES];
        }

    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error _view:self.view];
    }];
    
}

/**
 *	@brief	重新启动数字滚动动画
 *
 *	@return	N/A
 */
- (void)reCalculate
{
    _moneyLabel.text = @"0";
    if ([self.totalMoney floatValue] <= 0)
    {
        return;
    }
    _addMoney = 0;
    if ([_timer isValid])
    {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f/20.f  target:self selector:@selector(calculateMoney) userInfo:nil repeats:YES];
}

/**
 *	@brief	金额滚动的幅度大小
 *
 *	@return	N/A
 */
- (void)calculateMoney
{
    float timeMoney = [self.totalMoney floatValue] / 15.0;
    _addMoney += timeMoney;
    
    NSNumberFormatter *formatter=[[NSNumberFormatter alloc]init];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    [formatter setUsesGroupingSeparator:YES];
    NSNumber *num= [NSNumber numberWithFloat:_addMoney];
    NSString *str = [formatter stringFromNumber:num];
//    _moneyLabel.text = str;
    _moneyLabel.text = [Utility_OC conversionThousandth:str];
    if (_addMoney >= [self.totalMoney floatValue])
    {
        [_timer invalidate];
        _timer = nil;
//        _moneyLabel.text = [NSString stringWithFormat:@"%.2f",self.totalMoney.floatValue];
        _moneyLabel.text = [Utility_OC conversionThousandth:self.totalMoney];
        
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //判断是否绑定过银行卡
        [MobClick event:@"click_cash"];
        [Utility showMBProgress:self.view _message:@"获取数据"];
        [self checkCash];
        
    }
    else if (buttonIndex == 1)  // 我的银行卡
    {
        // 跳转我的银行卡
        [MobClick event:@"click_my_cards"];
        HWMyCardViewController *myCardVC = [[HWMyCardViewController alloc] init];
        [self.navigationController pushViewController:myCardVC animated:YES];
    }
    else if (buttonIndex == 2)  // 提现密码页面
    {
        //判断是否设置提现密码
        [MobClick event:@"click_cash_password"];
        
        [Utility showMBProgress:self.view _message:@"获取数据"];
        HWHttpRequestOperationManager *manager = [HWHttpRequestOperationManager baseManager];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
        [dict setPObject:@"1" forKey:@"channel"];
        
        [manager postHttpRequest:kAddCreditCardValidate parameters:dict queue:nil success:^(NSDictionary *responseObject) {
            [Utility hideMBProgress:self.view];
            NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
            NSString *state = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"state"]];
            if ([state isEqualToString:@"101"])
            {
                //未设置提现密码
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"设置提现密码可有效保护您的资产安全，是否现在设置？" delegate:self cancelButtonTitle:@"暂不设置" otherButtonTitles:@"现在设置", nil];
                alert.tag = ALERT_GETMONEY_TAG;
                [alert show];
            }
            else
            {
                //  跳转提现密码管理页面
                HWMoneyPasswordManagerController *moneyPsdMng = [[HWMoneyPasswordManagerController alloc] init];
                //moneyPsdMng.popToViewController = self;
                [self.navigationController pushViewController:moneyPsdMng animated:YES];
            }
        } failure:^(NSString *code, NSString *error) {
            [Utility hideMBProgress:self.view];
            [Utility showToastWithMessage:error _view:self.view];
        }];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == ALERT_BIND_TAG)
    {
        if (buttonIndex == 1)
        {
            // 点击绑定按钮  跳转添加银行卡界面 添加前验证是否设置提现密码
            [Utility showMBProgress:self.view _message:@"获取数据"];
            HWHttpRequestOperationManager *manager = [HWHttpRequestOperationManager baseManager];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
            [dict setPObject:@"1" forKey:@"channel"];
            
            [manager postHttpRequest:kAddCreditCardValidate parameters:dict queue:nil success:^(NSDictionary *responseObject) {
                [Utility hideMBProgress:self.view];
                NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
                
                NSString *state = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"state"]];
                if ([state isEqualToString:@"101"])
                {
                    //未设置提现密码
                    HWForgotMoneyPasswordController *setMoneyPwdVC = [[HWForgotMoneyPasswordController alloc] init];
                    setMoneyPwdVC.logic = LogicLine_GetMoney;
                    setMoneyPwdVC.navigationItem.titleView = [Utility navTitleView:@"设置提现密码"];
                    [self.navigationController pushViewController:setMoneyPwdVC animated:YES];
                }
                else if ([state isEqualToString:@"102"])
                {
                    //需要验证提现密码
                    HWMoneyPasswordController *confirmPwdVC = [[HWMoneyPasswordController alloc] init];
                    confirmPwdVC.pwdModel = Confirm_Password;
                    confirmPwdVC.logic = LogicLine_GetMoney;
                    [self.navigationController pushViewController:confirmPwdVC animated:YES];
                    
                }
                else
                {
                    //  跳转提现密码管理页面
                    //  判断是否是第一次绑定银行卡 如果是 需要验证提现密码.
                    HWAddCardViewController *addCardVC = [[HWAddCardViewController alloc] init];
                    [self.navigationController pushViewController:addCardVC animated:YES];
                }
            } failure:^(NSString *code, NSString *error) {
                [Utility hideMBProgress:self.view];
                [Utility showToastWithMessage:error _view:self.view];
            }];
        }
    }
    else if (alertView.tag == ALERT_GETMONEY_TAG)
    {
        if (buttonIndex == 1)
        {
            // 设置提现密码
            HWForgotMoneyPasswordController *setMoneyPwdVC = [[HWForgotMoneyPasswordController alloc] init];
            setMoneyPwdVC.popToController = self;
            setMoneyPwdVC.navigationItem.titleView = [Utility navTitleView:@"设置提现密码"];
            [self.navigationController pushViewController:setMoneyPwdVC animated:YES];
        }
    }
    else if (alertView.tag == MONEY_TAG)
    {
        if (buttonIndex == 1)
        {
            // 设置提现密码
            [self checkCash];
        }
    }
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_selectTableView])
    {
        return;
    }
    
    [super scrollViewDidScroll:scrollView];
    [self hideSelectView];
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    if ([tableView isEqual:_selectTableView])
//    {
//        return 1;
//    }
//    if ([_returnCellArray count] == 0)
//    {
//        return 1;
//    }
//    return [_returnCellArray count];
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if ([tableView isEqual:_selectTableView])
//    {
//        return 0;
//    }
//    return 44;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
//    v.backgroundColor = [UIColor redColor];
//    
//    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
//    [imgV setBackgroundColor:[UIColor clearColor]];
//    [imgV setImage:[UIImage imageNamed:@"bg021"]];
//    [v addSubview:imgV];
//    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
//    label.userInteractionEnabled = YES;
//    label.font = [UIFont fontWithName:FONTNAME size:16];
//    label.backgroundColor = [UIColor whiteColor];
//#warning color
////    label.textColor = THEME_COLOR_SMOKE;
//    [v addSubview:label];
//    _selectButton = [[FiltButton alloc]initWithFrame:CGRectMake(kScreenWidth - 10 - 90, 2, 90, 40)];
////    _selectButton.titleLabe.backgroundColor = [UIColor redColor];
//    _selectButton.backgroundColor = [UIColor clearColor];
//    _selectButton.titleLabe.font = [UIFont fontWithName:FONTNAME size:14];
//#warning color
////    _selectButton.titleLabe.textColor = THEME_COLOR_GRAY_MIDDLE;
//    [_selectButton setTitle:typeStr.length<=0?@"所有":typeStr];
//    [_selectButton setTitleRightAlignment];
//    [_selectButton addTarget:self action:@selector(selectType)];
//    [v addSubview:_selectButton];
//    if ([_returnCellArray count] == 0)
//    {
//        label.text = @"  钱包明细";
//    }
//    else
//    {
//        label.text = [NSString stringWithFormat:@"  %@钱包明细",[[[_returnCellArray objectAtIndex:section] objectAtIndex:0] objectForKey:@"date"]];
//    }
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44 - 0.5f, kScreenWidth, 0.5f)];
//    line.backgroundColor = CD_LineColor;
//    [v addSubview:line];
//    
//    return v;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_selectTableView])
    {
        return [_fillArray count];
    }
    if ([_returnCellArray count] == 0)
    {
        return 0;
    }
    return [[_returnCellArray objectAtIndex:section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_selectTableView])
    {
        return 45;
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    static NSString *cellIdentifier1 = @"cell1";
    
    if ([tableView isEqual:_selectTableView])
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 44.5, self.view.frame.size.width, 0.5)];
            view.backgroundColor = CD_LineColor;
            [cell.contentView addSubview:view];
        }
        cell.contentView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        cell.textLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 45);
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = [_fillArray objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:FONTNAME size:14.0f];
        cell.textLabel.textColor = TITLE_COLOR_33;
//        cell.textLabel.textColor = THEME_COLOR_GRAY_MIDDLE;
        
        return cell;
    }
    
    PurseTableViewCell * cell = (PurseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[PurseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    [cell addaptWithDictionary:[[_returnCellArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_selectTableView isEqual:tableView])
    {
        // 筛选视图
        typeStr = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        [_selectButton setTitle:typeStr];
        [_selectButton setTitleRightAlignment];
        [self hideSelectView];
//        _cashType = [NSString stringWithFormat:@"%d", (int)(indexPath.row > 1 ? (indexPath.row + 2) : indexPath.row)];
        [self queryListData];
    }
    else
    {
//        // 钱包列表
////        [MobClick event:@"click_sum_detail"];
//        
//        WalletDetailViewController *walletDetail = [[WalletDetailViewController alloc]initWithDetailID:[[[_returnCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"recordId"]];
//        walletDetail.popToViewController = self;
//        walletDetail.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:walletDetail animated:YES];
    }
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
