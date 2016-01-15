//
//  HaveAddressTableView.m
//  Community
//
//  Created by hw500028 on 14/12/9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  功能描述：确认订单 支付页面
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-20           添加 是否绑定手机号 验证
//
//

#import "HaveAddressTableView.h"
#import "AddressCell.h"
#import "AddAddressTableViewCell.h"
#import "UIView+Addtions.h"
#import "OrderAddressController.h"
#import "AddressModel.h"
#import  "ModificationViewController.h"
#import "RemaiderTableViewCell.h"
#import "PayMethodFooterView.h"
#import "AddAddressTableViewCell.h"
#import "HWSingleCustomAlertV.h"
//#import "AlixPayResult.h"
//#import "AlixPayOrder.h"
//#import "AlixLibService.h"
#import "HWCustomAlertView.h"
#import "HWPayOrderModel.h"

@interface HaveAddressTableView()<SWTableViewCellDelegate>

@end

@implementation HaveAddressTableView
{

    NSArray *payMethodArr;
    CGFloat height;
    
    PayMethodFooterView *payView;
}
@synthesize addressModel;
@synthesize orderIdStr;
@synthesize payMoney;
@synthesize buyCoinCount;
@synthesize orderTypeStr;
@synthesize isSelectedWalletFlag;
@synthesize objectStr;
@synthesize subObjectStr;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style type:(payMethodType)type payMoney:(NSString *)money{

    self = [super initWithFrame:frame style:style];
    if (self) {
        self.payMethod = type;
        if (self.payMethod == haveAddressMethod) {
            payMethodArr = @[@"账户余额",@"支付宝"];
        }
        
        if (self.payMethod == ePayMethod) {
            payMethodArr = @[@"账户余额",@"支付宝"];

        }
        if (self.payMethod == noAddressMethod) {
            payMethodArr = @[@"账户余额",@"支付宝"];

        }
        if (self.payMethod == remainMoneyMothod) {
            payMethodArr = @[@"账户余额"];
        }
        self.payMoney = money;
        
        _result = @selector(paymentResult:);
        
        self.isSingleCustomAlertShowing = NO;
    }
    //添加支付成功通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(paySuccessNotification:) name:@"PaySuccess" object:nil];
    return self;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.payMethod == ePayMethod)
    {
        if (indexPath.row == 0)
        {
            height  = [PayMethodFooterView getPayMenthodHeight] + 40;
            return height;
        }
        else
        {
            return 44;
        }

    }
    else if(self.payMethod == remainMoneyMothod)
    {
        if (indexPath.row == 0)
        {
            height  = [PayMethodFooterView getPayMenthodHeight];
            return height;
        }
        else
        {
            return 44;
        }

    }
    else
    {
        if (indexPath.row == 0)
        {
            if (self.payMethod == noAddressMethod)
            {
                return 44;
            }
            else
            {
                return 85;
            }
        }
        if (indexPath.row == 1)
        {
            height  = [PayMethodFooterView getPayMenthodHeight] + 40;
            return height;
        }
        else
        {
            return 44;
        }
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.payMethod == ePayMethod)
    {
        return 2;
    }
    else if(self.payMethod == remainMoneyMothod)
    {
        return 2;
    }
    else if(self.payMethod == noAddressMethod)
    {
        return 3;
    }
    else if (self.payMethod == haveAddressMethod)
    {
        return 3;
    }
    else
    {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //电子支付方式
    if (self.payMethod == ePayMethod)
    {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            payView = [[PayMethodFooterView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, height - 40) titleArr:payMethodArr money:self.payMoney selectIndex:[isSelectedWalletFlag intValue]];
            [cell.contentView addSubview:payView];
            cell.backgroundColor = [UIColor colorWithRed:235/235.0f green:235/235.0f blue:241/235.0f alpha:0];
            //底部线
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, height - 0.5f, kScreenWidth, 0.5f)];
            line.backgroundColor = THEME_COLOR_LINE;
            [cell.contentView addSubview:line];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else
        {
            RemaiderTableViewCell *cell = [[RemaiderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.moneyLabel.text = [NSString stringWithFormat:@"￥%@",self.payMoney];
            return cell;
        }

        
    }
    else if(self.payMethod == remainMoneyMothod)
    {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            payView = [[PayMethodFooterView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, height - 40) titleArr:payMethodArr money:self.payMoney selectIndex:0];
            [cell.contentView addSubview:payView];
            cell.backgroundColor = [UIColor colorWithRed:235/235.0f green:235/235.0f blue:241/235.0f alpha:0];
            //底部线
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, height - 0.5f-20, kScreenWidth, 0.5f)];
            line.backgroundColor = THEME_COLOR_LINE;
            [cell.contentView addSubview:line];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else
        {
            RemaiderTableViewCell *cell = [[RemaiderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.moneyLabel.text = [NSString stringWithFormat:@"￥%@",self.payMoney];
            return cell;
        }

    }
    
    //有地址或无地址支付方式
    else{
    
        if (indexPath.row == 0)
        {
            //有地址支付方式
            if (self.payMethod == haveAddressMethod)
            {
                
                AddressCell *cell = [AddressCell cellWithTableView:tableView];
                AddressModel *model = [self.dataList pObjectAtIndex:indexPath.row];
                cell.addressModel = model;
                cell.indexPath = indexPath;
                cell.selected = YES;
                cell.delegate = self;
                cell.selectImage.hidden = YES;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                [cell setCellHeight:[AddressCell getHeightWithModel:model]];
                return cell;
            }
            //无地址支付方式
            else
            {
        
                AddAddressTableViewCell *cell = [[AddAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
                
                return cell;
                
            }
            
        }
        if (indexPath.row == 1) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            payView = [[PayMethodFooterView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, height - 40) titleArr:payMethodArr money:self.payMoney selectIndex:[isSelectedWalletFlag intValue]];
            [cell.contentView addSubview:payView];
            cell.backgroundColor = [UIColor colorWithRed:235/235.0f green:235/235.0f blue:241/235.0f alpha:0];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, height - 0.5f, kScreenWidth, 0.5f)];
            line.backgroundColor = THEME_COLOR_LINE;
            [cell.contentView addSubview:line];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else
        {
            RemaiderTableViewCell *cell = [[RemaiderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.moneyLabel.text = [NSString stringWithFormat:@"￥%@",self.payMoney];
            
            return cell;
        }
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 20, kScreenWidth - 30, 45);
    [button setTitle:@"确认支付" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(confirmPay) forControlEvents:UIControlEventTouchUpInside];
    [button setButtonOrangeStyle];
    [view addSubview:button];

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //没有地址支付方式
        if (self.payMethod == noAddressMethod)
        {
            [MobClick event:@"click_meiyoudizhi"];
            OrderAddressController *orderCtrr = [[OrderAddressController alloc]init];
            [self.viewController.navigationController pushViewController:orderCtrr animated:YES];
            [orderCtrr setReturnSelectedAddress:^(AddressModel *returnSelectedAdress) {
                NSMutableArray *dataListArry = [[NSMutableArray alloc]init];
                [dataListArry addObject:returnSelectedAdress];
                self.dataList = dataListArry;
                self.payMethod = haveAddressMethod;
                
                HWAddressModel *addressModelTemp = [[HWAddressModel alloc]init];
                addressModelTemp.name = returnSelectedAdress.name;
                addressModelTemp.mobile = returnSelectedAdress.mobile;
                addressModelTemp.cutUserId = returnSelectedAdress.cutUserId;
                addressModelTemp.address = returnSelectedAdress.address;
                addressModelTemp.addressId = returnSelectedAdress.addressId;
                addressModel = addressModelTemp;
                [self reloadData];

                
            }];
//            CreatAddressController *creatAddressCtrl = [[CreatAddressController alloc]init];
//            [creatAddressCtrl setReturnAddress:^(HWAddressModel *returnAddressModel) {
//                AddressModel *addressModelTemp = [[AddressModel alloc]init];
//                addressModelTemp.addressId = returnAddressModel.addressId;
//                addressModelTemp.cutUserId = returnAddressModel.cutUserId;
//                addressModelTemp.name = returnAddressModel.name;
//                addressModelTemp.address = returnAddressModel.address;
//                addressModelTemp.mobile = returnAddressModel.mobile;
//                NSMutableArray *dataListArry = [[NSMutableArray alloc]init];
//                [dataListArry addObject:addressModelTemp];
//                self.dataList = dataListArry;
//                self.payMethod = haveAddressMethod;
//                addressModel = returnAddressModel;
//                [self reloadData];
//            }];
//            [self.viewController.navigationController pushViewController:creatAddressCtrl animated:YES];
        }
        //有地址支付方式,跳到修改界面
        if (self.payMethod == haveAddressMethod)
        {
            [MobClick event:@"click_yiyoudizhi"];
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            OrderAddressController *selectAddressVC = [[OrderAddressController alloc] init];
            [selectAddressVC setReturnSelectedAddress:^(AddressModel *returnSelectedAdress) {
                
                NSMutableArray *dataListArry = [[NSMutableArray alloc]init];
                [dataListArry addObject:returnSelectedAdress];
                self.dataList = dataListArry;
                self.payMethod = haveAddressMethod;
                
                HWAddressModel *addressModelTemp = [[HWAddressModel alloc]init];
                addressModelTemp.name = returnSelectedAdress.name;
                addressModelTemp.mobile = returnSelectedAdress.mobile;
                addressModelTemp.cutUserId = returnSelectedAdress.cutUserId;
                addressModelTemp.address = returnSelectedAdress.address;
                addressModelTemp.addressId = returnSelectedAdress.addressId;
                addressModel = addressModelTemp;
                [self reloadData];
            }];
            [selectAddressVC setDeletedAddressId:^(NSString *addressId) {
                if ([addressModel.addressId isEqualToString:addressId]) {
                    self.payMethod = noAddressMethod;
                    addressModel = nil;
                    [self reloadData];
                }
            }];
            [self.viewController.navigationController pushViewController:selectAddressVC animated:YES];
//            ModificationViewController *modificationCtrl = [[ModificationViewController alloc]init];
//            modificationCtrl.addressModel = cell.addressModel;
//            [self.viewController.navigationController pushViewController:modificationCtrl animated:YES];

        }
    }
}

//关闭侧滑
- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return NO;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return NO;
            break;
        default:
            break;
    }
    
    return NO;
}

