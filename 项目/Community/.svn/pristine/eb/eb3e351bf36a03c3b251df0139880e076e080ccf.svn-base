//
//  HWMessageCenterViewController.h
//  Community
//
//  Created by niedi on 15/6/4.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"

//代理方法
@protocol HWMessageCenterViewControllerDelegate <NSObject>

@optional
- (void)didRefreshDynamicIndex;

@end

@interface HWMessageCenterViewController : HWBaseViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id<HWMessageCenterViewControllerDelegate> delegate;

@end


