//
//  HWBaseRefreshView.m
//  MoreHouse
//
//  Created by lizhongqiang on 14/11/18.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//  姓名        日期              修改内容
//  杨庆龙      2015-01-22      showEmptyView方法中修改为如果有视图移除;

#import "HWBaseRefreshView.h"
#import "EmptyControl.h"

#define TAILVIEW_HEIGHT 40

@implementation HWBaseRefreshView
@synthesize baseTable;
@synthesize isNeedHeadRefresh;
@synthesize currentPage = _currentPage;

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initBaseView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initBaseView];
    }
    return self;
}

- (void)initBaseView
{
    self.baseListArr = [[NSMutableArray alloc] init];
    
    self.baseTable = [[JPBaseTableView alloc] initWithFrame:self.bounds];
    self.baseTable.delegate = self;
    self.baseTable.dataSource = self;
    [self.baseTable setBackgroundColor:[UIColor clearColor]];
    [self.baseTable setBackgroundView:nil];
    self.baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.baseTable];
    
    self.isNeedHeadRefresh = YES;
    
    //顶部
    if (refrehHeadview == nil)
    {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.baseTable.bounds.size.height, kScreenWidth, self.baseTable.bounds.size.height)];
        view.delegate = self;
        [self.baseTable addSubview:view];
        refrehHeadview = view;
        [refrehHeadview setBackgroundColor:[UIColor clearColor]];
        refrehHeadview.hidden = NO;
    }
    [refrehHeadview refreshLastUpdatedDate];
    
    //底部
    //    if (refreshTailview == nil)
    //    {
    //        refreshTailview = [[UIView alloc] initWithFrame:CGRectMake(0, self.baseTable.contentSize.height, kScreenWidth, TAILVIEW_HEIGHT)];
    //        [self.baseTable addSubview:refreshTailview];
    //        refreshTailview.hidden = YES;
    //
    //        UILabel *lbl = [[UILabel alloc] init];
    //        lbl.backgroundColor = [UIColor clearColor];
    //        lbl.textColor = [UIColor blackColor];
    //        lbl.textAlignment = NSTextAlignmentCenter;
    //        lbl.frame = CGRectMake(0, 0, refreshTailview.frame.size.width, refreshTailview.frame.size.height);
    //        lbl.font = [UIFont systemFontOfSize:12];
    //        lbl.tag = 7001;
    //        lbl.text = @"上拉刷新";
    //        [refreshTailview addSubview:lbl];
    //
    //        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //        indicator.tag = 7002;
    //        indicator.frame = CGRectMake(100, (TAILVIEW_HEIGHT-20)/2, 20, 20);
    //        [indicator startAnimating];
    //        [refreshTailview addSubview:indicator];
    //        indicator.hidden = YES;
    //    }
}

- (void)setIsNeedHeadRefresh:(BOOL)isNeed
{
    isNeedHeadRefresh = isNeed;
    if (isNeed)
    {
        refrehHeadview.hidden = NO;
    }
    else
    {
        refrehHeadview.hidden = YES;
    }
}

- (void)queryListData
{
    
}

- (void)showEmptyView:(NSString *)message
{
    if([self viewWithTag:1111] != nil)
    {
        [[self viewWithTag:1111] removeFromSuperview];
    }
    
    __weak HWBaseRefreshView *weakSelf = self;
    EmptyControl *empty = [[EmptyControl alloc] initWithTitle:message frame:self.baseTable.frame onClick:^{
        [weakSelf queryListData];
    }];
    empty.tag = 1111;
    [self addSubview:empty];
}


- (void)showEmpty:(NSString *)msg withOffset:(float)offset
{
    if([self viewWithTag:1111] != nil)
        return;
    __weak HWBaseRefreshView *weakSelf = self;
    
    CGRect frame = self.baseTable.frame;
    frame.origin.y = frame.origin.y + offset;
    frame.size.height = frame.size.height - offset;
    
    EmptyControl *empty = [[EmptyControl alloc] initWithTitle:msg frame:frame onClick:^{
        
        [weakSelf queryListData];
    }];
    empty.tag = 1111;
    [self addSubview:empty];
}

- (void)hideEmptyView
{
    if ([self viewWithTag:1111])
    {
        [[self viewWithTag:1111] removeFromSuperview];
    }
}

#pragma mark -
#pragma mark Private Method (Protect)

- (void)refreshData
{
    if (isNeedHeadRefresh)
    {
        [self.baseTable setContentOffset:CGPointMake(0, -65) animated:NO];
        [refrehHeadview egoRefreshScrollViewDidEndDragging:self.baseTable];
    }
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    isHeadLoading = YES;
    [self queryListData];
}

- (void)finishedLoadData
{
    isHeadLoading = NO;
    if (refrehHeadview)
    {
        [refrehHeadview egoRefreshScrollViewDataSourceDidFinishedLoading:baseTable];
    }
    
    if (_refreshFooterView)
    {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:baseTable];
        [self setFooterView];
    }
    
}

- (void)doneLoadingTableViewData
{
    //  model should call this when its done loading
    
    [self finishedLoadData];
    [self setFooterView];
}

- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view
{
    return [NSDate date];
}

- (void)setFooterView
{
    //    UIEdgeInsets test = self.aoView.contentInset;
    // if the footerView is nil, then create it, reset the position of the footer
    
    CGFloat height = MAX(baseTable.contentSize.height, baseTable.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview])
    {
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              baseTable.frame.size.width,
                                              self.bounds.size.height);
    }
    else
    {
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                         height,
                                                                                         baseTable.frame.size.width,
                                                                                         self.bounds.size.height)];
        _refreshFooterView.backgroundColor = [UIColor clearColor];
        _refreshFooterView.delegate = self;
        [baseTable addSubview:_refreshFooterView];
    }
    
    if (isLastPage)
    {
        _refreshFooterView.hidden = YES;
        if (isNeedHeadRefresh)
        {
            self.baseTable.showEndFooterView = YES;
        }
        
    }
    else
    {
        _refreshFooterView.hidden = NO;
        self.baseTable.showEndFooterView = NO;
    }
    
    
    if (_refreshFooterView)
    {
        [_refreshFooterView refreshLastUpdatedDate];
    }
}


-(void)removeFooterView
{
    if (_refreshFooterView && [_refreshFooterView superview])
    {
        [_refreshFooterView removeFromSuperview];
    }
    _refreshFooterView = nil;
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(isNeedHeadRefresh)
        [refrehHeadview egoRefreshScrollViewDidScroll:scrollView];
    
    if (_refreshFooterView)
    {
        [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(isNeedHeadRefresh)
        [refrehHeadview egoRefreshScrollViewDidEndDragging:scrollView];
    
    
    
    if (_refreshFooterView && !isHeadLoading && !isLastPage)
    {
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}


#pragma mark - 顶部刷新方法
#pragma mark EGORefreshTableHeaderDelegate Methods

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view
{
    return isHeadLoading;
}

- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos
{
    [self beginToReloadData:aRefreshPos];
}

- (void)beginToReloadData:(EGORefreshPos)aRefreshPos{
    
    //  should be calling your tableviews data source model to reload
    isHeadLoading = YES;
    
    if (aRefreshPos == EGORefreshHeader)
    {
        // pull down to refresh data
        _currentPage = 0;
        isLastPage = NO;
    }
    else if(aRefreshPos == EGORefreshFooter && !isLastPage)
    {
        // pull up to load more data
        _currentPage ++;
    }
    
    [self reloadTableViewDataSource];
    
    // overide, the actual loading data operation is done in the subclass
}


#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
