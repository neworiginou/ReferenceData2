//
//  HWMoneyViewController.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-20.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWMyMoneyViewController.h"
#import "PurseTableViewCell.h"
#import "WalletDetailViewController.h"
#import "HWForgotMoneyPasswordController.h"
#import "HWRedPacketViewController.h"
#import <CoreText/CoreText.h>
#import "HWMyCardViewController.h"
#import "HWMoneyPasswordManagerController.h"
#import "HWAddCardViewController.h"
#import "HWMoneyPasswordController.h"
#import "ExtractViewController.h"

#define SELECT_VIEW_TAG         777
#define kBackHeight             120
#define kCalculateTime          15
#define kRedCountTag            999
#define ALERT_GETMONEY_TAG      1001
#define ALERT_BIND_TAG          1002
#define MONEY_TAG               1003

@interface HWMyMoneyViewController ()
{
    NSString *typeStr;
}
@end

@implementation HWMyMoneyViewController
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

- (void)judgeNewRedPacket
{
    /*
    if (![AppShare getShareInstance].currentUser.userKey) {
        return;
    }
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setPObject:[AppShare getShareInstance].currentUser.userKey forKey:@"key"];
    [manager POST:kNewRedPaketNum parameters:dic queue:nil success:^(id responseObject) {
        if ([[[responseObject dictionaryObjectForKey:@"data"] numberObjectForKey:@"newRedNum"] intValue] > 0) {
            [self addRedPoint];
        }else{
            [self removeRedPoint];
        }
    } failure:^(NSString *error) {
        
    } operateObject:self completeLogin:^{
        
    }];
    */
}

- (void)viewWillAppear:(BOOL)animated
{
//    [self judgeNewRedPacket];
    [self queryListData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self hideSelectView];
}

/**
 *	@brief	添加红点
 *
 *	@return	N/A
 */
- (void)addRedPoint
{
//    [(HWTabbarCtr *)self.tabBarController setBadgePoint];
}

/**
 *	@brief	移除红点
 *
 *	@return	N/A
 */
- (void)removeRedPoint
{
    if (!self.tabBarController) {
        return;
    }
//    [(HWTabbarCtr *)self.tabBarController removeBadgePoint];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"我的钱包"];
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navWalletButton:self action:@selector(doExtract)];
    
    _fillArray = @[@"所有",@"分享返现",@"提现",@"红包返现",@"邀约返现",@"推广佣金"];
    _backIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kBackHeight)];
    _backIV.image = [UIImage imageNamed:@"bg_color_orange"];
    [self.view addSubview:_backIV];
    
    UILabel *myMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 130, 20)];
    myMoneyLabel.backgroundColor = [UIColor clearColor];
    myMoneyLabel.text = @"钱包余额（ 元 ）";
    myMoneyLabel.textColor = [UIColor whiteColor];
    myMoneyLabel.font = [UIFont fontWithName:FONTNAME size:16];
    [_backIV addSubview:myMoneyLabel];
    
    _moneyLabel = [[UILabel alloc] init];
    if (IOS7) {
        _moneyLabel.frame = CGRectMake(15, 50, 500, _backIV.frame.size.height - 55);
        _moneyLabel.font = [UIFont fontWithName:@"Helvetica Neue LT Pro" size:60];
    } else {
        _moneyLabel.frame = CGRectMake(15, 50, 500, _backIV.frame.size.height - 45);
        _moneyLabel.font = [UIFont fontWithName:@"Helvetica Neue LT Pro" size:55];
    }
    _moneyLabel.text = @"0";
    _moneyLabel.adjustsFontSizeToFitWidth = YES;
    _moneyLabel.textColor = [UIColor whiteColor];
    _moneyLabel.backgroundColor = [UIColor clearColor];
    [_backIV addSubview:_moneyLabel];
#pragma mark － 已取消
    if (_redPacketView)
    {
        _redPacketView = [[UIView alloc]initWithFrame:CGRectMake(0, kBackHeight - 40, kScreenWidth, 40)];
        _redPacketView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1f];
        [_backIV addSubview:_redPacketView];
        
        UIImageView *purseIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 14, 14.5, 12)];
        purseIV.image = [UIImage imageNamed:@"purse"];
        [_redPacketView addSubview:purseIV];
        
        UIImageView *arrowIV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 30, 14, 6.5, 12)];
        arrowIV.image = [UIImage imageNamed:@"redPkgArrow"];
        [_redPacketView addSubview:arrowIV];
        
        UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 9, 100, 20)];
        
        countLabel.font = [UIFont fontWithName:FONTNAME size:14];
        countLabel.textColor = [UIColor whiteColor];
        countLabel.tag = kRedCountTag;
        NSString *str = @"红包 0 个";
        NSMutableAttributedString *labelText = [[NSMutableAttributedString alloc]initWithString:str];
        [labelText addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(2, [str length] - 3)];
        countLabel.backgroundColor = [UIColor clearColor];
        countLabel.attributedText = labelText;
        
        [_redPacketView addSubview:countLabel];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showRedPacket)];
        [_redPacketView addGestureRecognizer:tap];
        _backIV.userInteractionEnabled = YES;
    }
    
    
    self.baseTableView.frame = CGRectMake(0, CGRectGetMaxY(_backIV.frame), kScreenWidth, CONTENT_HEIGHT - kBackHeight);
    UIView *view = [[UIView alloc]init];
    baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.tableFooterView = view;

    _isFirstTime = YES;
    _cashType = @"0";
    
    
}

