//
//  HWPriviledgeDetailModel.h
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWPriviledgeDetailModel : NSObject

@property(nonatomic,strong)NSString *priviledgeImageUrl;
@property(nonatomic,strong)NSString *shareUrl;
@property(nonatomic,strong)NSString *priviledgeUrl;
@property(nonatomic,strong)NSString *timeStr;
@property(nonatomic,strong)NSString *totalPriviledge;
@property(nonatomic,strong)NSString *remainPriviledge;
@property(nonatomic,strong)NSString *priviledgeContent;
@property(nonatomic,strong)NSString *brandStr;
@property(nonatomic,strong)NSString *starTime;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSArray *ruleArry;
@property(nonatomic,strong)NSString *priviledgeType;//优惠劵类型1代表活动未开始，0正在进行，2已结束
@property(nonatomic,strong)NSString *sharePriviledgeStatus;//是否分享过优惠劵
@property(nonatomic,strong)NSString *priviledgeOrderNum;//优惠劵劵号
@property (nonatomic, strong) NSString *remainMS;

-(id)initWithDic:(NSDictionary *)dic;

@end

