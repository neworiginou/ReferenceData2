//
//  HWCommondityDetailViewController.h
//  Community
//
//  Created by ryder on 7/30/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HWCommondityDetailView.h"

@interface HWCommondityDetailViewController : HWBaseViewController<HWCommodityDelegate>

@property (nonatomic, strong) HWCommondityDetailView *detailView;
@property (nonatomic, strong) HWCommondityModel *model;


@end
