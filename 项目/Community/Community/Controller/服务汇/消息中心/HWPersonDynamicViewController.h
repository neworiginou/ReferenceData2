//
//  HWPersonDymnamicViewController.h
//  Community
//
//  Created by hw500027 on 15/1/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"

//代理方法
@protocol HWPersonDynamicViewControllerDelegate <NSObject>

@optional
- (void)didRefreshDynamicIndex;

@end

@interface HWPersonDynamicViewController : HWBaseViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id<HWPersonDynamicViewControllerDelegate> delegate;


@end
