//
//  HWPropertyDetailClass.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWPropertyDetailClass.h"
#import "HWPropertyNewsClass.h"
#import "HWPropertyServiceClass.h"

@implementation HWPropertyDetailClass
@synthesize tenementId;
@synthesize name;
@synthesize intro;
@synthesize address;
@synthesize openTime;
@synthesize tenementTel;
@synthesize callTimes;
//@synthesize serviceCatagory;
@synthesize arrServiceTrack;
@synthesize arrPropertyService;

- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.arrServiceTrack = [[NSMutableArray alloc] init];
        self.arrPropertyService = [[NSMutableArray alloc] init];
        self.tenementTel = [[NSArray alloc] init];
        
        self.tenementId = [dic stringObjectForKey:@"tenementId"];
        self.name = [dic stringObjectForKey:@"name"];
        self.intro = [dic stringObjectForKey:@"intro"];
        self.address = [dic stringObjectForKey:@"address"];
        self.openTime = [dic stringObjectForKey:@"openTime"];
        self.coStatus = [dic stringObjectForKey:@"coStatus"];
        self.tenementTel = [dic arrayObjectForKey:@"tenementTel"];
//        NSArray *arrTel = [dic arrayObjectForKey:@"tenementTel"];
//        if (arrTel.count > 0)
//        {
//            self.tenementTel = arrTel[0];
//        }
//        else
//        {
//            self.tenementTel = @"";
//        }
        self.callTimes = [dic stringObjectForKey:@"callTimes"];
//        self.serviceCatagory = [dic arrayObjectForKey:@"serviceCatagory"];
        NSArray *arrService = [dic arrayObjectForKey:@"communityTenementServiceConfigDtoList"];
        for (int i = 0; i < arrService.count; i ++)
        {
            HWPropertyServiceClass *service = [[HWPropertyServiceClass alloc] initWithDictionary:arrService[i]];
            [self.arrPropertyService addObject:service];
        }
        
        NSArray *arrTrack = [dic arrayObjectForKey:@"tenementTopicDtoList"];
        for (int i = 0; i < arrTrack.count; i ++)
        {
            [self.arrServiceTrack addObject:[[HWPropertyNewsClass alloc] initWithDictionary:[arrTrack objectAtIndex:i]]];
        }

    }
    return self;
}
@end
