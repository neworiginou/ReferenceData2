//
//  HWServiceMoreView.h
//  Community
//
//  Created by niedi on 15/6/25.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"

@protocol HWServiceMoreViewDelegate <NSObject>

- (void)setRefresh;

- (void)pushVC:(UIViewController *)VC;

@end


@interface HWServiceMoreView : HWBaseRefreshView

@property (nonatomic, strong) UIViewController *fatherVC;

@property (nonatomic, weak) id<HWServiceMoreViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame homePageIconArr:(NSArray *)iconArr;



@end
