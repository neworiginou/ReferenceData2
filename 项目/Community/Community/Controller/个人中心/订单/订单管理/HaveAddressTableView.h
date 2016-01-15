//
//  HaveAddressTableView.h
//  Community
//
//  Created by hw500028 on 14/12/9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
#import "BaseTableview.h"
#import "HWAddressModel.h"
typedef enum
{
    haveAddressMethod = 0,   // 有默认管理地址
    noAddressMethod,         // 无管理地址
    ePayMethod,              // 电子商品 无收货店址 模块
    remainMoneyMothod        //余额支付

}payMethodType;

@interface HaveAddressTableView : BaseTableview<UIAlertViewDelegate>

@property (nonatomic,assign) payMethodType payMethod;
@property (nonatomic,assign) SEL result;
@property (nonatomic, readwrite) BOOL isSingleCustomAlertShowing;
@property (nonatomic,strong) NSString *payMoney;
@property (nonatomic, strong) NSString *buyCoinCount;
@property (nonatomic, copy)void(^comeinSettingPssard)();
@property (nonatomic, copy)void(^paySuccessReturn)();
@property (nonatomic,strong) HWAddressModel *addressModel;
@property (nonatomic,strong) NSString *orderIdStr;//订单ID
@property (nonatomic,strong) NSString *orderTypeStr;//交易类型1.商品交易2.考拉币交易
@property (nonatomic,strong) NSString *isSelectedWalletFlag;
@property (nonatomic,strong) NSString *objectStr;//商品名称
@property (nonatomic,strong) NSString *subObjectStr;//商品描述
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style type:(payMethodType)type payMoney:(NSString *)money;

@end
