//
//  DateModel.h
//  PUClient
//
//  Created by RRLhy on 15/8/12.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateModel : NSObject

@property (nonatomic,assign)BOOL unfold;

@property (nonatomic,copy)NSString * day;

@property (nonatomic,copy)NSString * weekDay;

@property (nonatomic,copy)NSString * month;

@property (nonatomic,strong)NSArray * seriesArray;

@end
