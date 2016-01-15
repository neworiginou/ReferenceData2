//
//  HWStoreDetailClass.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWStoreDetailClass.h"

@implementation HWStoreDetailClass
@synthesize shopId;
@synthesize shopName;
@synthesize shopAddress;
@synthesize shopTime;
//@synthesize serviceRange;
@synthesize shopType;
//@synthesize serviceConfig;
@synthesize outSell;
@synthesize arrServiceRange;
@synthesize arrShopType;
@synthesize arrServiceConfig;
@synthesize connectionRate;
@synthesize serviceDetail;
@synthesize authorize;
@synthesize shopPhone;
@synthesize bannerUrl;
@synthesize picUrls;
@synthesize picIconUrls;
@synthesize pikKeys;
//@synthesize serviceTrack;
@synthesize arrServiceTrack;
@synthesize mobile;

@synthesize bannerMongoDbKey;
@synthesize latitude;
@synthesize longitude;
@synthesize residentId;
@synthesize residentName;

-(id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init])
    {

        arrServiceRange = [[NSMutableArray alloc] init];
        arrShopType = [[NSMutableArray alloc] init];
        arrServiceConfig = [[NSMutableArray alloc] init];
        arrServiceTrack = [[NSMutableArray alloc] init];
        self.picUrls = [[NSMutableArray alloc] init];
        picIconUrls = [[NSMutableArray alloc] init];
        pikKeys = [NSArray array];
       
        self.shopId = [dic stringObjectForKey:@"shopId"];
        self.shopName = [dic stringObjectForKey:@"shopName"];
        self.shopAddress = [dic stringObjectForKey:@"shopAddress"];
        self.shopTime = [dic stringObjectForKey:@"shopTime"];
        self.outSell = [dic stringObjectForKey:@"outSell"];
        self.bannerMongoDbKey = [dic stringObjectForKey:@"bannerMongoDbKey"];
        self.longitude = [dic stringObjectForKey:@"longitude"];
        self.latitude = [dic stringObjectForKey:@"latitude"];
        self.residentId = [dic stringObjectForKey:@"residentId"];
        self.residentName = [dic stringObjectForKey:@"residentName"];
        self.mobile = [dic stringObjectForKey:@"mobile"];
        
        NSArray *arrRange = [dic arrayObjectForKey:@"serviceRange"];
        for (int i = 0; i < arrRange.count; i ++)
        {
            [self.arrServiceRange addObject:[[HWServiceRangeClass alloc] initWithDictionary:[arrRange objectAtIndex:i]]];
        }
        NSArray *arrType = [dic arrayObjectForKey:@"shopType"];
        for (int i = 0; i < arrType.count; i ++)
        {
            [self.arrShopType addObject:[[HWShopTypeClass alloc] initWithDictionary:[arrType objectAtIndex:i]]];
        }
        NSArray *arrConfig = [dic arrayObjectForKey:@"serviceConfig"];
        for (int i = 0; i < arrConfig.count; i ++)
        {
            [self.arrServiceConfig addObject:[[HWShopServiceConfig alloc] initWithDictionary:[arrConfig objectAtIndex:i]]];
        }
        
        self.connectionRate = [dic stringObjectForKey:@"connectionRate"];
        self.serviceDetail = [dic stringObjectForKey:@"serviceDetail"];
        self.authorize = [dic stringObjectForKey:@"authorize"];
        self.shopPhone = [dic stringObjectForKey:@"phone"];
        self.bannerUrl = [dic stringObjectForKey:@"bannerUrl"];
        
        
        NSArray *arrPicIcon = [[NSArray alloc] initWithArray:[dic arrayObjectForKey:@"picIconUrls"]];//[dic arrayObjectForKey:@"picIconUrls"];
        for (int i = 0; i < arrPicIcon.count; i ++)
        {
            [self.picIconUrls addObject:arrPicIcon[i]];
        }
        NSArray *arrPic = [[NSArray alloc] initWithArray:[dic arrayObjectForKey:@"picUrls"]];
//        NSArray *arrPic = [dic arrayObjectForKey:@"picUrls"];
        for (int i = 0; i < arrPic.count; i ++)
        {
            NSLog(@"%@",arrPic[i]);
            [self.picUrls addObject:arrPic[i]];
        }
        
//        self.pikKeys = [dic objectForKey:@"picMongoDbKeys"];
        self.pikKeys = [dic arrayObjectForKey:@"picMongoDbKeys"];
        self.shopType = [dic stringObjectForKey:@"shopType"];
        NSArray *arrTrack = [dic arrayObjectForKey:@"serviceTrack"];
        for (int i = 0; i < arrTrack.count; i ++)
        {
            [self.arrServiceTrack addObject:[[HWStoreNewsClass alloc] initWithDictionary:[arrTrack objectAtIndex:i]]];
        }
    }
    return self;
}
@end
