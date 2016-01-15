//
//  HWNeighbourViewController.h
//  Community
//
//  Created by niedi on 15/4/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HWCustomSegmentControl.h"
#import "HWRecommendView.h"
#import "HWTopicListViewController.h"

@interface HWNeighbourViewController : HWBaseViewController<HWCustomSegmentControlDelegate, HWRecommendViewDelegate, HWChannelTableViewDelegate>
{
    UIImageView *gView;
}

@property (nonatomic, strong) HWRecommendView *recommendView;
@property (nonatomic, strong) HWChannelTableView *pastRecordView;
@property (nonatomic, assign) int segmentSelectIndex;


- (void)refreshList;

@end