#pragma - mark 确认支付
- (void)confirmPay
{
    BOOL isBind = [HWUserLogin verifyBindMobileWithPopVC:self.viewController showAlert:YES];
    
    if (isBind)
    {
        if ([HWUserLogin verifyBindMobileWithPopVC:self.viewController showAlert:YES])
        {
            [MobClick event:@"click_querenzhifu"];
            if(self.payMethod == haveAddressMethod || self.payMethod == noAddressMethod)
            {
                //订单支付流程
                [self confirmBargainOrder];
            }
            else
            {
                [self confirmPayment];
            }
        }
    }

}
#pragma - mark 支付
-(void)confirmPayment
{
    if (payView.payIndex == 0)
    {
        [MobClick event:@"click_shiyongkaolabizhifu"]; //maidian_1.2.1
        //判断余额是不是充足支付小金额的考拉币
        NSString *totalMoney = [HWUserLogin currentUserLogin].totalMoney;
        float totalMoneyFloat = [totalMoney floatValue];
        if (totalMoneyFloat >=[self.payMoney floatValue])
        {
            //校验是否设置支付密码
            [self validePassward];
        }
        else
        {
            [Utility showAlertWithMessage:@"账户余额不足，请选择其他方式支付"];
        }
        [MobClick event:@"click_querenzhifu"];
    }
    else if(payView.payIndex == 1)
    {
        [MobClick event:@"click_qianbaoyuezhifu"];
        if (_payMethod == remainMoneyMothod || _payMethod == ePayMethod)
        {
            [self payAction];
        }
        else
        {
            HWPayOrderModel *payModel = [[HWPayOrderModel alloc]init];
            payModel.orderId = self.orderIdStr;
            // 支付宝支付
            [self toAlixPay:payModel];
        }
    }

}
#pragma - mark 确认砍价订单 -订单确认支付前必须先要提交用户及地址信息
#pragma mark - 注意
-(void)confirmBargainOrder
{
    /*
     入参：
     cutAddressId 地址id
     cutUserId 砍价用户id
     orderId 砍价订单id
     address 邮寄地址
     userName 收件人
     phone 电话号码
     */
    if([addressModel.address length]== 0)
    {
        [Utility showToastWithMessage:@"收货地址不能为空" inView:self];
        return;
    }
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager cutManager];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setObject:@"1"  forKey:@"source"];
    [dict setObject:addressModel.addressId forKey:@"cutAddressId"];
    [dict setObject:addressModel.cutUserId forKey:@"cutUserId"];
    [dict setObject:self.orderIdStr forKey:@"orderId"];
    [dict setObject:addressModel.address forKey:@"address"];
    [dict setObject:addressModel.name forKey:@"userName"];
    [dict setObject:addressModel.mobile forKey:@"phone"];
    [manager POST:kCutProductConfirmPayment parameters:dict queue:nil success:^(id responseObject)
     {
         //NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
         [self confirmPayment];
     } failure:^(NSString *code, NSString *error) {
         [Utility showToastWithMessage:@"支付失败" inView:self];
     }];
    

}
#pragma mark - 判断是否设置提现密码
// 验证是否设置提现密码
-(void)validePassward
{
    [MobClick event:@"click_add_card"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:@"1" forKey:@"channel"];
    [manager POST:kAddCreditCardValidate parameters:dict queue:nil success:^(id responseObject)
     {
         NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
         
         NSString *state = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"state"]];
         if ([state isEqualToString:@"101"])
         {
             //未设置提现密码
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"设置支付密码可有效保护您的资产安全，是否现在设置？" delegate:self cancelButtonTitle:@"暂不设置" otherButtonTitles:@"现在设置", nil];
             //             alert.tag = ALERT_GETMONEY_TAG;
             [alert show];
         }
         else
         {
             HWPayOrderModel *payModel = [[HWPayOrderModel alloc]init];
             payModel.orderId = self.orderIdStr;
             if (_payMethod == remainMoneyMothod || _payMethod == ePayMethod) {
                 [self payAction];
             }
             else
             {
                 [self popBarginOrderPasswardPage:payModel];
             }
         }
         
     } failure:^(NSString *code, NSString *error)
     {
         [Utility showAlertWithMessage:error];
     }];

}

