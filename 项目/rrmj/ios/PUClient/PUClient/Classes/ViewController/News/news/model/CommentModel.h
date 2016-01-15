//
//  CommentModel.h
//  PUClient
//
//  Created by RRLhy on 15/8/13.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AuthorModel.h"

@interface CommentModel : NSObject

@property (nonatomic,copy)NSString * content;

@property (nonatomic,strong)AuthorModel * author;

@property (nonatomic,copy)NSString * createTimeStr;

@property (nonatomic,copy)NSString * ID;

@property (nonatomic,strong)AuthorModel * parentAuthor;

@property (nonatomic,copy)NSString * parentContent;

@end
