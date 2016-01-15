//
//  HWAuthenticateMoreAddressViewController.h
//  Community
//
//  Created by hw500027 on 15/6/24.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HWWuYeAddHouseModel.h"

@protocol HWAuthenticateMoreAddressViewControllerDelegate <NSObject>

- (void)popToAuthenticateStressAddressViewController:(HWWuYeAddHouseModel *)model;

@end

@interface HWAuthenticateMoreAddressViewController : HWBaseViewController
@property (nonatomic , strong) id <HWAuthenticateMoreAddressViewControllerDelegate> delegate;
@end
