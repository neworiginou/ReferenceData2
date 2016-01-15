//
//  HWHouseSaleRentsVC.h
//  Community
//
//  Created by lizhongqiang on 14-9-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  房屋租售

#import <UIKit/UIKit.h>
#import "HWBaseViewController.h"
#import "HWRentsPeopleInfoVC.h"
#import "HWOrderCell.h"
#import "HWRentsIntentionVC.h"
#import "HWRentsAreaVC.h"
#import "HWRentsHuXingVC.h"
#import "HWRentsAddressVC.h"
#import "HWRentsData.h"
#import "HWHTTPRequestOperationManager.h"
#import "HWUserLogin.h"
#import "HWRentsAdvantageVC.h"
#import "HWCustomBigAlert.h"

@interface HWHouseSaleRentsVC : HWBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak)UIViewController *rootVC;                    //出售托管根视图
@property (nonatomic, strong) NSString *phoneHistoryId;
@end
