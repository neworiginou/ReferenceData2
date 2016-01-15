//
//  HWGameSpreadRecordModel.h
//  Community
//
//  Created by niedi on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWGameSpreadRecordModel : NSObject

@property (nonatomic, strong) NSString *commissionKLB;
@property (nonatomic, strong) NSString *commissionRMB;
@property (nonatomic, strong) NSString *gameName;
@property (nonatomic, strong) NSString *gameId;
@property (nonatomic, strong) NSString *iconMongodbKey;


- (instancetype)initWithDict:(NSDictionary *)dict;

@end
/*{"gameId":2,"gameName":"虚无荣耀","iconMongodbKey":"21sdf565wr22343","activateCount":0,"consumeCount":50.0000,"status":1,"commissionRMB":5.0000,"commissionKLB":null,"commissionCurrency":null,"commissionAmount":null}*/