//
//  HWTabBarViewController.h
//  Community
//
//  Created by caijingpeng.haowu on 14-8-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWServiceViewController.h"
#import "HWNeighbourViewController.h"
#import "HWFuLiSheViewController.h"
#import "HWPersonInfoViewController.h"

@class HWTabBarViewController;

@interface HWTabBarViewController : UITabBarController <UITabBarControllerDelegate>

@property (nonatomic,strong) HWServiceViewController *serviceVC;
@property (nonatomic,strong) HWNeighbourViewController *neighbourVC;
@property (nonatomic,strong) HWFuLiSheViewController *shareVC;
@property (nonatomic, strong)HWPersonInfoViewController *personVC;
- (void)showTabbarNeighbourDot;
- (void)hiddenTabbarNeighourDot;
- (void)showTabbarMineDot;
- (void)hiddenTabbarMineDot;
- (void)showServiceMessageCenterRedDot;

@end
