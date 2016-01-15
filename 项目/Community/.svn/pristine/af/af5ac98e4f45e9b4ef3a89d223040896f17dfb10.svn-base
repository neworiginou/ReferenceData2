//
//  HWHomeServiceInfoModel.h
//  Community
//
//  Created by niedi on 15/6/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWHomeServiceInfoModel : NSObject

@property (nonatomic, strong) NSString *serviceBrief;
@property (nonatomic, strong) NSString *serviceDescribe;
@property (nonatomic, strong) NSArray *serviceItemArr;
@property (nonatomic, strong) NSArray *additionalServiceItemArr;


- (instancetype)initWithDict:(NSDictionary *)dict;

@end

/*接口：hw-sq-app-web/comeDoorService/showComeServiceInfo.do 服务查询页
 入参：key：用户key
 serviceId：服务id
 输出参数：
 {
 "status": "1",
 "data": {
 "id": 1,
 "proprietorId": null,
 "serviceConfigId": 1,
 "serviceDescribe": "上门家电清洗，随叫随到，电话:18717969610",服务描述
 "serviceBrief": "上门家电清洗",服务简介
 "propertyAttachmentDTOList": [附加项
 { "id": 1, "name": "附加商品列表",附加商品名称 "price": 100,价格 "unit": "个",单位 }
 
 ],
 "propertyServicePriceDTOList": [
 { "id": 1, "name": "上门服务",服务名称 "price": 100,价格 "priceUnit": "瓶"单位 }
 
 ]
 },
 "detail": "请求数据成功!",
 "key": "3a956781-6179-47af-8af3-d28d4554b87d"
 }*/

/*data =     {
    id = 99;
    propertyAttachmentDTOList =         (
                                         {
                                             id = 5;
                                             name = "\U6d17\U8863\U670d\U52a1\U9644\U52a02\U78a7\U6d6a\U6d17\U8863\U6db2";
                                             price = 7;
                                             unit = "\U74f6";
                                         },
                                         {
                                             id = 99;
                                             name = "\U6d17\U8863ji\U670d\U52a1\U9644\U52a02\U78a7\U6d6a\U6d17\U8863\U6db2";
                                             price = 3;
                                             unit = "\U74f6";
                                         }
                                         );
    propertyServicePriceDTOList =         (
                                           {
                                               id = 99;
                                               name = "\U4e0a\U95e8\U6e05\U6d01\U626b\U5730";
                                               price = 998;
                                               priceUnit = 10;
                                           }
                                           );
    proprietorId = "<null>";
    serviceBrief = "\U4e0a\U95e8\U626b\U5730";
    serviceConfigId = 99;
    serviceDescribe = "\U4e13\U4e1a\U626b\U573020\U5e74";
};
detail = "\U8bf7\U6c42\U6570\U636e\U6210\U529f!";
key = "6f5ddc33-b076-422c-bdc0-c099a0d14717";
status = 1;
}*/