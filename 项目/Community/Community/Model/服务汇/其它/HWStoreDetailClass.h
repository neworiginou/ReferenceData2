//
//  HWStoreDetailClass.h
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  商户详情数据模型
//

#import <Foundation/Foundation.h>
#import "HWServiceRangeClass.h"
#import "HWShopTypeClass.h"
#import "HWShopServiceConfig.h"
#import "HWPicUrlsClass.h"
#import "HWStoreNewsClass.h"
@interface HWStoreDetailClass : NSObject
@property (nonatomic, strong) NSString *shopId;                     //商铺ID
@property (nonatomic, strong) NSString *shopName;                   //商铺名称
@property (nonatomic, strong) NSString *shopAddress;                //商铺地址
@property (nonatomic, strong) NSString *shopTime;                   //营业时间

//@property (nonatomic, strong) HWServiceRangeClass *serviceRange;    //小区
@property (nonatomic, strong) NSString* shopType;            //类别
//@property (nonatomic, strong) HWShopServiceConfig *serviceConfig;   //图标

@property (nonatomic, strong) NSMutableArray *arrServiceRange;      //小区
@property (nonatomic, strong) NSMutableArray *arrShopType;          //类别
@property (nonatomic, strong) NSMutableArray *arrServiceConfig;     //图标
@property (nonatomic, strong) NSString *outSell;                    //外卖
@property (nonatomic, strong) NSString *connectionRate;             //接通率
@property (nonatomic, strong) NSString *serviceDetail;              //服务详情
@property (nonatomic, strong) NSString *authorize;                  //0 未认证  1 认证
@property (nonatomic, strong) NSString *shopPhone;                  //电话
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *bannerUrl;                  //大图url

@property (nonatomic, strong) NSMutableArray *picIconUrls;          //店铺相册图
@property (nonatomic, strong) NSMutableArray *picUrls;              //店铺大图

@property (nonatomic, strong) NSArray *pikKeys;                     //小图Key
@property (nonatomic, strong) NSMutableArray *arrServiceTrack;      //动态

@property (nonatomic, strong) NSString *bannerMongoDbKey;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *residentId;
@property (nonatomic, strong) NSString *residentName;


- (id)initWithDictionary:(NSDictionary *)dic;

@end
