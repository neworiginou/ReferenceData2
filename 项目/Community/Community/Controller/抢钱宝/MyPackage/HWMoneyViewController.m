//
//  HWMoneyViewController.m
//  Community
//
//  Created by D on 14/12/8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWMoneyViewController.h"
#import "HWMyMoneyViewController.h"
#import "HWKaolaCoinViewController.h"
#import "HWMyPriviledgeVC.h"
#import "AppDelegate.h"
#define BackHeight             300

#define PockerBackColor                     UIColorFromRGB(0xFFA300)
#define KoalaMoneyBackColor                  UIColorFromRGB(0x8CCD32)
#define CouponBackColor                     UIColorFromRGB(0x1EB2AC)

typedef NS_ENUM(NSInteger, PushViewController) {
    HWMyPocket = 303,       //钱包
    HWMyKoalaMoney,   //考拉币
    HWMyCoupon,       //优惠券
};

@implementation HWMoneyViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = [Utility navTitleView:@"钱包"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(custombackMethod)];
    
    _backIV = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, kScreenWidth, BackHeight)];
    [self.view addSubview:_backIV];
    
    NSArray * colorArr = @[PockerBackColor,KoalaMoneyBackColor,CouponBackColor];
    NSArray * titleArr = @[@"钱包余额 ( 元 )", @"考拉币余额 ( 个 )", @"优惠券 ( 张 ) "];
    
    for (int i = 0; i < 3; i++) {
        UIView * sortView = [[UIView alloc] initWithFrame:CGRectMake(0, _backIV.frame.size.height/3.0f * i, _backIV.frame.size.width, _backIV.frame.size.height / 3.0f)];
        sortView.backgroundColor = colorArr[i];
        [_backIV addSubview:sortView];
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 150, 20)];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.text = titleArr[i];
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = [UIFont fontWithName:FONTNAME size:16];
        [sortView addSubview:titleLab];
        
        UILabel * moneyLab = [[UILabel alloc] init];
        if (IOS7) {
            moneyLab.frame =  CGRectMake(15, 45, 800,45);
            moneyLab.font = [UIFont fontWithName:@"Helvetica Neue LT Pro" size:45];
        } else {
            moneyLab.frame = CGRectMake(15, 45, 800,55);
            moneyLab.font = [UIFont fontWithName:@"Helvetica Neue LT Pro" size:40];
        }
        moneyLab.text = @"0";
        moneyLab.adjustsFontSizeToFitWidth = YES;
        moneyLab.textColor = [UIColor whiteColor];
        moneyLab.backgroundColor = [UIColor clearColor];
        [sortView addSubview:moneyLab];
        moneyLab.tag = 202 + i;
        
        UIImageView *arrowIV = [[UIImageView alloc]initWithFrame:CGRectMake(sortView.frame.size.width - 22, sortView.frame.size.height / 2.0f - 6, 6.5, 12)];
        arrowIV.image = [UIImage imageNamed:@"redPkgArrow"];
        [sortView addSubview:arrowIV];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushController:)];
        sortView.tag = HWMyPocket+i;
        [sortView addGestureRecognizer:tap];
        
        if (i > 0) {
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, sortView.frame.size.width, 0.5)];
            lab.backgroundColor = [UIColor whiteColor];
            [sortView addSubview:lab];
        }
    }
    
    _pocketMoneyLab = (UILabel *)[self.view viewWithTag:202];
    _koalaMoneyLab = (UILabel *)[self.view viewWithTag:203];
    _couponMoneyLab = (UILabel *)[self.view viewWithTag:204];
    
    //发送请求
    [self getWalletMoney];
    [self getKaolaCoinMoney];
    [self getPriviledgeRemain];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refershMoneyView) name:RELOAD_MONEYView object:nil];
    
}

