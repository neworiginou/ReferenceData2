//
//  HWServiceListDetailView.h
//  Community
//
//  Created by hw500027 on 15/6/18.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWServiceEvaluateVC.h"
#import "HWServiceListDetailViewController.h"

@protocol HWServiceListDetailViewDelegate <NSObject>

- (void)didClickBtnToCommentVC:(UIViewController *)vc;
- (void)showRightBarButtonItem:(BOOL)isShow;

@end

@interface HWServiceListDetailView : HWBaseRefreshView

@property (nonatomic , strong) id <HWServiceListDetailViewDelegate> delegate;

@property (nonatomic, assign) pushHomeServiceDetailType pushType;


- (instancetype)initWithFrame:(CGRect)frame withOrderID:(NSString *)orderID;


@end
