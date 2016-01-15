//
//  HWPersonalHomePageDetailVC.h
//  Community
//
//  Created by niedi on 15/4/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HWCustomSegmentControl.h"
#import "HWChannelView.h"
#import "HWChannelTableView.h"
#import "HWAddChannelViewController.h"
#import "HWTopicListViewController.h"

@interface HWPersonalHomePageDetailVC : HWBaseViewController<HWCustomSegmentControlDelegate, HWChannelViewDelegate, HWAddChannelViewControllerDelegate, HWChannelTableViewDelegate>
{
    NSArray *_TaTitleArr;
    NSArray *_WoTitleArr;
}

@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, assign) NSString *userId;
@property (nonatomic, strong) HWChannelView *themeView;
@property (nonatomic, strong) HWChannelTableView *topicView;
@property (nonatomic, weak) UIViewController *personalVC;

@end
