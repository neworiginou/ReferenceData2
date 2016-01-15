//
//  HWMyWuYeMViewController.h
//  Community
//
//  Created by niedi on 15/6/4.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"

typedef NS_ENUM(NSInteger, MessageType) {
    WuYe = 0,
    MyService = 2,
    System,
};


@interface HWMyWuYeMViewController : HWBaseViewController



@property (nonatomic, strong) NSString *NavTitle;
@property (nonatomic, assign) MessageType type;

@end