-(void)custombackMethod
{
    [[NSNotificationCenter defaultCenter] postNotificationName:RELOAD_APP_DATA object:nil];
    
    AppDelegate *app = SHARED_APP_DELEGATE;
    [app.tabBarVC setSelectedIndex:3];
    [self.navigationController popToViewController:app.tabBarVC animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)dealloc
{
//    [[NSNotificationCenter defaultCenter]removeObserver:self forKeyPath:RELOAD_MONEYView];
}
//刷新钱包页面
-(void)refershMoneyView
{
    [self getWalletMoney];
    [self getKaolaCoinMoney];
    [self getPriviledgeRemain];
}
- (void)pushController:(UITapGestureRecognizer *)tap {
    switch (tap.view.tag) {
        case HWMyPocket: {
            [MobClick event:@"click_mypocket"];
            BOOL isBindTel = [HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES];
            if (isBindTel)
            {
                HWMyMoneyViewController *myMoneyVC = [[HWMyMoneyViewController alloc] init];
                [self.navigationController pushViewController:myMoneyVC animated:YES];
            }

        }
            break;
        case HWMyKoalaMoney: {
            HWKaolaCoinViewController *kaolaCoinVc = [[HWKaolaCoinViewController alloc]init];
            kaolaCoinVc.totalMoney = _kaolaCoinStr;
            [self.navigationController pushViewController:kaolaCoinVc animated:YES];
            
        }
            break;
        case HWMyCoupon: {
            HWMyPriviledgeVC *priviledgeVc = [[HWMyPriviledgeVC alloc]init];
            [self.navigationController pushViewController:priviledgeVc animated:YES];
        }
            break;
        default:
            break;
    }
}
-(void)refershWalletUI
{
    [self walletReCalculate];
}
-(void)refershKaolaCoinUI
{
    [self kaolaCoinReCalculate];
}
-(void)refershPriviledgeUI
{
    [self priviledgeReCalculate];
}
#pragma - mark 获取钱包余额
- (void)getWalletMoney
{
    [Utility hideMBProgress:self.view];
    [Utility showMBProgress:self.view message:@"请求数据"];
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager accountManager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.key forKey:@"key"];

    [manage POST:kWalletRemainMoney parameters:dict queue:nil success:^(id responseObject) {
         [Utility hideMBProgress:self.view];
        NSDictionary *respDic = (NSDictionary *)[responseObject dictionaryObjectForKey:@"data"];
        _walletMoneyStr = [respDic stringObjectForKey:@"amount"];
        if([_walletMoneyStr length]==0)
        {
            _walletMoneyStr = @"0";
            [HWUserLogin currentUserLogin].totalMoney = _walletMoneyStr;
        }
        else
        {
            [HWUserLogin currentUserLogin].totalMoney = _walletMoneyStr;
        }
        
        [self refershWalletUI];
    } failure:^(NSString *code, NSString *error) {
        [Utility showToastWithMessage:error inView:self.view];
        [Utility hideMBProgress:self.view];
        [HWUserLogin currentUserLogin].totalMoney = @"0";
        NSLog(@"error %@",error);
    }];
}
#pragma - mark 获取考拉币余额

- (void)getKaolaCoinMoney
{
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager accountManager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.key forKey:@"key"];
    [dict setPObject:user.userId forKey:@"userId"];

    [manage POST:kKaolaRemain parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
        NSDictionary *respDic = (NSDictionary *)[responseObject dictionaryObjectForKey:@"data"];
        _kaolaCoinStr = [respDic stringObjectForKey:@"amount"];
        [self refershKaolaCoinUI];
    } failure:^(NSString *code, NSString *error) {
         [Utility hideMBProgress:self.view];
        NSLog(@"error %@",error);
    }];
}
#pragma - mark 获取优惠劵可用余额
-(void)getPriviledgeRemain
{
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.key forKey:@"key"];
    [dict setPObject:user.userId forKey:@"userId"];

    [manage POST:kPriviledgeUse parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
        NSDictionary *respDic = (NSDictionary *)responseObject;
        _priviledgeStr = [respDic stringObjectForKey:@"data"];
        [self refershPriviledgeUI];
    } failure:^(NSString *code, NSString *error) {
         [Utility hideMBProgress:self.view];
        NSLog(@"error %@",error);
    }];

}

/**
 *	@brief	钱包重新启动数字滚动动画
 *
 *	@return	N/A
 */
