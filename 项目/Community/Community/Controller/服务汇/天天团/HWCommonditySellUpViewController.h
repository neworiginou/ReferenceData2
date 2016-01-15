//
//  HWCommonditySellUpViewController.h
//  Community
//
//  Created by ryder on 7/30/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//

#import "HWRefreshBaseViewController.h"
#import "HWCommonditySellUpView.h"

@interface HWCommonditySellUpViewController : HWRefreshBaseViewController<HWCommodityDelegate>

@property (nonatomic, strong) HWCommonditySellUpView* sellupView;

@end
