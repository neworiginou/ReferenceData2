//
//  HWOrderPropertyVC.h
//  Community
//
//  Created by lizhongqiang on 14-9-2.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  预约物业上门首页


#import "HWBaseViewController.h"
#import "HWOrderTimeVC.h"
#import "HWOrderTypeVC.h"
#import "HWOrderAddressVC.h"
#import "HWOrderCell.h"
#import "HWOrderData.h"
#import "HWUserLogin.h"
#import "HWHTTPRequestOperationManager.h"

@interface HWOrderPropertyVC : HWBaseViewController<UITableViewDataSource,UITableViewDelegate,HWOrderTimeVCDelegate,HWOrderTypeVCDelegeate,HWOrderAddressVCDelegate>
{
    UITableView *orderTable;        //表格
    NSArray *arrHead;               //头部文字
    NSMutableArray *arrTable;       //表格内容，可变
}

@property (nonatomic, strong) UITableView *orderTable;
@property (nonatomic, strong) NSString *tenementId;

@property (nonatomic,strong)NSString *phoneHistoryId;
@end
