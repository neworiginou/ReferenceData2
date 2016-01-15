//
//  HWPropertyComplainModel.m
//  Community
//
//  Created by niedi on 15/6/19.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWPropertyComplainModel.h"

@implementation HWPropertyComplainModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.modelId = [dict stringObjectForKey:@"id"];
        self.content = [dict stringObjectForKey:@"content"];
        self.createTime = [dict stringObjectForKey:@"createTime"];
        self.createTimeStr = [dict stringObjectForKey:@"createTimeStr"];
        self.imagesArr = [dict arrayObjectForKey:@"imageList"];
        self.status = [dict stringObjectForKey:@"status"];
        self.result = [dict stringObjectForKey:@"result"];
        self.spendTimeStr = [dict stringObjectForKey:@"spendTimeStr"];
//        if ([self.spendTimeStr rangeOfString:@"小时"].location != NSNotFound)
//        {
//            NSRange range = [self.spendTimeStr rangeOfString:@"小时"];
//            
//            self.spendTimeStr = [self.spendTimeStr substringToIndex:range.location + range.length];
//        }
        self.isFold = YES;
        
        NSArray *tmpSonArr = [dict arrayObjectForKey:@"sonList"];
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (NSDictionary *dict in tmpSonArr)
        {
            HWPropertyComplainModel *model = [[HWPropertyComplainModel alloc] initWithDict:dict];
            [tmpArr addObject:model];
        }
        self.sonList = [NSArray arrayWithArray:tmpArr];
        
    }
    return self;
}

@end

/*{
    comment = "<null>";
    content = "\U6211\U4eec\U7684\U7535\U68af\U574f\U4e86";
    createTime = 1434383999000;
    createTimeStr = "3\U5929\U524d";
    creater = 1011848011849;
    disabled = "<null>";
    id = 2071741;
    image = "<null>";
    images = "<null>";
    modifier = "<null>";
    modifyTime = 1434691691000;
    parentId = 0;
    proprietorId = 1011848011849;
    result = 1;
    sonList =                 (
                               {
                                   comment = "<null>";
                                   content = "ctrxtdy gg gg ggg the first";
                                   createTime = 1434527697000;
                                   createTimeStr = "1\U5929\U524d";
                                   creater = 1001243001243;
                                   disabled = "<null>";
                                   id = 2071966;
                                   image = "<null>";
                                   images =                         (
                                   );
                                   modifier = "<null>";
                                   modifyTime = 1434527697000;
                                   parentId = 2071741;
                                   proprietorId = "<null>";
                                   result = "<null>";
                                   sonList =                         (
                                   );
                                   spendTimeStr = "<null>";
                                   status = 0;
                                   villageId = "<null>";
                               }
                               );
    spendTimeStr = "<null>";
    status = 0;
    villageId = 10;
}*/