// 修改结束
#pragma - mark UIAlerviewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
    }
    else
    {
        if (_comeinSettingPssard)
        {
            _comeinSettingPssard();
            
        }
    }
}
#pragma mark - Actions

//确认支付按钮

- (void)payAction
{
    NSLog(@"确认支付");
    
    /*
     
     接口名称：
     输入参数：
     userId	用户ID
     orderAmount	订单金额
     orderType	订单类型
     paymentWay	支付方式  1、现金余额；2、支付宝无线；3、支付宝wap；4、微信;
     mobileNumber	手机号
     key	用户key
     输出参数：
     {
     "status": "1",
     "data":
     { "orderId": 2029704, "orderNo": "201412100404512029704", "orderType": 1, "orderAmount": 50, "orderStatus": 1, "orderUser": 1000167741407, "orderTime": 1418198691512, "paymentWay": 3, "paymentNo": null, "paymentTime": null, "mobileNumber": "18221398089", "creater": 1000167741407, "createTime": 1418198691512, "modifier": null, "modifyTime": null, "version": 1, "disabled": 0 }
     ,
     "detail": "考拉币下单成功",
     "key": null
     }
     参数名	描述
     status	接口返回状态：1，成功；0失败
     data	接口返回数据
     detail	接口返回提示信息
     key	用户 key
     data数据说明：
     orderId	订单ID
     orderNo	订单号
     orderType	订单类型：1、考拉币充值；2、无底线消费；3、流标返还
     orderAmount	订单金额
     orderStatus	订单状态：1、等待付款；2、已付款；3、已取消；4、手动确认支付
     orderUser	下单用户
     orderTime	下单时间
     paymentWay	支付方式：1、现金余额；2、支付宝无线；3、支付宝wap；4、微信
     paymentNo	支付流水号
     paymentTime	支付时间
     mobileNumber	手机号码
     creater	创建者
     createTime	创建时间
     modifier	修改者
     modifyTime	修改时间
     version	版本号
     disabled	是否禁用
     
    */
    
    // 提交订单
    
    //[Utility showMBProgress:self message:@"订单提交"];
    //[Utility showMBProgress:self message:@"支付中"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager accountManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
    [param setPObject:self.payMoney forKey:@"orderAmount"];
    [param setPObject:@"1" forKey:@"orderType"];
    [param setPObject:[NSString stringWithFormat:@"%d",payView.payIndex + 1] forKey:@"paymentWay"];
    [param setPObject:[HWUserLogin currentUserLogin].telephoneNum forKey:@"mobileNumber"];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    [manager POST:kCoinOrder parameters:param queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self];
        
        NSDictionary *dic = [responseObject dictionaryObjectForKey:@"data"];
        HWPayOrderModel *payModel = [[HWPayOrderModel alloc] initWithPayOrder:dic];
        self.orderIdStr = payModel.orderId;
        if (payView.payIndex == 0)
        {
            // 钱包支付
//            [self toMoneyPay:payModel];
            if (_payMethod == remainMoneyMothod || _payMethod == ePayMethod) {
                [self popGetCashPasswardPage:payModel];
            }
            else
            {
                [self popBarginOrderPasswardPage:payModel];
            }
            
        }
        else if (payView.payIndex == 1)
        {
            // 支付宝支付
            [self toAlixPay:payModel];
        }
        
    } failure:^(NSString *code, NSString *error) {
        
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
        
    }];
}
#pragma - mark 弹出输入提现密码页面--购买考拉币
-(void)popGetCashPasswardPage:(HWPayOrderModel *)orderModel
{
    if (!self.isSingleCustomAlertShowing)
    {
        HWSingleCustomAlertV * singleAlertV = [HWSingleCustomAlertV alertWithMoneyAmount:self.payMoney.floatValue];
        
        [singleAlertV setReturanPayPassward:^(NSString *passwardStr)
         {
             self.isSingleCustomAlertShowing = NO;
             if (!passwardStr)   //nil 返回
             {
                 return ;
             }
             [self toMoneyPay:orderModel passward:passwardStr];
         }];
        [singleAlertV show];
        self.isSingleCustomAlertShowing = YES;
        singleAlertV.titleLab.text = @"钱包余额支付";
    }
}

