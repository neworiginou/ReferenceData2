//
//  HWServiceListView.h
//  Community
//
//  Created by hw500027 on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWServiceListDetailViewController.h"
#import "HWServiceListModel.h"

@protocol HWServiceListViewDelegate <NSObject>

- (void)didSelectListView:(UIViewController *)vc;

- (void)pushToEvaluateVC:(NSString *)orderId;

@end

@interface HWServiceListView : HWBaseRefreshView

@property (nonatomic , strong) id <HWServiceListViewDelegate> delegate;

- (void)reQueryListData;

@end
