//
//  HWWinnerModel.h
//  Community
//
//  Created by caijingpeng.haowu on 14-12-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWWinnerModel : NSObject

@property (nonatomic, strong) NSString *wId;
@property (nonatomic, strong) NSString *cutUserId;
@property (nonatomic, strong) NSString *cutId;
@property (nonatomic, strong) NSString *cutPrice;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *winnerId;

- (id)initWithWinner:(NSDictionary *)info;

@end
