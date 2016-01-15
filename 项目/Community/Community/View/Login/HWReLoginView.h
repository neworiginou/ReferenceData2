//
//  HWReLoginView.h
//  Community
//
//  Created by niedi on 15/8/3.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"

@protocol HWReLoginViewDelegate <NSObject>

- (void)goToRegist:(NSString *)mobilNum;
- (void)goToLogin:(NSString *)mobilNum;
- (void)pushViewController:(UIViewController *)vc;

@end

@interface HWReLoginView : HWBaseRefreshView

@property (nonatomic, weak) id<HWReLoginViewDelegate> delegate;

@end
