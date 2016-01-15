//
//  HWServiceListDetailViewController.h
//  Community
//
//  Created by hw500027 on 15/6/18.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"

typedef NS_ENUM(NSInteger, pushHomeServiceDetailType) {
    pushHomeServiceDetailTypeList = 0,              //从列表进人详情 pop时回到列表
    pushHomeServiceDetailTypeWY,                    //从物业或首页或更多进人详情，pop到上门服务前一页
};

@interface HWServiceListDetailViewController : HWBaseViewController


@property (nonatomic , strong) NSString *orderID;

@property (nonatomic, assign) pushHomeServiceDetailType pushType;


@end





