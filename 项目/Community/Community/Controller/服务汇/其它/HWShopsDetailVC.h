//
//  HWShopsDetailVC.h
//  Community
//
//  Created by lizhongqiang on 14-9-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  店铺详情页面

#import "HWBaseViewController.h"
#import "HWShopNewsTableViewCell.h"
#import "HWShopNews.h"
#import "HWRefreshBaseViewController.h"
#import "HWRequestConfig.h"
#import "HWHTTPRequestOperationManager.h"
#import "HWUserLogin.h"
#import "HWStoreDetailClass.h"
#import "HWCallPhoneAlert.h"
#import "HWShopManageViewController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "UIImageView+MJWebCache.h"


@interface HWShopsDetailVC : HWRefreshBaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate>
{
    UIWebView *callWebview;
    NSMutableArray *array;
    float height;
    UIButton *footBtn;
    BOOL isMore;
    NSMutableArray *arrShopInfo;                //商铺动态数组
    HWCallPhoneAlert *tipAlert;
    UIView *tableHeadView;                  //表格的头
//    HWStoreDetailClass *detail;
    HWStoreDetailClass *storeClass;
    NSString *strShopPhone;                 //拨打的商户电话
}

@property (nonatomic, strong) NSString *shopId;
@property(nonatomic,strong)HWCallPhoneAlert *tipAlert;

@end
