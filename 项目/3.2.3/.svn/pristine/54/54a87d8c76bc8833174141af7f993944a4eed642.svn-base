//
//  HWRefreshBaseViewController.h
//  Community
//
//  Created by caijingpeng.haowu on 14-8-29.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseViewControllerOC.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
#import "SRRefreshView.h"

@interface HWRefreshBaseViewController : HWBaseViewControllerOC<UITableViewDataSource,UITableViewDelegate, EGORefreshTableDelegate, SRRefreshDelegate>
{
    UITableView *baseTableView;
    NSMutableArray *dataList;
    int _currentPage;
    EGORefreshTableHeaderView   *refrehHeadview;
    EGORefreshTableFooterView *_refreshFooterView;
    UIView  *refreshTailView;
    UILabel *endLabel;
    
    BOOL    isHeadLoading;      //顶部刷新
    BOOL    isTailLoading;      //底部刷新
    BOOL    isLastPage;         //是否为最后一页
    
    
    //add by 李中强 2015-03-26 16:53:39
    SRRefreshView *slimeView;
}

@property (nonatomic, strong)UITableView *baseTableView;
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
