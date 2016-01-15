//
//  HWInviteCustomRecord1View.h
//  Community
//
//  Created by niedi on 15/6/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"

@protocol HWInviteCustomRecord1ViewDelegate <NSObject>

- (void)pushViewController:(UIViewController *)vc;

@end

@interface HWInviteCustomRecord1View : HWBaseRefreshView

@property (nonatomic, weak) id<HWInviteCustomRecord1ViewDelegate> delegate;


@end
