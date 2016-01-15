//
//  NewsIntroModel.h
//  PUClient
//
//  Created by RRLhy on 15/8/12.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "subTitle":"子标题1",
 "imgList":[
 "http://img.rrmj.tv/article/20150731/b_1438322050770.jpg",
 "http://img.rrmj.tv/article/20150731/b_1438322050770.jpg",
 "http://img.rrmj.tv/article/20150731/b_1438322050770.jpg",
 "http://img.rrmj.tv/article/20150731/b_1438322050770.jpg"
 ],
 "commentCount":101,
 "showType":"common",
 "title":"标题1",
 "createTime":1439190147800,
 "createTimeStr":"1秒前",
 "updateTime":1439190147800,
 "id":1*/
@interface NewsIntroModel : NSObject

@property (nonatomic,copy)NSString * subTitle;

@property (nonatomic,copy)NSString * commentCount;

@property (nonatomic,copy)NSString * showType;

@property (nonatomic,copy)NSString * title;

@property (nonatomic,copy)NSString * createTimeStr;

@property (nonatomic,copy)NSString * ID;

@property (nonatomic,strong)NSArray * imgList;


@end