- (void)doExtract
{
        [MobClick event:@"click_others"];
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
    [MobClick event:@"filter_sum_type"];
    
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
        _selectTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.baseTableView.frame.origin.y + 44, kScreenWidth, 0) style:UITableViewStylePlain];
        _selectTableView.dataSource = self;
        _selectTableView.delegate = self;
        _selectTableView.backgroundColor = UIColorFromRGB(0xf0f0f0);
        _selectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_selectTableView];
    }
    [self.view bringSubviewToFront:_selectTableView];
    
    [UIView animateWithDuration:0.3f animations:^{
        _selectTableView.frame = CGRectMake(0, _selectTableView.frame.origin.y, kScreenWidth, self.baseTableView.frame.size.height - 44);
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
{/*172.16.10.13/hw-account-web/wallets/dealList.do?type=0&key=a79dbe5c-bf01-4c47-b4ac-ed9ca9c6b1d0&appUrlVersion=1.2.1*/
    [Utility hideMBProgress:self.view];
    [Utility showMBProgress:self.view message:@"请求数据"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager accountManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:_cashType forKey:@"type"];//0全部 1分享返现 2推荐返现 3团队返现 4提现,5红包返现，6邀约返现 不填也是全部
//    [param setPObject:[Utility getLocalAppVersion] forKey:@"appUrlVersion"];  //后台去掉了
    [param setPObject:[NSString stringWithFormat:@"%d",_currentPage] forKey:@"page"];
    [param setPObject:[NSString stringWithFormat:@"%d",kPageCount] forKey:@"size"];
    
    
    [manager POST:kMyYongjin parameters:param queue:nil success:^(id responseObject) {
        
        NSLog(@"%@", responseObject);
        
        [Utility hideMBProgress:self.view];
        self.totalMoney = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"balance"] stringValue]];
        [HWUserLogin currentUserLogin].totalMoney = self.totalMoney;
        
        [self reCalculate];
        
        // 如果金额大于100 并且 未设置提现密码 只判断一次
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        if (self.totalMoney.floatValue > 100 && ![userdefaults objectForKey:kFirstGetMoney])
        {
            [self checkSetMoneyPassword];
            [userdefaults setObject:@"1" forKey:kFirstGetMoney];
        }
     
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
        //        [self.tableview reloadData];
        //NSLog(@"houselist error hwhttprequest:%@",error);
        if ([error isKindOfClass:[NSNull class]])
        {
            [Utility showToastWithMessage:@"网络打瞌睡了，稍后再试" inView:self.view];
        }
        else if (_currentPage == 0 && [error isEqualToString:@"没有符合条件的"])
        {
            //NSLog(@"count :%i",self.list.count);
            [self.dataList removeAllObjects];
            //NSLog(@"count :%i",self.list.count);
            [self.baseTableView reloadData];
//            [self showEmptyWithOffSet:30 and:@"暂无收支明细"];
        }
        else if(self.dataList.count == 0)
        {
//            [self showEmptyWithOffSet:30 and:@"暂无收支明细"];
        }
        else
        {
            [Utility showToastWithMessage:@"网络打瞌睡了，稍后再试" inView:self.view];
        }
        
    }];
}

/**
 *	@brief	进入红包页面
 *
 *	@return	N/A
 */
- (void)showRedPacket
{
    HWRedPacketViewController *redVC = [[HWRedPacketViewController alloc]init];
    [self.navigationController pushViewController:redVC animated:YES];
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
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:@"1" forKey:@"channel"];
    
    [manager POST:kBindValidate parameters:dict queue:nil success:^(id responseObject)
     {
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
             [self.navigationController pushViewController:extractVC animated:YES];
         }
         
         
     } failure:^(NSString *code, NSString *error) {
         [Utility hideMBProgress:self.view];
         [Utility showToastWithMessage:error inView:self.view];
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
    _moneyLabel.text = str;
    if (_addMoney >= [self.totalMoney floatValue])
    {
        [_timer invalidate];
        _timer = nil;
        _moneyLabel.text = [NSString stringWithFormat:@"%.2f",self.totalMoney.floatValue];
        
    }
    
}

