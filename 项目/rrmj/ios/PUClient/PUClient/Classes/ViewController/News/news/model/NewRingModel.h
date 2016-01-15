//
//  NewRingModel.h
//  PUClient
//
//  Created by RRLhy on 15/8/12.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
createTime = 1439381576360;
createTimeStr = "1\U79d2\U524d";
id = 6;
imgUrl = "http://img.rrmj.tv/article/20150730/b_1438237032738.jpg";
sequence = 1;
targetUrl = 8556;
title = "\U300a\U7f8e\U5c11\U5973\U7684\U8c0e\U8a00\U300b\U7279\U8389\U5b89\U518d\U5ea6\U5ba2\U4e32\U672a\U5a5a\U592b\U4f5c\U54c1\U300a\U8bc9\U8bbc\U53cc\U96c4\U300b";
type = info;
updateTime = 1439381576360;
 */
@interface NewRingModel : NSObject

@property (nonatomic,copy)NSString * createTimeStr;

@property (nonatomic,copy)NSString * imgUrl;

@property (nonatomic,copy)NSString * title;

@property (nonatomic,copy)NSString * targetUrl;

@property (nonatomic,copy)NSString * type;

@property (nonatomic,copy)NSString * ID;

@property (nonatomic,copy)NSString * sequence;

@end
