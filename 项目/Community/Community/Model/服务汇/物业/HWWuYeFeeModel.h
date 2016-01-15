//
//  HWWuYeFeeModel.h
//  Community
//
//  Created by niedi on 15/6/11.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWWuYeFeeModel : NSObject

@property (nonatomic, strong) NSString *buildingStr;
@property (nonatomic, strong) NSString *unitNoStr;
@property (nonatomic, strong) NSString *roomStr;
@property (nonatomic, strong) NSString *nameStr;
@property (nonatomic, strong) NSString *propertyStr;
@property (nonatomic, strong) NSString *sDateStr;
@property (nonatomic, strong) NSString *typeStr;
@property (nonatomic, strong) NSString *messageStr;
@property (nonatomic, strong) NSString *wyFeeId;
@property (nonatomic, strong) NSString *WyHouseId;
@property (nonatomic, strong) NSArray *monthArr;
@property (nonatomic, strong) NSString *houseId;


- (instancetype)initWithDict:(NSDictionary *)dict;


@end

/*{
 "name": "山地车",
 "building": null,
 "room": "702",
 "property": 0,
 "sDate": 1435922124000,
 "type": "0",
 "message": "缴费一年免费清洗空调一次",
 "wyFeeId": "2"
 },*/

/*出参：
 /业主名字/
 private String name;
 /楼栋/
 private String building;
 /房号/
 private String room;
 /物业费/
 private Double property;
 /当前缴纳日期/
 private Date sDate;
 /状态 --已拖欠 1 /
private String type;
/优惠信息/
private String message;*/


