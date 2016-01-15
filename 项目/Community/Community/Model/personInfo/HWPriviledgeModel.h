//
//  HWPriviledgeModel.h
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWPriviledgeModel : NSObject

@property(nonatomic,strong)NSString * priviledgeId;
@property(nonatomic,strong)NSString * timeStr;//活动开始时间
//@property(nonatomic,strong)NSString * hourStr;
//@property(nonatomic,strong)NSString * minitueStr;
//@property(nonatomic,strong)NSString * secondStr;
@property(nonatomic,strong)NSString * priviledgeType;//1-4代表未开始，已开抢，已抢完，已下线
@property(nonatomic,strong)NSString * priviledgeImageUrl;//优惠劵图片Url
@property(nonatomic,strong)NSString * remainMsStr;

-(id)initWithDic:(NSDictionary *)dic;

@end
