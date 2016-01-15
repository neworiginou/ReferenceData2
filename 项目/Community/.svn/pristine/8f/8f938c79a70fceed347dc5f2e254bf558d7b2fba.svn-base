//
//  HWWuYeServiceModel.h
//  Community
//
//  Created by niedi on 15/6/11.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWWuYePublishNoticeModel.h"

@interface HWWuYeServiceModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *openTime;
@property (nonatomic, strong) NSString *coStatus;
@property (nonatomic, strong) HWWuYePublishNoticeModel *publishModel;
@property (nonatomic, strong) NSString *hasUnread;
@property (nonatomic, strong) NSArray *telArr;

- (instancetype)initWithdict:(NSDictionary *)dict;

@end

/*接口 ：hw-sq-app-web/wy/queryWyDetailInfo.do
 入参：key=6f5ddc33-b076-422c-bdc0-c099a0d14717
 出参：
 {
 'status': '1',
 'data': {
 'tenementId': 1033575543,
 'name': '小张物业',
 'intro': '松岛枫',
 'address': '上海呼兰路',
 'openTime': '09:00-23:00',
 'coStatus': 1,---合作状态:0,已合作，1：未合作
 'tenementTel': [
 ],
 'topic':
 { 'topicId': 1034481469, 'content': '和好久没有尤文图斯', 'createTime': 1423727247000 }
 },
 'detail': '请求数据成功!',
 'key': '6f5ddc33-b076-422c-bdc0-c099a0d14717'
 }*/