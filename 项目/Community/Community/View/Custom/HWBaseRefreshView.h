//
//  HWBaseRefreshView.h
//  MoreHouse
//
//  Created by lizhongqiang on 14/11/18.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
#import "JPBaseTableView.h"

@interface HWBaseRefreshView : UIView<UITableViewDataSource,UITableViewDelegate,EGORefreshTableDelegate>
{
    BOOL isHeadLoading;         //顶部刷新
    BOOL isTailLoading;         //底部刷新
    BOOL isLastPage;            //是否为最后一页
    BOOL isNeedHeadRefresh;     //是否需要顶部刷新
    
    CGRect baseFrame;
    EGORefreshTableHeaderView *refrehHeadview;
    UIView *refreshTailview;
    EGORefreshTableFooterView *_refreshFooterView;
    UIView *endView;
}

@property (nonatomic, strong)   JPBaseTableView *baseTable;
@property (nonatomic, strong)   NSMutableArray *baseListArr;
@property (nonatomic)           int currentPage;
@property (nonatomic)           BOOL isNeedHeadRefresh;

- (void)doneLoadingTableViewData;
- (void)queryListData;

- (void)showEmptyView:(NSString *)message;
- (void)showEmpty:(NSString *)msg withOffset:(float)offset;
- (void)hideEmptyView;


@end
