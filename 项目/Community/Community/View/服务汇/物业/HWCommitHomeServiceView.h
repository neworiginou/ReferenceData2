//
//  HWCommitHomeServiceView.h
//  Community
//
//  Created by niedi on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"

@protocol HWCommitHomeServiceViewDelegate <NSObject>

- (void)cellClickForAddLeaveMessage:(NSString *)beiZhuStr mongokeyArr:(NSArray *)mogokeyArr;

- (void)pushVC:(UIViewController *)vc;

- (void)popVCAction;

@end

@interface HWCommitHomeServiceView : HWBaseRefreshView

@property (nonatomic, weak) id<HWCommitHomeServiceViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame serviceId:(NSString *)serviceId;


- (void)setLeaveMessage:(NSString *)message imgStr:(NSString *)imgStr mongokeyArr:(NSArray *)mongokeyArr;

@end
