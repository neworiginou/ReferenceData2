//
//  HWCommunityViewController.h
//  Community
//
//  Created by caijingpeng.haowu on 14-9-7.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  开店 周边小区
//

#import "HWBaseViewController.h"
#import "HWSearchBarView.h"
#import "HWCommunityCell.h"
#import "HWRefreshBaseViewController.h"
#import "NoCommunityView.h"

@interface HWCommunityViewController : HWRefreshBaseViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, HWSearchBarViewDelegate, HWCommunityCellDelegate,UIAlertViewDelegate>
{
    UITableView *mainTV;
    UIView *noCommentView;
    NSMutableArray *slectedCommunityArry;
    NSInteger clickCount;
    NSMutableArray *searchResultArry;
}

@property (nonatomic, strong)NSArray *communities;
@property (nonatomic, strong)NSString *cityId;
@property (nonatomic, strong)NSString *villageId;
@property (nonatomic, strong)NSMutableArray *slectedCommunityArry;
@property (nonatomic, strong)NSMutableArray *searchResultArry;
@property (nonatomic, strong)void(^SlectedCommunity)(NSString *communityStrS,NSMutableArray *selectArry);
@property (nonatomic, strong)NSMutableArray *frontArry;


@end
