//
//  HWCoinDetailModel.h
//  Community
//
//  Created by gusheng on 14-12-12.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWCoinDetailModel : NSObject
@property(nonatomic,strong)NSString *tradeType;
@property(nonatomic,strong)NSString *orderNum;
@property(nonatomic,strong)NSString *orderStatus;
@property(nonatomic,strong)NSString *money;
@property(nonatomic,strong)NSString *user;
@property(nonatomic,strong)NSString *project;
@property(nonatomic,strong)NSString *tradeObject;
@property(nonatomic,strong)NSString *tradeTime;
@property(nonatomic,strong)NSString *isDisabled;
-(id)initWithDic:(NSDictionary *)dic;
@end
