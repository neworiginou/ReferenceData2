//
//  NewRingListModel.h
//  PUClient
//
//  Created by RRLhy on 15/8/12.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewRingListModel : NSObject

@property (nonatomic,copy)NSString * total;

@property (nonatomic,copy)NSString * currentPage;

@property (nonatomic,retain)NSArray * results;

@end
