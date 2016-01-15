//
//  HWRefreshBaseViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-29.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWRefreshBaseViewController.h"
#import "EmptyControl.h"

#define TAIL_HEIGHT 40
#define TAIL_LABEL_TAG 1001
#define TAIL_ACTIVITY_TAG 1002
#define TAIL_COUNT 25

#define kNewTag 9

@interface HWRefreshBaseViewController ()

@end

@implementation HWRefreshBaseViewController
@synthesize dataList;
@synthesize baseTableView;
@synthesize isNeedHeadRefresh;
@synthesize _currentPage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataList = [[NSMutableArray alloc] initWithCapacity:0];
    
    self.baseTableView = [[JPBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) style:UITableViewStylePlain];
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
    self.baseTableView.backgroundColor = [UIColor clearColor];
    self.baseTableView.backgroundView = nil;
    [self.view addSubview:baseTableView];
    
    if (refrehHeadview == nil)
    {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - baseTableView.bounds.size.height, self.view.frame.size.width, baseTableView.bounds.size.height)];
        view.backgroundColor = [UIColor clearColor];
		view.delegate = self;
		[baseTableView addSubview:view];
		refrehHeadview = view;
        refrehHeadview.hidden = YES;
	}
    [refrehHeadview refreshLastUpdatedDate];
    
    
    
    //创建上拉加载更多
//    if(refreshTailView == nil)
//    {
//        refreshTailView = [[UIView alloc] initWithFrame:CGRectMake(0, CONTENT_HEIGHT, baseTableView.frame.size.width, TAIL_HEIGHT)];
//		[baseTableView addSubview:refreshTailView];
////        refreshTailView.hidden = YES;
//        
//        UILabel *lbl = [[UILabel alloc] init];
//        lbl.backgroundColor = [UIColor clearColor];
//        lbl.textColor = [UIColor blackColor];
//        lbl.textAlignment = NSTextAlignmentCenter;
//        lbl.frame = CGRectMake(0, 0, refreshTailView.frame.size.width, refreshTailView.frame.size.height);
//        lbl.font = [UIFont systemFontOfSize:12];
//        lbl.tag = TAIL_LABEL_TAG;
//        lbl.text = @"上拉刷新";
//        [refreshTailView addSubview:lbl];
//        
//        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        indicator.tag = TAIL_ACTIVITY_TAG;
//        indicator.frame = CGRectMake(100, (TAIL_HEIGHT - 20)/2, 20, 20);
//        [indicator startAnimating];
//        [refreshTailView addSubview:indicator];
//        indicator.hidden = YES;
//    }
}

#pragma mark -
#pragma mark Set Get

- (void)setIsNeedHeadRefresh:(BOOL)_isNeedHeadRefresh
{
    isNeedHeadRefresh = _isNeedHeadRefresh;
    if(isNeedHeadRefresh)
        refrehHeadview.hidden = NO;
}

#pragma mark -
#pragma mark Public Method

- (void)autoDragRefresh
{
    if (isNeedHeadRefresh)
    {
        [self.baseTableView setContentOffset:CGPointMake(0, -65) animated:NO];
        [refrehHeadview egoRefreshScrollViewDidEndDragging:self.baseTableView];
    }
}

- (void)showEmpty:(NSString*)msg
{
    if([self.view viewWithTag:1111] != nil)
        return;
    __weak HWRefreshBaseViewController *weakSelf = self;
    EmptyControl *empty = [[EmptyControl alloc] initWithTitle:msg frame:baseTableView.frame onClick:^{
        
        [weakSelf queryListData];
    }];
    empty.tag = 1111;
    [self.view addSubview:empty];
}

- (void)showEmpty:(NSString *)msg withOffset:(float)offset
{
    if([self.view viewWithTag:1111] != nil)
        return;
    __weak HWRefreshBaseViewController *weakSelf = self;
    
    CGRect frame = baseTableView.frame;
    frame.origin.y = frame.origin.y + offset;
    frame.size.height = frame.size.height - offset;
    
    EmptyControl *empty = [[EmptyControl alloc] initWithTitle:msg frame:frame onClick:^{
        
        [weakSelf queryListData];
    }];
    empty.tag = 1111;
    [self.view addSubview:empty];
}

- (void)hideEmpty
{
    if ([self.view viewWithTag:1111])
    {
        [[self.view viewWithTag:1111] removeFromSuperview];
    }
}

- (void)showNewEmpty:(NSString *)msg{
    [self hideNewEmpty];
    if ([self.view viewWithTag:kNewTag] != nil) {
        return;
    }
    
    UIView *view = [[UIView alloc]initWithFrame:baseTableView.frame];
    view.backgroundColor = [UIColor clearColor];
    view.tag = kNewTag;
    [self.view addSubview:view];
    
    UIImageView *imgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emptyData"]];
    imgview.center = CGPointMake(view.frame.size.width/2.0, view.frame.size.height/2.0-50);
    [view addSubview:imgview];
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = THEME_COLOR_TEXT;
    lbl.font = [UIFont fontWithName:FONTNAME size:16];
    lbl.frame = CGRectMake(0, CGRectGetMaxY(imgview.frame) + 10, self.view.frame.size.width, 30);
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.text = msg;
    [view addSubview:lbl];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, self.view.frame.size.width, view.frame.size.height);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
}

- (void)btnClick{
//    [self hideNewEmpty];
    [self queryListData];
}

- (void)hideNewEmpty{
    if ([self.view viewWithTag:kNewTag]) {
        [[self.view viewWithTag:kNewTag] removeFromSuperview];
    }
}

- (void)queryListData
{
    
}

#pragma mark -
#pragma mark Private Method (Protect)

- (void)refreshData
{
    if (isNeedHeadRefresh)
    {
        [self.baseTableView setContentOffset:CGPointMake(0, -65) animated:NO];
        [refrehHeadview egoRefreshScrollViewDidEndDragging:self.baseTableView];
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
        [refrehHeadview egoRefreshScrollViewDataSourceDidFinishedLoading:baseTableView];
    }
    
    if (_refreshFooterView)
    {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:baseTableView];
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
    
    
    
    CGFloat height = MAX(baseTableView.contentSize.height, baseTableView.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview])
	{
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              baseTableView.frame.size.width,
                                              self.view.bounds.size.height);
    }
    else
	{
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         baseTableView.frame.size.width, self.view.bounds.size.height)];
        _refreshFooterView.backgroundColor = [UIColor clearColor];
        _refreshFooterView.delegate = self;
        [baseTableView addSubview:_refreshFooterView];
    }
    
    if (isLastPage)
    {
        _refreshFooterView.hidden = YES;
        if (self.baseTableView.showEndFooterView)
        {
            self.baseTableView.endFooterView.hidden = NO;
        }
    }
    else
    {
        _refreshFooterView.hidden = NO;
        self.baseTableView.endFooterView.hidden = YES;
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
        
    }
    else if(aRefreshPos == EGORefreshFooter && !isLastPage)
	{
        // pull up to load more data
        _currentPage ++;
    }
	
    [self reloadTableViewDataSource];
    
	// overide, the actual loading data operation is done in the subclass
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	return isHeadLoading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed
}

#pragma mark -
#pragma mark TableView Delegate DataSource 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -
#pragma mark System Method

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
