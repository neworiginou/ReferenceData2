//
//  HWAlertItem.h
//  Community
//
//  Created by caijingpeng.haowu on 15/5/4.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWAlertModel : NSObject

@property (nonatomic, strong)NSString *goodsId;
@property (nonatomic, strong)NSString *alertTime;

- (id)initWithInfo:(NSDictionary *)dic;

@end
