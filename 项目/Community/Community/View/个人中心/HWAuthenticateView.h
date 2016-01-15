//
//  HWAuthenticateView.h
//  Community
//
//  Created by hw500027 on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWAuthenticateMoreAddressViewController.h"

@protocol HWAuthenticateViewDelegate <NSObject>

- (void)didSelectConfirmBtn;
- (void)didSelectAddAddressLabel:(UIViewController *)vc;

@end

@interface HWAuthenticateView : HWBaseRefreshView
@property (nonatomic , strong) id <HWAuthenticateViewDelegate> delegate;
@end
