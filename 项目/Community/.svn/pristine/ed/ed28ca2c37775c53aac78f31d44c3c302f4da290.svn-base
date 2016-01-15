//
//  HWYouXiDetailModel.h
//  Community
//
//  Created by niedi on 15/1/19.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HWGameBigImgModel : NSObject

@property (nonatomic, strong) NSString *imgMongodbKey;

- (instancetype)initWithDic:(NSDictionary *)dict;

@end



@interface HwGameCommissionModel : NSObject

@property (nonatomic, strong) NSString *commissionAmount;
@property (nonatomic, strong) NSString *commissionCurrency;
@property (nonatomic, strong) NSString *proportion;

- (instancetype)initWithArr:(NSArray *)arr;

@end



@interface HWGameInfoModel : NSObject

@property (nonatomic, strong) NSString *iconMongodbKey;
@property (nonatomic, strong) NSString *detailDescription;
@property (nonatomic, strong) NSString *popularizeEnd;
@property (nonatomic, strong) NSString *gameName;
@property (nonatomic, strong) NSString *gameId;
@property (nonatomic, strong) NSString *appNumber;
@property (nonatomic, strong) NSString *channelNumber;
@property (nonatomic, strong) NSString *status;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end


@interface HWGameDetailModel : NSObject

@property (nonatomic, strong) NSArray *gameBigImgArr;
@property (nonatomic, strong) HwGameCommissionModel *gameCommissionModel;
@property (nonatomic, strong) HWGameInfoModel *gameInfoModel;


- (instancetype)initWithDict:(NSDictionary *)dict;

@end
