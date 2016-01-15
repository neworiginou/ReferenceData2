//
//  HWMyPriviledgeModel.h
//  Community
//
//  Created by gusheng on 14-12-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWMyPriviledgeModel : NSObject
@property(nonatomic,strong)NSString *priviledgeIdStr;
@property(nonatomic,strong)NSString *priviledgeNumStr;
@property(nonatomic,strong)NSString *priviledgeImageUrl;
@property(nonatomic,strong)NSString *priviledgeStatus;//过期还是未过期

-(id)initWithDic:(NSDictionary *)dic;
@end
