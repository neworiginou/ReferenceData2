//
//  NewsDetailModel.h
//  PUClient
//
//  Created by RRLhy on 15/8/13.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetailModel : NSObject

@property (nonatomic,strong)NSArray * actorViewList;

@property (nonatomic,strong)NSArray * seriesViewList;

@property (nonatomic,strong)NSArray * paragraphViewList;

@property (nonatomic,assign)BOOL isFavorite;

@property (nonatomic,copy)NSString * commentCount;

@property (nonatomic,copy)NSString * createTimeStr;

@property (nonatomic,copy)NSString * ID;

@end
