//
//  HWAddShopNumModel.m
//  Community
//
//  Created by hw500028 on 14/12/10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
/*
 
 dictCode = "<null>";
 dictCodeText = "\U6536\U5e9f\U54c1";
 dictId = 209;
 disabled = 0;
 iconMongodbKey = 5456e01ae4b0783fec719144;
 iconMongodbUrl = "file/downloadByKey.do?mKey=5456e01ae4b0783fec719144";

 */
#import "HWAddShopNumModel.h"

@implementation HWAddShopNumModel

- (id)initShopNumWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        
        self.dictCode = [dic stringObjectForKey:@"dictCode"];
        self.dictCodeText = [dic stringObjectForKey:@"dictCodeText"];
        self.dictId = [dic stringObjectForKey:@"dictId"];
        self.disabled = [dic stringObjectForKey:@"disabled"];
        self.iconMongodbKey = [dic stringObjectForKey:@"iconMongodbKey"];
        self.iconMongodbUrl = [dic stringObjectForKey:@"iconMongodbUrl"];


    }
    return self;
}

@end
