//
//  HWWuYeServiceView.h
//  Community
//
//  Created by niedi on 15/6/11.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"

@protocol HWWuYeServiceViewDelegate <NSObject>

- (void)pushViewController:(UIViewController *)VC;

@end

@interface HWWuYeServiceView : HWBaseRefreshView

@property (nonatomic, strong) UIViewController *fatherVC;

@property (nonatomic, weak) id<HWWuYeServiceViewDelegate> delegate;

@property (nonatomic, strong) NSArray *homePageIconArr;


- (instancetype)initWithFrame:(CGRect)frame isCompany:(BOOL)isCompany;//是否是合作物业



@end
