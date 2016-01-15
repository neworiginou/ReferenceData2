//
//  HWAddChannelViewController.h
//  Community
//
//  Created by caijingpeng.haowu on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HWChannelModel.h"

@protocol HWAddChannelViewControllerDelegate <NSObject>

@optional
- (void)didSelectChannel:(HWChannelModel *)model;
- (void)didDeleteSelectedChannel;

@end

@interface HWAddChannelViewController : HWBaseViewController

@property (nonatomic, assign) id<HWAddChannelViewControllerDelegate> delegate;
@property (nonatomic, strong) HWChannelModel *currentChannel;

@end
