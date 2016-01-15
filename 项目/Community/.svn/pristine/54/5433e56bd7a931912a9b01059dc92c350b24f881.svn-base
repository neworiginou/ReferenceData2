//
//  SurePayController.m
//  Community
//
//  Created by hw500028 on 14/12/8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "SurePayController.h"
#import "AddAddressTableViewCell.h"
#import "CreatAddressController.h"
#import "AppDelegate.h"
#import "HWForgotMoneyPasswordController.h"
#import "AddressModel.h"
@interface SurePayController ()
{
    HaveAddressTableView * hTableView;
}

@end

@implementation SurePayController
//@synthesize methodType;
@synthesize payMoney;
@synthesize buyCoinCount;
@synthesize addressModel;
@synthesize orderId;
@synthesize orderTypeStr;
@synthesize isSelectedWalletFlag;
@synthesize objectStr;
@synthesize subObjectStr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessNotificaition:) name:@"PaySuccess" object:nil];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"确认订单"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    [self getWalletMoney];
    [self initViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (hTableView != nil)
    {
        [hTableView reloadData];
    }

}


#pragma - mark 获取钱包余额
- (void)getWalletMoney
{
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager accountManager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.key forKey:@"key"];
    
    [manage POST:kWalletRemainMoney parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
        NSDictionary *respDic = (NSDictionary *)[responseObject dictionaryObjectForKey:@"data"];
        [HWUserLogin currentUserLogin].totalMoney = [respDic stringObjectForKey:@"amount"];
        NSString * _walletMoneyStr = [respDic stringObjectForKey:@"amount"];
        if([_walletMoneyStr length]==0)
        {
            _walletMoneyStr = @"0";
            [HWUserLogin currentUserLogin].totalMoney = _walletMoneyStr;
        }
        else
        {
            [HWUserLogin currentUserLogin].totalMoney = _walletMoneyStr;
        }
    } failure:^(NSString *code, NSString *error) {
        [HWUserLogin currentUserLogin].totalMoney = @"0";

    }];
}
- (void)paySuccessNotificaition:(NSNotification *)notify
{
    AppDelegate *appDel = SHARED_APP_DELEGATE;
    [Utility showToastWithMessage:@"支付成功" inView:appDel.window];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - views

- (void)initViews
{
    
    hTableView= [[HaveAddressTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) style:UITableViewStyleGrouped type:self.methodType payMoney:self.payMoney];
    hTableView.isSelectedWalletFlag = isSelectedWalletFlag;
    hTableView.orderIdStr = orderId;
    hTableView.orderTypeStr = orderTypeStr;
    hTableView.addressModel = addressModel;
//    AddressModel *addressModelTemp = [[AddressModel alloc]init];
//    addressModelTemp.addressId = addressModel.addressId;
//    addressModelTemp.cutUserId = addressModel.cutUserId;
//    addressModelTemp.name = addressModel.name;
//    addressModelTemp.address = addressModel.address;
//    addressModelTemp.mobile = addressModel.mobile;
//    addressModelTemp.orderIdStr = self.orderId;
//    NSMutableArray *dataListArry = [[NSMutableArray alloc]init];
//    [dataListArry addObject:addressModelTemp];
//    haveTableView.dataList = dataListArry;
    if (self.methodType == haveAddressMethod) {
        [hTableView.dataList addObject:addressModel];
        [hTableView reloadData];

    }
      __weak SurePayController *weakVC = self;
    [hTableView setComeinSettingPssard:^{
        //未设置提现密码
        HWForgotMoneyPasswordController *setMoneyPwdVC = [[HWForgotMoneyPasswordController alloc] init];
        setMoneyPwdVC.logic = LoginLine_SettingPassward;
        setMoneyPwdVC.popToController = weakVC;
        setMoneyPwdVC.navigationItem.titleView = [Utility navTitleView:@"设置提现密码"];
        [weakVC.navigationController pushViewController:setMoneyPwdVC animated:YES];
    }];
    
    [hTableView setPaySuccessReturn:^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:PAY_SUCCESS object:nil];
        [weakVC.navigationController popViewControllerAnimated:YES];
    }];
    if(buyCoinCount)
    {
         hTableView.buyCoinCount = buyCoinCount;
    }
    hTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:hTableView];
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