#pragma - mark 砍价订单输入支付密码支付提示页面
-(void)popBarginOrderPasswardPage:(HWPayOrderModel *)orderModel
{
    if (!self.isSingleCustomAlertShowing)
    {
        HWSingleCustomAlertV * singleAlertV = [HWSingleCustomAlertV alertWithMoneyAmount:self.payMoney.floatValue];
        
        [singleAlertV setReturanPayPassward:^(NSString *passwardStr)
         {
             self.isSingleCustomAlertShowing = NO;
             if (!passwardStr)   //nil 返回
             {
                 return ;
             }
             [self toMoneyPay:orderModel passward:passwardStr];
             
         }];
        [singleAlertV show];
        self.isSingleCustomAlertShowing = YES;
        singleAlertV.titleLab.text = @"钱包余额支付";
    }
}
- (void)toMoneyPay:(HWPayOrderModel *)orderModel passward:(NSString *)passwardStr
{
    /*
     userId=【用户账户ID，不可空】
     payPassword=【支付密码，不可空】
     appId=【客户端号，可空】
     appenv=【客户端来源，格式为：system=客户端平台名^version=业务系统版本，如system=iphone^version=3.0.1.2，可空】
     orderId=【业务订单号，不可空】
     orderType=【业务订单类型,1商品支付，2充值考拉币，默认为1】
     payMethod=【支付方式，1钱包支付，默认1】
     subject=【商品名称，不可空】
     body=【商品详情，不可空】
     totalFee=【总金额，单位为RMB-Yuan，不可空】
     */
    
    if ([orderModel.orderId length]==0) {
        [Utility showToastWithMessage:@"商品ID不能为空" inView:self];
        return;
    }
    [Utility showMBProgress:self message:@"支付中..."];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager testPaymanager];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"userId"];
    [param setPObject:[passwardStr md5:passwardStr] forKey:@"payPassword"];
    [param setPObject:APPLEID forKey:@"appId"];
    [param setPObject:@"" forKey:@"appenv"];
    [param setPObject:self.orderIdStr forKey:@"orderId"];
    [param setPObject:orderTypeStr forKey:@"orderType"];
    [param setPObject:@"1" forKey:@"payMethod"];
    [param setPObject:@"支付金额" forKey:@"subject"];
    [param setPObject:@"支付金额" forKey:@"body"];
    [param setPObject:self.payMoney forKey:@"totalFee"];
    [manager POST:kMoneyPay parameters:param queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self];
        NSDictionary *dataDic = [responseObject objectForKey:@"data"];
        NSString *status = [dataDic stringObjectForKey:@"payStatus"];
        if ([status isEqualToString:@"1"]) {
            if (_paySuccessReturn) {
                _paySuccessReturn();
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:RELOAD_MONEYView object:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:RELOAD_ORDER object:nil];
 
        }
        else
        {
            [Utility showToastWithMessage:[dataDic stringObjectForKey:@"payDetail"] inView:self];
        }
        NSLog(@"res %@",responseObject);
        
    }failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
    }];
}
- (void)toAlixPay:(HWPayOrderModel *)orderModel
{
    /*
     userId=【用户账户ID，不可空】
     appId=【客户端号，可空】
     appenv=【客户端来源，格式为：system=客户端平台名^version=业务系统版本，如system=iphone^version=3.0.1.2，可空】
     orderId=【订单号，不可空】
     orderType=【订单类型,1商品支付，2充值考拉币，默认为1】
     payMethod=【支付方式，0支付宝，默认0】
     subject=【商品名称，不可空】
     body=【商品详情，不可空】
     totalFee=【总金额，单位为RMB-Yuan，不可空】
     */
    
    [Utility showMBProgress:self message:@"支付中..."];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager testPaymanager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"userId"];
    [param setPObject:APPLEID forKey:@"appId"];
    [param setPObject:@"" forKey:@"appenv"];
    [param setPObject:self.orderIdStr forKey:@"orderId"];
    [param setPObject:orderTypeStr forKey:@"orderType"];
    [param setPObject:@"0" forKey:@"payMethod"];
    if (objectStr && [objectStr length]!=0) {
         [param setPObject:objectStr forKey:@"subject"];
    }
    else
    {
        [param setPObject:@"账户支付" forKey:@"subject"];
    }
    if(subObjectStr && [subObjectStr length]!=0)
    {
           [param setPObject:subObjectStr forKey:@"body"];
    }
    else
    {
         [param setPObject:@"账户支付" forKey:@"body"];
    }
    [param setPObject:self.payMoney forKey:@"totalFee"];

    
    [manager POST:kAlixPay parameters:param queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self];
        
        NSLog(@"res %@",responseObject);
        
        NSString *payUrl = [responseObject stringObjectForKey:@"data"];
        
        NSString *appScheme = @"AlixPay";
        
        [[AlipaySDK defaultService] payOrder:payUrl fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"%@",resultDic);
            //支付后的回调
