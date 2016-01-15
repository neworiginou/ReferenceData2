//
//  HWTopicListViewController.h
//  Community
//
//  Created by hw500029 on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HWChannelModel.h"
#import "HWChannelView.h"

@interface HWTopicListViewController : HWBaseViewController<HWChannelViewDelegate, HWAddChannelViewControllerDelegate>
{
    HWChannelView *_channelView;
}
@property (nonatomic,copy)NSString *topicTitle;

@property (nonatomic,strong)HWChannelModel *channelModel;
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, assign) BOOL  isSearchBarPush;

@property (nonatomic,strong)NSString *defaustArea;

@end
