//
//  HWPropertyDetailVC.h
//  Community
//
//  Created by lizhongqiang on 14-9-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  物业详情页面

#import "HWBaseViewController.h"
#import "HWPropertyServerCell.h"
#import "HWOrderPropertyVC.h"
#import "HWProNewsImgCell.h"
#import "HWProNewsSoundCell.h"
#import "HWProNewsTextCell.h"
#import "HWHouseSaleRentsVC.h"
#import "HWRefreshBaseViewController.h"
#import "HWRentsIntentionVC.h"
#import "HWHTTPRequestOperationManager.h"
#import "HWRequestConfig.h"
#import "HWPerfectPropertyDataVC.h"
#import "HWPropertyDetailClass.h"
#import "HWCallPhoneAlert.h"
#import "HWCoreDataManager.h"
#import "HWServiceBaseDataClass.h"
#import "HWServiceData.h"

@interface HWPropertyDetailVC : HWRefreshBaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{

    UIView *headView;
    float heightV;                              //页面高
    NSMutableArray *arrCollect;                 //物业服务数据
//    NSMutableArray *arrCollectImg;              //物业服务图片
    NSMutableArray *arrType;                    //最近动态类型
    NSMutableArray *arrTrack;                   //物业动态
    
    UIWebView *callWebview;
    HWPropertyDetailClass *proClass;
    HWCallPhoneAlert *tipAlert;
    NSString *propertyId;                       //物业ID
    
    NSString *_callNum;
}
@property (nonatomic, retain) NSString *propertyId;
@property (nonatomic, retain) UIView *headView;
@property(nonatomic,strong)HWCallPhoneAlert *tipAlert;
@end
