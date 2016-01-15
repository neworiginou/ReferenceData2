//
//  HWCashSuccessViewController.h
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-29.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWRefreshBaseViewController.h"

@interface HWCashSuccessViewController : HWRefreshBaseViewController

@property (nonatomic, strong)NSDictionary *bank;
@property (nonatomic, strong)NSString *money;
@property (nonatomic, strong)NSString *restMoney;
@property (nonatomic, strong)NSString *cashDetailID;
@property (nonatomic, strong)UIViewController *popToViewController;


@end
