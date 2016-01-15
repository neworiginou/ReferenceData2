//
//  HWWuYePayRecordModel.h
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWWuYePayRecordModel : NSObject

@property (nonatomic, strong) NSString *recordId;
@property (nonatomic, strong) NSString *payNum;
@property (nonatomic, strong) NSString *charge;
@property (nonatomic, strong) NSString *payCreateTime;
@property (nonatomic, strong) NSString *payType;
@property (nonatomic, strong) NSString *WyName;
@property (nonatomic, strong) NSString *sTime;
@property (nonatomic, strong) NSString *eTime;
@property (nonatomic, strong) NSString *building_no;
@property (nonatomic, strong) NSString *villageName;
@property (nonatomic, strong) NSString *unit_no;
@property (nonatomic, strong) NSString *room_no;

- (instancetype)initWithDict:(NSDictionary *)dict;


@end

//{
//    WyName = "<null>";
//    "building_no" = 3;
//    charge = 5;
//    eTime = 1435922165000;
//    payCreateTime = 1435231397000;
//    payNum = "<null>";
//    payType = "\U7269\U4e1a\U8d39";
//    recordId = "<null>";
//    "room_no" = 502;
//    sTime = 1435230960000;
//    "unit_no" = 5;
//    villageName = "\U6dee\U6d77\U574a";
//    wyName = "<null>";
//}
/*出参：
 /交易Id/
 public Long recordId;
 /交易流水号/
 public String payNum;
 /金额/
 public Double charge;
 /创建交易时间/
 public Date payCreateTime;
 /缴费费用类型/
 public String payType;
 /物业名字/
 public String WyName;
 /有效期 开始/
 public Date sTime;
 /有效期 结束/
 public Date eTime;
 /楼/
 public String building_no;
 /小区名字/
 public String villageName;
 /单元/
 public String unit_no;
 /房号/
 public String room_no;*/