#warning 设置提现密码

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
    {
        if (buttonIndex == 0)
        {
            //判断是否绑定过银行卡
            [MobClick event:@"click_cash"];
            [Utility showMBProgress:self.view message:@"获取数据"];
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
            [Utility showMBProgress:self.view message:@"获取数据"];
            HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
            //    [dict setPObject:@"1" forKey:@"key"];
            [dict setPObject:@"1" forKey:@"channel"];
            
            [manager POST:kAddCreditCardValidate parameters:dict queue:nil success:^(id responseObject)
             {
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
                     moneyPsdMng.popToViewController = self;
                     [self.navigationController pushViewController:moneyPsdMng animated:YES];
                 }
                 
                 
             } failure:^(NSString *code, NSString *error) {
                 [Utility hideMBProgress:self.view];
                 [Utility showToastWithMessage:error inView:self.view];
             }];
            
            
        }
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == ALERT_BIND_TAG)
    {
        if (buttonIndex == 1)
        {
            // 点击绑定按钮  跳转添加银行卡界面 添加前验证是否设置提现密码
            [Utility showMBProgress:self.view message:@"获取数据"];
            HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
            //    [dict setPObject:@"1" forKey:@"key"];
            [dict setPObject:@"1" forKey:@"channel"];
            
            [manager POST:kAddCreditCardValidate parameters:dict queue:nil success:^(id responseObject)
             {
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
                 [Utility showToastWithMessage:error inView:self.view];
             }];
            
            
            
        }
    }
    else if (alertView.tag == ALERT_GETMONEY_TAG)
    {
        if (buttonIndex == 1)
        {
            // 设置提现密码
            HWForgotMoneyPasswordController *setMoneyPwdVC = [[HWForgotMoneyPasswordController alloc] init];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:_selectTableView])
    {
        return 1;
    }
    if ([_returnCellArray count] == 0)
    {
        return 1;
    }
    return [_returnCellArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_selectTableView])
    {
        return 0;
    }
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    v.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    label.userInteractionEnabled = YES;
    label.font = [UIFont fontWithName:FONTNAME size:16];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = THEME_COLOR_SMOKE;
    [v addSubview:label];
    _selectButton = [[FiltButton alloc]initWithFrame:CGRectMake(kScreenWidth - 15 - 90, 2, 90, 40)];
//    _selectButton.titleLabe.backgroundColor = [UIColor redColor];
    _selectButton.backgroundColor = [UIColor clearColor];
    _selectButton.titleLabe.font = [UIFont fontWithName:FONTNAME size:14];
    _selectButton.titleLabe.textColor = THEME_COLOR_GRAY_MIDDLE;
    [_selectButton setTitle:typeStr.length<=0?@"所有":typeStr];
    [_selectButton setTitleRightAlignment];
    [_selectButton addTarget:self action:@selector(selectType)];
    [v addSubview:_selectButton];
    if ([_returnCellArray count] == 0)
    {
        label.text = @"   收支明细";
    }
    else
    {
        label.text = [NSString stringWithFormat:@"   %@收支明细",[[[_returnCellArray objectAtIndex:section] objectAtIndex:0] objectForKey:@"date"]];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44 - 0.5f, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [v addSubview:line];
    
    return v;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_selectTableView])
    {
        return [_fillArray count];;
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
    return 62;
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
            view.backgroundColor = THEME_COLOR_LINE;
            [cell.contentView addSubview:view];
        }
        cell.contentView.backgroundColor = UIColorFromRGB(0xffffff);
        cell.textLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 45);
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = [_fillArray objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:FONTNAME size:14.0f];
        cell.textLabel.textColor = THEME_COLOR_GRAY_MIDDLE;
        
        return cell;
    }

    PurseTableViewCell * cell = (PurseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[PurseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setNormalLine];
    if (indexPath.row == 0) {
        [cell setTodayValue];
        [cell setFirstLine];
    }
    else
    {
        cell._descriptionLabel.textColor = THEME_COLOR_GRAY_MIDDLE;
    }
    if (indexPath.row == ([dataList count] - 1))
    {
        [cell setFinalLine];
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
        
        if (indexPath.row == 5)
        {
            _cashType = @"10";
        }
        else
        {
            _cashType = [NSString stringWithFormat:@"%d", (int)(indexPath.row > 1 ? (indexPath.row + 2) : indexPath.row)];
        }
        [self queryListData];
    }
    else
    {
        // 钱包列表
        [MobClick event:@"click_sum_detail"];
        WalletDetailViewController *walletDetail = [[WalletDetailViewController alloc]initWithDetailID:[[[_returnCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"recordId"]];
        walletDetail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:walletDetail animated:YES];
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
