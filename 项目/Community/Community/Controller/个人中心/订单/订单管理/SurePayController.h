//
//  SurePayController.h
//  Community
//
//  Created by hw500028 on 14/12/8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HaveAddressTableView.h"

@interface SurePayController : HWBaseViewController

@property (nonatomic, assign)payMethodType methodType;
@property (nonatomic, strong)NSString *payMoney;
@property (nonatomic, strong)NSString *isSelectedWalletFlag;//0代表账户余额1代表支付宝
@property (nonatomic, strong)NSString *buyCoinCount;
@property (nonatomic, strong)HWAddressModel *addressModel;
@property (nonatomic, strong)NSString *orderId;
@property (nonatomic,strong) NSString *orderTypeStr;//交易类型1.商品交易2.考拉币交易
@property (nonatomic,strong) NSString *objectStr;//商品名称
@property (nonatomic,strong) NSString *subObjectStr;//商品描述
@end
