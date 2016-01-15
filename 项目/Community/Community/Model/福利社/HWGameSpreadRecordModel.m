//
//  HWGameSpreadRecordModel.m
//  Community
//
//  Created by niedi on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：推广记录页面TableViewCell Model
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪          2015-1-16                 创建文件
//

#import "HWGameSpreadRecordModel.h"

@implementation HWGameSpreadRecordModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.commissionKLB = [dict stringObjectForKey:@"commissionKLB"];
        self.commissionRMB = [dict stringObjectForKey:@"commissionRMB"];
        self.gameName = [dict stringObjectForKey:@"gameName"];
        self.gameId = [dict stringObjectForKey:@"gameId"];
        self.iconMongodbKey = [dict stringObjectForKey:@"iconMongodbKey"];
        
    }
    return self;
}

@end
/*{"gameId":2,"gameName":"虚无荣耀","iconMongodbKey":"21sdf565wr22343","activateCount":0,"consumeCount":50.0000,"status":1,"commissionRMB":5.0000,"commissionKLB":null,"commissionCurrency":null,"commissionAmount":null}
 @property (nonatomic, strong) NSString *gameName;
 @property (nonatomic, strong) NSString *gameId;
 @property (nonatomic, strong) NSString *iconMongodbKey;
 */