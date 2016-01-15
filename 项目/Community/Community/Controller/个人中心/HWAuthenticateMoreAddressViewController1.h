//
//  HWAuthenticateMoreAddressViewController1.h
//  Community
//
//  Created by hw500027 on 15/6/24.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HWWuYeAddHouseModel.h"

@protocol HWAuthenticateMoreAddressViewController1Delegate <NSObject>

- (void)popToMoreAddressVC:(HWWuYeAddHouseModel *)model;

@end

@interface HWAuthenticateMoreAddressViewController1 : HWBaseViewController
@property (nonatomic , strong) id <HWAuthenticateMoreAddressViewController1Delegate> delegate;
@property (nonatomic , strong)  HWWuYeAddHouseModel *model;
@end
