//
//  HWChannelTableView.h
//  Community
//
//  Created by hw500028 on 15/1/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWChannelModel.h"
#import "HWSearchView.h"
#import "HWBaseViewController.h"
@class HWChannelTableView;

@class HWSearchListTableView;
@protocol HWChannelTableViewDelegate <NSObject>

@optional
//- (void)channelTableView:(HWChannelTableView *)channelTableView;
/**
 *  searBar将要编辑时的代理
 */
- (void)channelTableView:(HWChannelTableView *)channelTableView searchBarIsEditing:(UISearchBar *)searchBar;
/**
 *  取消按钮点击的代理
 */
- (void)channelTableView:(HWChannelTableView *)channelTableView cancelButtonClicked:(UIButton *)btn;
/**
 *  推控制器的代理
 *
 */
- (void)channelTableView:(HWChannelTableView *)chanelTableView  pushCtroller:(HWChannelModel *)model;

- (void)delegatePushVC:(HWBaseViewController *)vc;

@end

@interface HWChannelTableView : HWBaseRefreshView

@property (nonatomic, assign) id <HWChannelTableViewDelegate>delegate;
@property (nonatomic, strong) HWSearchView *searchView;
@property (nonatomic, assign) BOOL isMoreRecommendOrPastRecord;   //更多推荐 或 足迹

@property (nonatomic, strong) NSMutableArray *pastRecordsarr;//足迹数组

@property (nonatomic, strong) NSString *userId;     //个人主页userId

- (instancetype)initWithFrame:(CGRect)frame WithIsMoreRecommendWithPastRecord:(BOOL)isMoreOrPast personalUserId:(NSString *)userId;

//刷新数据
- (void)refreshList;

@end
