//
//  CommentListModel.h
//  PUClient
//
//  Created by RRLhy on 15/8/13.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentListModel : NSObject

@property (nonatomic,copy)NSString * total;

@property (nonatomic,copy)NSString * currentPage;

@property (nonatomic,strong)NSArray * results;

@end
