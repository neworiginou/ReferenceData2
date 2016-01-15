//
//  HWPublicRepairModel.h
//  Community
//
//  Created by niedi on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWPublicRepairModel : NSObject

@property (nonatomic, strong) NSString *modelId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *modifyTime;
@property (nonatomic, strong) NSString *createTimeStr;
@property (nonatomic, strong) NSArray *imagesArr;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *spendTimeStr;

- (instancetype)initWithDict:(NSDictionary *)dict;


@end

/*{ "nickName": 昵称, "status": 状态,当前状态(0待处理,1处理中,2处理完毕) "result": 评论结果,结果(0,不满意,1满意) "createTimeStr": 创建时间, "spendTimeStr": 耗时, "images": 图片, } */

/*{
 comment = "<null>";
 content = "\U4ec0\U4e48\U53fc\U95ee\U9898\U90fd\U6709";
 contentImages = "134sadf;sdfg";
 createTime = 1434111870000;
 createTimeStr = "5\U5929\U524d";
 creater = "<null>";
 disabled = "<null>";
 id = 32;
 images =                 (
 "file/downloadByKey.do?mKey=134sadf;sdfg"
 );
 modifyTime = 1434370795000;
 nickName = "<null>";
 result = "<null>";
 spendTimeStr = "<null>";
 status = 0;
 userId = 1234;
 villageId = 10;
 workorderId = "<null>";
 },*/

