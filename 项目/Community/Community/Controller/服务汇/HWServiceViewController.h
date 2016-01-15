//
//  HWServiceViewController.h
//  Community
//
//  Created by caijingpeng.haowu on 14-8-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  服务汇首页

#import "HWBaseViewController.h"
#import "HWServeTableViewCell.h"
#import "HWShopsDetailVC.h"
#import "HWPropertyDetailVC.h"
#import "HWRefreshBaseViewController.h"
#import "HWCallPhoneAlert.h"
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
#import "HWPerfectPropertyDataVC.h"
#import "HWHTTPRequestOperationManager.h"
#import "HWRequestConfig.h"
#import "HWUserLogin.h"
#import "HWServiceItemClass.h"
#import "HWShopItemClass.h"
#import "HWPropertyItemClass.h"
#import "HWPerfectPropertyDataVC.h"
#import "HWCoreDataManager.h"
#import "TFHpple.h"

@interface HWServiceViewController : HWRefreshBaseViewController<UITableViewDataSource,UITableViewDelegate,HWServerCellDelegate>
{
    
    UIWebView *callWebview;
    CTCallCenter *callCenter;
    HWCallPhoneAlert *tipAlert;
//    int currentPage;                    //当前页
//    NSMutableArray *arrProperty;        //物业数据 model
    
//    HWPropertyItemClass *dicProperty;       //
    NSMutableArray *arrShop;            //商铺数据 model
    
    HWShopItemClass *callItem;              //商铺
    HWPropertyItemClass *proItem;           //物业
    NSString *strCallType;                  //拨打电话的类型   0商铺 1物业
    NSString *strPropertyPhone;             //拨打的物业电话
    NSString *strShopPhone;                 //拨打的商铺电话
}

@property(nonatomic,strong)HWCallPhoneAlert *tipAlert;
@property (nonatomic, assign) BOOL isShowMessageCenterRedDot;

- (void)messageCenterClick;

- (void)checkRefresh;



@end
