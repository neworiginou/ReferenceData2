//
//  ReviewModel.h
//  PUClient
//
//  Created by RRLhy on 15/8/17.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
author = Jimmy222;
bannerUrl = "http://img.rrmj.tv/\U6a2a\U5411\U56fe\U7247url.png";
brief = "\U7b80\U4ecb\U7b80\U4ecb222";
createTime = 1439804001626;
createTimeStr = "1\U79d2\U524d";
id = 22;
posterUrl = "http://img.rrmj.tv/\U5267\U8bc4\U7167\U7247url.png";
seriesId = 20123;
seriesName = "\U95ea\U7535\U4fa0";
title = "\U6807\U98982";
updateTime = 1439804001626;
 */
@interface ReviewModel : NSObject

@property (nonatomic,copy)NSString * author;

@property (nonatomic,copy)NSString * bannerUrl;

@property (nonatomic,copy)NSString * brief;

@property (nonatomic,copy)NSString * createTimeStr;

@property (nonatomic,copy)NSString * ID;

@property (nonatomic,copy)NSString * posterUrl;

@property (nonatomic,copy)NSString * seriesId;

@property (nonatomic,copy)NSString * seriesName;

@property (nonatomic,copy)NSString * title;


@end
