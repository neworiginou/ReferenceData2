//
//  ReviewListModel.h
//  PUClient
//
//  Created by RRLhy on 15/8/17.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReviewListModel : NSObject

@property (nonatomic,assign)NSInteger  currentPage;

@property (nonatomic,assign)NSInteger  total;

@property (nonatomic,strong)NSArray * results;
@end
