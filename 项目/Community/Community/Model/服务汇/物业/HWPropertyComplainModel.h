//
//  HWPropertyComplainModel.h
//  Community
//
//  Created by niedi on 15/6/19.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWPropertyComplainModel : NSObject

@property (nonatomic, strong) NSString *modelId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *createTimeStr;
@property (nonatomic, strong) NSArray *imagesArr;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *spendTimeStr;
@property (nonatomic, strong) NSArray *sonList;
@property (nonatomic, assign) BOOL isFold;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

/*{
 "id": 1,投诉id
 "proprietorId": 1,投诉人id
 "content": "1111",投入内容
 "status": 1,当前状态(0待处理,1处理中,2处理完毕)
 "parentId": 0,关联投诉id
 "comment": null,
 "result": 评论结果,结果(0,不满意,1满意)
 "villageId": 12797,小区id
 "creater": null,创建人id
 "createTime": 1434077784000,
 "modifier": null,
 "disabled": null,
 "createTimeStr": "3小时前",创建时间
 "spendTimeStr": "耗时：23小时0分钟",处理耗时
 "image": null,
 "modifyTime": 1434160625000,
 "images": null,图片key
 "sonList": [子投诉*/

/*{
    comment = "<null>";
    content = "\U6211\U4eec\U7684\U7535\U68af\U574f\U4e86";
    createTime = 1434383999000;
    createTimeStr = "3\U5929\U524d";
    creater = 1011848011849;
    disabled = "<null>";
    id = 2071741;
    image = "<null>";
    images = "<null>";
    modifier = "<null>";
    modifyTime = 1434691691000;
    parentId = 0;
    proprietorId = 1011848011849;
    result = 1;
    sonList =                 (
                               {
                                   comment = "<null>";
                                   content = "ctrxtdy gg gg ggg the first";
                                   createTime = 1434527697000;
                                   createTimeStr = "1\U5929\U524d";
                                   creater = 1001243001243;
                                   disabled = "<null>";
                                   id = 2071966;
                                   image = "<null>";
                                   images =                         (
                                   );
                                   modifier = "<null>";
                                   modifyTime = 1434527697000;
                                   parentId = 2071741;
                                   proprietorId = "<null>";
                                   result = "<null>";
                                   sonList =                         (
                                   );
                                   spendTimeStr = "<null>";
                                   status = 0;
                                   villageId = "<null>";
                               }
                               );
    spendTimeStr = "<null>";
    status = 0;
    villageId = 10;
},*/


