//
//  HWRefreshBaseViewController.h
//  Community
//
//  Created by caijingpeng.haowu on 14-8-29.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

@interface HWRefreshBaseViewController : HWBaseViewController<UITableViewDataSource,UITableViewDelegate, EGORefreshTableDelegate >
{
    JPBaseTableView *baseTableView;
    NSMutableArray *dataList;
    int _currentPage;
    EGORefreshTableHeaderView   *refrehHeadview;
    EGORefreshTableFooterView *_refreshFooterView;
    UIView  *refreshTailView;
//    UILabel *endLabel;
    UIView *endView;
    
    BOOL    isHeadLoading;      //顶部刷新
    BOOL    isTailLoading;      //底部刷新
    BOOL    isLastPage;         //是否为最后一页
}

@property (nonatomic, strong)JPBaseTableView *baseTableView;
@property (nonatomic, strong)NSMutableArray *dataList;
@property (nonatomic, assign)BOOL isNeedHeadRefresh;
@property (nonatomic, assign)int _currentPage;

- (void)queryListData;
- (void)doneLoadingTableViewData;
- (void)showEmpty:(NSString*)msg;
- (void)showEmpty:(NSString *)msg withOffset:(float)offset;
- (void)hideEmpty;
- (void)autoDragRefresh;

- (void)showNewEmpty:(NSString *)msg;
- (void)hideNewEmpty;

@end
