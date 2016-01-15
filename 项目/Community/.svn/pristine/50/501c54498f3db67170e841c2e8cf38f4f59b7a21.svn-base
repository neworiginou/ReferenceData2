//
//  HWYouXiDetailModel.m
//  Community
//
//  Created by niedi on 15/1/19.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWGameDetailModel.h"

@implementation HWGameBigImgModel

- (instancetype)initWithDic:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.imgMongodbKey = [dict stringObjectForKey:@"attMongodbKey"];
    }
    return self;
}

@end

@implementation HwGameCommissionModel

- (instancetype)initWithArr:(NSArray *)arr
{
    if (self = [super init])
    {
        
        for (NSDictionary *dict in arr)
        {
            //以commissionType为区分 区分 比例 或 推广金额及类型
            if ([[dict stringObjectForKey:@"commissionType"] isEqualToString:@"0"])
            {
                
                self.commissionAmount = [dict stringObjectForKey:@"commissionAmount"];
                self.commissionCurrency = [dict stringObjectForKey:@"commissionCurrency"];
            }
            else
            {
                self.proportion = [dict stringObjectForKey:@"proportion"];
            }
        }
    }
    return self;
}

@end

@implementation HWGameInfoModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.gameId = [dict stringObjectForKey:@"gameId"];
        self.gameName = [dict stringObjectForKey:@"gameName"];
        self.detailDescription = [dict stringObjectForKey:@"detailDescription"];
        self.iconMongodbKey = [dict stringObjectForKey:@"iconMongodbKey"];
        self.popularizeEnd = [dict stringObjectForKey:@"popularizeEnd"];
        self.appNumber = [dict stringObjectForKey:@"appNumber"];
        self.channelNumber = [dict stringObjectForKey:@"channelNumber"];
        self.status = [dict stringObjectForKey:@"status"];
    }
    return self;
}

@end

@implementation HWGameDetailModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        NSArray *bigimgtmpArr = [dict arrayObjectForKey:@"gameAttachmentList"];
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (NSDictionary *tmpdict in bigimgtmpArr)
        {
            HWGameBigImgModel *imgModel = [[HWGameBigImgModel alloc] initWithDic:tmpdict];
            [tmpArr addObject:imgModel];
        }
        self.gameBigImgArr = [NSMutableArray arrayWithArray:tmpArr];
        
        
        NSArray *gameCommissionTmpArr = [dict arrayObjectForKey:@"gameCommissionList"];
        self.gameCommissionModel = [[HwGameCommissionModel alloc] initWithArr:gameCommissionTmpArr];
        
        
        NSDictionary *gameInfoTmpDic = [dict dictionaryObjectForKey:@"gameInfo"];
        self.gameInfoModel = [[HWGameInfoModel alloc] initWithDict:gameInfoTmpDic];
        
    }
    return self;
}


@end
