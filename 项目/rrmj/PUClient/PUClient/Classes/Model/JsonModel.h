//
//  JsonModel.h
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonModel : NSObject
@property (nonatomic,copy)NSString * errorCode;
@property (nonatomic,assign)BOOL success;
@property (nonatomic,assign)NSDictionary * data;
@end
