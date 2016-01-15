//
//  HWAddShopNumModel.h
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

#import <Foundation/Foundation.h>

@interface HWAddShopNumModel : NSObject
@property (nonatomic,strong)NSString *dictCode;
@property (nonatomic,strong)NSString *dictId;
@property (nonatomic,strong)NSString *disabled;
@property (nonatomic,strong)NSString *iconMongodbKey;
@property (nonatomic,strong)NSString *iconMongodbUrl;
@property (nonatomic,strong)NSString *dictCodeText;


- (id)initShopNumWithDic:(NSDictionary *)dic;

@end
