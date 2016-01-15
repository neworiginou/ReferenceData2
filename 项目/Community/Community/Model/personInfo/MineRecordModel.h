//
//  MineRecordModel.h
//  TEST
//
//  Created by gusheng on 14-8-29.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MinitueAndSecondOfDateModel.h"

@interface MineRecordModel : NSObject
@property(nonatomic,strong)NSString *phoneStr;
@property(nonatomic,strong)NSString *scanStr;
@property(nonatomic,strong)NSString *activeStr;
@property(nonatomic,strong)NSString *registerStr;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