//            [Utility showToastWithMessage:[resultDic stringObjectForKey:@"memo"] inView:self];
            NSString *resultStatus = [resultDic stringObjectForKey:@"resultStatus"];
            if ([resultStatus isEqualToString:@"9000"])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PaySuccess" object:nil];
                if (_paySuccessReturn)
                {
                    _paySuccessReturn();
                }
            }
            else
            {
                [Utility showToastWithMessage:@"支付失败" inView:self];
            }
        }];
//        [AlixLibService payOrder:payUrl AndScheme:appScheme seletor:_result target:self];
        
    }failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
    }];
}

- (void)paySuccessNotification:(NSNotification *)notify
{
    
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0];
}

- (void)delayMethod
{
    if (_paySuccessReturn) {
        _paySuccessReturn();
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:RELOAD_MONEYView object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:RELOAD_ORDER object:nil];
}

//
#pragma - mark wap回调函数
- (void)paymentResult:(NSString *)resultd
{
//    //结果处理
//#if ! __has_feature(objc_arc)
//    AlixPayResult* result = [[[AlixPayResult alloc] initWithString:resultd] autorelease];
//#else
//    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
//#endif
//    if (result)
//    {
//        
//        if (result.statusCode == 9000)
//        {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"PaySuccess" object:nil];
//            if (_paySuccessReturn) {
//                _paySuccessReturn();
//            }
//            /*
//             *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
//             */
//            
//            //交易成功
//            //            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
//            //            id<DataVerifier> verifier;
//            //            verifier = CreateRSADataVerifier(key);
//            //
//            //            if ([verifier verifyString:result.resultString withSign:result.signString])
//            //            {
//            //                //验证签名成功，交易结果无篡改
//            //            }
//        }
//        else
//        {
//            [Utility showToastWithMessage:@"支付失败" inView:self];
//        }
//    }
//    else
//    {
//        //失败
//         [Utility showToastWithMessage:@"支付失败" inView:self];
//    }
    
}

@end
