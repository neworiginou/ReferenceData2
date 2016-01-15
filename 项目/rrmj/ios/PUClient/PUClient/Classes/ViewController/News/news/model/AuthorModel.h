//
//  AuthorModel.h
//  PUClient
//
//  Created by RRLhy on 15/8/13.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorModel : NSObject

@property (nonatomic,assign)NSInteger level;

@property (nonatomic,copy)NSString * nickName;

@property (nonatomic,copy)NSString * headImgUrl;

@property (nonatomic,copy)NSString * ID;

@end