- (void)walletReCalculate
{
    _pocketMoneyLab.text = @"0";
    if ([_walletMoneyStr floatValue] <= 0)
    {
        return;
    }
    _walletMoney = 0;
    if ([_walletRemainTimer isValid])
    {
        [_walletRemainTimer invalidate];
        _walletRemainTimer = nil;
    }
    _walletRemainTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/20.f  target:self selector:@selector(calculateWalletMoney) userInfo:nil repeats:YES];
}

/**
 *	@brief	金额滚动的幅度大小
 *
 *	@return	N/A
 */
- (void)calculateWalletMoney
{
    float timeMoney = [_walletMoneyStr floatValue] / 15.0;
    _walletMoney += timeMoney;
    
    NSNumberFormatter *formatter=[[NSNumberFormatter alloc]init];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    [formatter setUsesGroupingSeparator:YES];
    NSNumber *num= [NSNumber numberWithFloat:_walletMoney];
    NSString *str = [formatter stringFromNumber:num];
    _pocketMoneyLab.text = str;
    if (_walletMoney >= [_walletMoneyStr floatValue])
    {
        [_walletRemainTimer invalidate];
        _walletRemainTimer = nil;
        _pocketMoneyLab.text = [NSString stringWithFormat:@"%.2f",[_walletMoneyStr floatValue]];
    }
    
}


/**
 *	@brief	考拉币重新启动数字滚动动画
 *
 *	@return	N/A
 */
- (void)kaolaCoinReCalculate
{
    _koalaMoneyLab.text = @"0";
    if ([_kaolaCoinStr floatValue] <= 0)
    {
        return;
    }
    _kaolaCoin = 0;
    if ([_kaolaCoinTimer isValid])
    {
        [_kaolaCoinTimer invalidate];
        _kaolaCoinTimer = nil;
    }
    _kaolaCoinTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/20.f  target:self selector:@selector(calculateKaolaCoinMoney) userInfo:nil repeats:YES];
}

/**
 *	@brief	金额滚动的幅度大小
 *
 *	@return	N/A
 */
- (void)calculateKaolaCoinMoney
{
    float timeMoney = [_kaolaCoinStr floatValue] / 15.0;
    _kaolaCoin += timeMoney;
    
    NSNumberFormatter *formatter=[[NSNumberFormatter alloc]init];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    [formatter setUsesGroupingSeparator:YES];
    NSNumber *num= [NSNumber numberWithFloat:_kaolaCoin];
    NSString *str = [formatter stringFromNumber:num];
    _koalaMoneyLab.text = str;
    if (_kaolaCoin >= [_kaolaCoinStr floatValue])
    {
        [_kaolaCoinTimer invalidate];
        _kaolaCoinTimer = nil;
        _koalaMoneyLab.text = _kaolaCoinStr;
//        _koalaMoneyLab.text = [NSString stringWithFormat:@"%d",(int)[_kaolaCoinStr floatValue]];???以前为何要这样写？
        
    }
    
}


/**
 *	@brief	优惠劵重新启动数字滚动动画
 *
 *	@return	N/A
 */
- (void)priviledgeReCalculate
{
    _couponMoneyLab.text = @"0";
    if ([_priviledgeStr floatValue] <= 0)
    {
        return;
    }
    _kaolaCoin = 0;
    if ([_priviledgeTimer isValid])
    {
        [_priviledgeTimer invalidate];
        _priviledgeTimer = nil;
    }
    _priviledgeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/20.f  target:self selector:@selector(calculatePriviledge) userInfo:nil repeats:YES];
}

/**
 *	@brief	金额滚动的幅度大小
 *
 *	@return	N/A
 */
- (void)calculatePriviledge
{
    float timeMoney = [_priviledgeStr floatValue] / 15.0;
    _priviledge += timeMoney;
    
    NSNumberFormatter *formatter=[[NSNumberFormatter alloc]init];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    [formatter setUsesGroupingSeparator:YES];
    NSNumber *num= [NSNumber numberWithFloat:_priviledge];
    NSString *str = [formatter stringFromNumber:num];
    _couponMoneyLab.text = str;
    if (_priviledge >= [_priviledgeStr floatValue])
    {
        [_priviledgeTimer invalidate];
        _priviledgeTimer = nil;
        _couponMoneyLab.text = [NSString stringWithFormat:@"%d",(int)[_priviledgeStr floatValue]];
    }
    
}
@end
