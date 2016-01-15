//
//  HWChannelTableView.m
//  Community
//
//  Created by hw500028 on 15/1/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.

// 话题首页的tableView(searchBar非编辑状态)
//      姓名         日期               修改内容
//     杨庆龙     2015-01-15           创建文件
//     杨庆龙     2015-01-19           ios6plus的适配
//     聂迪       2015-04-27           添加更多推荐、足迹、个人话题页面内容

#import "HWChannelTableView.h"
#import "HWRecommendChannelCell.h"
#import "HWSearchListTableView.h"
#import "HWSearchView.h"
#import "HWCoreDataManager.h"
#import "HWShareMessage.h"
#import "HWMoreRecommendVC.h"
#import "HWNoFoundPicView.h"

//以下都是searchbar在编辑状态下的坐标
#define ksearchBarW           kScreenWidth - 60//searchBar
#define ksearchBarH           30 * kScreenRate
#define ksearchBarX           15
#define ksearchBarY           20
//
#define kHeaderViewH         160 *kScreenRate //头部视图的高度
#define kCollectionViewH     120 *kScreenRate //头部collectionView的高度
#define kTitleViewH          40 //分区标题高度
@interface HWChannelTableView()<UISearchBarDelegate>//UICollectionViewDataSource,UICollectionViewDelegate,
{
    UICollectionView                *_collectionView;
}
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic, strong) NSArray * colorArr;

@end
@implementation HWChannelTableView

- (instancetype)initWithFrame:(CGRect)frame WithIsMoreRecommendWithPastRecord:(BOOL)isMoreOrPast personalUserId:(NSString *)userId
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userId = userId;
        self.isMoreRecommendOrPastRecord = isMoreOrPast;
        self.pastRecordsarr = [NSMutableArray array];
        
        self.baseTable.tableHeaderView = self.headerView;
        self.baseTable.scrollsToTop = NO;
        self.searchView.hidden = YES;
        
        if (self.userId == nil && !self.isMoreRecommendOrPastRecord)
        {
            NSArray *pastRecordsArr = [NSMutableArray arrayWithArray:[HWCoreDataManager channelItemForPastRecords]];
            if (pastRecordsArr.count > 0)
            {
                [self.pastRecordsarr addObjectsFromArray:pastRecordsArr];
                self.baseListArr = [NSMutableArray arrayWithArray:pastRecordsArr];
            }
            else
            {
                self.baseListArr = [NSMutableArray arrayWithArray:[HWCoreDataManager channelItemForRecommend]];
            }
            
            self.baseTable.tableHeaderView = nil;
            self.headerView = nil;
            self.searchBar = nil;
            self.baseTable.tableHeaderView = self.headerView;
            self.baseTable.scrollsToTop = NO;
            self.searchView.hidden = YES;
            
            [self.baseTable reloadData];
        }
        
        [self queryListData];
    }
    return self;
    
}

/**
 *	@brief	刷新数据
 *
 *	@return	N/A
 */
- (void)refreshList
{
    self.currentPage = 0;
    [self queryListData];
}


#pragma mark - 加载视图
/**
 *  创建头视图
 */

- (UIView *)headerView
{
    if (_headerView == nil)
    {
        if (_pastRecordsarr.count == 0 && !_isMoreRecommendOrPastRecord && self.userId == nil)
        {
            _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 145 * kScreenRate + ksearchBarH)];
            
            UIImageView *kImgV = [[UIImageView alloc] initWithFrame:CGRectMake(23 * kScreenRate, ksearchBarH + 36 * kScreenRate, 63 * kScreenRate, 45 * kScreenRate)];
            kImgV.backgroundColor = [UIColor clearColor];
            kImgV.image = [UIImage imageNamed:@"kaolaku"];
            [_headerView addSubview:kImgV];
            
            UIImageView *mImgV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(kImgV.frame) + 8 * kScreenRate, ksearchBarH + 45 * kScreenRate, kScreenWidth - CGRectGetMaxX(kImgV.frame) - 40 * kScreenRate, 70 * kScreenRate)];
            mImgV.image = [UIImage imageNamed:@"qipao"];
//            mImgV.backgroundColor = [UIColor whiteColor];
            [_headerView addSubview:mImgV];
            
            UILabel *tLab = [[UILabel alloc] initWithFrame:CGRectMake(13 * kScreenRate, 10, mImgV.frame.size.width - 2 * 13 * kScreenRate, (70 - 25) * kScreenRate)];
            tLab.numberOfLines = 0;
            tLab.backgroundColor = [UIColor clearColor];
            tLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
            tLab.textColor = THEME_COLOR_SMOKE;
            tLab.text = @"你还没有参与任何话题，没有更新动态喔~ ~";
            [mImgV addSubview:tLab];
            
            UILabel *bLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * kScreenRate, (70 - 30) * kScreenRate, tLab.frame.size.width, 25 * kScreenRate)];
            bLab.numberOfLines = 0;
            bLab.backgroundColor = [UIColor clearColor];
            bLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
            bLab.textColor = THEME_COLOR_SMOKE;
            bLab.text = @"-任性de考拉君";
            bLab.textAlignment = NSTextAlignmentRight;
            [mImgV addSubview:bLab];
            
            _headerView.backgroundColor =[UIColor clearColor];
            self.searchBar.hidden = NO;
        }
        else
        {
            _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ksearchBarH + 20)];//kHeaderViewH
            _headerView.backgroundColor =[UIColor clearColor];
            self.searchBar.hidden = NO;
        }
    }
    return _headerView;
}
/**
 *  创建搜索框
 *
 *  @return 搜索框
 */
- (UISearchBar *)searchBar
{
    if (_searchBar == nil)
    {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(ksearchBarX, 10, kScreenWidth - 2 * ksearchBarX , ksearchBarH)];
        _searchBar.placeholder = @"查找话题";
        _searchBar.delegate = self;
        [self.headerView addSubview:_searchBar];
        
    }
    if (IOS7)
    {
        _searchBar.layer.borderColor = THEME_COLOR_LINE.CGColor;
        _searchBar.layer.borderWidth = 0.5f;
        _searchBar.layer.cornerRadius = 3.0f;
        _searchBar.clipsToBounds = YES;
        _searchBar.backgroundImage = [Utility imageWithColor:[UIColor whiteColor] andSize:_searchBar.frame.size];
    }
    else
    {
        _searchBar.backgroundImage = [Utility imageWithColor:[UIColor clearColor] andSize:_searchBar.frame.size];
    }
    return _searchBar;
}

/**
 *  创建搜索框激活状态下的视图
 *
 *  @return 搜索视图
 */
- (HWSearchView *)searchView
{
    if (_searchView == nil)
    {
        _searchView = [[HWSearchView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height - 44)];
        [self addSubview:_searchView];
        CGFloat btnW = 30;
        CGFloat bthH = 30 * kScreenRate;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.searchBar.right + 15, 0, btnW, bthH);
        btn.center = CGPointMake(kScreenWidth- 15 - (btnW/2) + 5, ksearchBarY + ksearchBarH/2.0f);
        btn.titleLabel.font = [UIFont fontWithName:FONTNAME size:15.0f];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
        [btn setTitleColor:THEME_COLOR_ORANGE_HIGHLIGHT forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.searchView addSubview:btn];
        
    }
    return _searchView;
}


#pragma mark - queryData

- (void)queryListData
{
    if (self.userId != nil)
    {
        [self queryListDataForPersonalTopic];
    }
    else
    {
        if (self.isMoreRecommendOrPastRecord)
        {
            [self queryListDataForMoreRecommend];
        }
        else
        {
            [self queryListDataForPastRecords];
        }
    }
}

- (void)queryListDataForPersonalTopic
{
    /*接口：/hw-sq-app-web/me/userChannelIndex.do
     参数：userId=1000665000664 要查询的用户id
     key=bb007a04-0c5d-4060-b678-7014b4469c86  当前登录者key
     出参：
     {
     'status': '1',
     'data': {
     'content': [
     {
     'channelId': 103907689,
     'channelName': 'gdhdh',
     'createTime': null,
     'creatorId': null,
     'creatorName': null,
     'creatorMobile': null,
     'rangeType': null,
     'contentAmount': null,
     'commentAmount': null,
     'zanAmount': null,
     'heatLevel': null,
     'isRunner': 0,
     'stickyArea': null,
     'stickyTime': null,
     'stickyPosition': null,
     'channelIcon': null
     }
     ],
     'size': 10,
     'number': 0,
     'totalElements': 8,
     'numberOfElements': 8,
     'lastPage': true,
     'firstPage': true,
     'sort': null,
     'totalPages': 1
     },
     'detail': '请求数据成功!',
     'key': 'bb007a04-0c5d-4060-b678-7014b4469c86'
     }*/
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:self.userId forKey:@"userId"];
    [param setPObject:@(self.currentPage) forKey:@"page"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kPersonalTopic parameters:param queue:nil success:^(id responese)
     {
         self.baseTable.tableHeaderView = nil;
         
         NSDictionary *dict = [responese dictionaryObjectForKey:@"data"];
         NSArray *array = [dict arrayObjectForKey:@"content"];
         if (self.currentPage == 0)
         {
             [self.baseListArr removeAllObjects];
         }
         if (array.count < kPageCount)
         {
             isLastPage = YES;
         }
         else
         {
             isLastPage = NO;
         }
         
         for (NSInteger i = 0; i < array.count; i ++ )
         {
             NSDictionary *dic = [array pObjectAtIndex:i];
             HWChannelModel *model = [[HWChannelModel alloc] initWithChannel:dic];
             model.channelColor = [Utility randColor];
             [self.baseListArr addObject:model];
         }
         if (self.baseListArr.count == 0)
         {
             HWNoFoundPicView *noFoundPicView = [[HWNoFoundPicView alloc] initWithText:@"该用户还没有创建任何话题喔~"];
             self.baseTable.tableFooterView = noFoundPicView;
         }
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
     }
          failure:^(NSString *code, NSString *error)
     {
         [Utility showToastWithMessage:error inView:self];
         [self doneLoadingTableViewData];
     }];
}

- (void)queryListDataForPastRecords
{
    /*接口名称：/hw-sq-app-web/topic/footPrint.do
     输入参数：
     key：uuid
     输出参数：
     {
     "status": "1",
     "data": {
     "bannerIcon": null,活动卡片名称
     "bannerUrl": null,活动卡片url
     "topicList":
     { "content": [ { "topicId": 1034715703,主题id "title": null,标题 "content": "兼职",内容 "replyCount": 1,评论数量 "praiseCount": 0,点赞数量 "createTime": 1424071125000,创建时间 "userId": 1029187029186,作者id "releaseType": 1,业务类型 "villageName": "越界☞智慧园",小区名称 "villageId": 206404032015,小区id "hasPraise": 0,是否点赞过 0没有，1有 "mongodbKey": null, "soundTime": null, "fileName": null, "channelName": null,频道名称 "channelId": null 频道id }
     
     ],
     "size": 20,
     "number": 0,
     "sort": null,
     "numberOfElements": 20,
     "totalPages": 2,
     "totalElements": 36,
     "firstPage": true,
     "lastPage": false
     }
     },
     "detail": "请求数据成功!",
     "key": "a79dbe5c-bf01-4c47-b4ac-ed9ca9c6b1d0"
     }*/
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:@(self.currentPage) forKey:@"page"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kPastRecords parameters:param queue:nil success:^(id responese)
     {
         NSDictionary *dict = [responese objectForKey:@"data"];
         NSArray *pastRecordArr = [[dict dictionaryObjectForKey:@"joinChannelPage"] arrayObjectForKey:@"content"];
         NSArray *recommendArr= [dict arrayObjectForKey:@"recommendChannelList"];
         
         if (self.currentPage == 0)
         {
             [self.baseListArr removeAllObjects];
             [self.pastRecordsarr removeAllObjects];
         }
         if (_pastRecordsarr.count == 0 && pastRecordArr.count == 0)    //足迹为空,显示推荐话题列表
         {
             isLastPage = YES;
             for (NSInteger i = 0; i < recommendArr.count; i++ )
             {
                 NSDictionary *dic = [recommendArr pObjectAtIndex:i];
                 HWChannelModel *model = [[HWChannelModel alloc] initWithChannel:dic];
                 model.channelColor = [Utility randColor];
                 [self.baseListArr addObject:model];
             }
         }
         else
         {
             if (pastRecordArr.count < kPageCount)
             {
                 isLastPage = YES;
             }
             else
             {
                 isLastPage = NO;
             }
             
             for (int i = 0; i < pastRecordArr.count; i++)
             {
                 NSDictionary *dic = [pastRecordArr pObjectAtIndex:i];
                 HWChannelModel *model = [[HWChannelModel alloc] initWithChannel:dic];
                 model.channelColor = [Utility randColor];
                 [self.baseListArr addObject:model];
                 [self.pastRecordsarr addObject:model];
             }
             if (self.currentPage == 0)
             {
                 [HWCoreDataManager addChannelItemForPastRecords:self.pastRecordsarr];
             }
         }
         
         self.baseTable.tableHeaderView = nil;
         self.headerView = nil;
         self.searchBar = nil;
         self.baseTable.tableHeaderView = self.headerView;
         self.baseTable.scrollsToTop = NO;
         self.searchView.hidden = YES;
         
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
     }
          failure:^(NSString *code, NSString *error)
     {
         [Utility showToastWithMessage:error inView:self];
         [self doneLoadingTableViewData];
     }];
}

- (void)queryListDataForMoreRecommend
{
    /*
     接口名称：/hw-sq-app-web/topic/recommendMoreChannel.do
     输入参数：
     key：uuid
     输出参数：
     {
     "status": "1",
     "data": {
     "content": [
     { "channelId": 104044645,频道id "channelName": "广东话邓华德",频道名称 "channelIcon": null,频道logo url "creatorName": null,创建人 "joinCount": null 参与数量 }
     ]
     "detail": "请求数据成功!",
     "key": "a79dbe5c-bf01-4c47-b4ac-ed9ca9c6b1d0"
     }*/
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    self.currentPage == 0 ? self.currentPage = 1 : self.currentPage;//后台让从1开始
    [param setPObject:@"1" forKey:@"type"];
    [param setPObject:@(self.currentPage) forKey:@"page"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kMoreRecommendList parameters:param queue:nil success:^(id responese)
     {
         NSDictionary *dict = [responese dictionaryObjectForKey:@"data"];
         NSArray *array = [dict arrayObjectForKey:@"content"];
         if (self.currentPage == 1) //从1开始
         {
             [self.baseListArr removeAllObjects];
         }
         
         for (NSInteger i = 0; i < array.count; i++)
         {
             NSDictionary *dic = [array pObjectAtIndex:i];
             HWChannelModel *model = [[HWChannelModel alloc] initWithChannel:dic];
             model.channelColor = [Utility randColor];
             [self.baseListArr addObject:model];
         }
         if (array.count < kPageCount)
         {
             isLastPage = YES;
         }
         else
         {
             isLastPage = NO;
         }
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
     }
          failure:^(NSString *code, NSString *error)
     {
         [Utility showToastWithMessage:error inView:self];
         [self doneLoadingTableViewData];
     }];
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseListArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
    
    UILabel *label = [UILabel newAutoLayoutView];
    [view addSubview:label];
    [label autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    label.textColor = THEME_COLOR_SMOKE;
    label.text = @"推荐话题";
    label.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    label.backgroundColor = [UIColor clearColor];
    
    UILabel *rightLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 2 * 15, 30)];
    CGPoint center = rightLab.center;
    center.y = 20.0f;
    rightLab.center = center;
    rightLab.backgroundColor = [UIColor clearColor];
    rightLab.textAlignment = NSTextAlignmentRight;
    rightLab.textColor = THEME_COLOR_SMOKE;
    rightLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    rightLab.text = @"更多";
    [view addSubview:rightLab];
    
    view.tag = 1101 + section;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableSectionHeaderClick:)];
    [view addGestureRecognizer:tap];
    
    [Utility bottomLine:view];
//    [Utility topLine:view];
    return view;
}

- (void)tableSectionHeaderClick:(UITapGestureRecognizer *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(delegatePushVC:)])
    {
        HWMoreRecommendVC *moreVC = [[HWMoreRecommendVC alloc] init];
        [self.delegate delegatePushVC:moreVC];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_pastRecordsarr.count == 0 && !_isMoreRecommendOrPastRecord && self.userId == nil)
    {
        return kTitleViewH;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55 * kScreenRate;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWRecommendChannelCell *cell = [HWRecommendChannelCell cellWithTableView:tableView];
    HWChannelModel *model = [self.baseListArr pObjectAtIndex:indexPath.row];
    cell.model = model;
    
    if (indexPath.row == self.baseListArr.count - 1)
    {
        [cell updateConstraints];
        [cell.buttomLine autoRemoveConstraintsAffectingView];
        [cell.buttomLine autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:cell.contentView];
        [cell.buttomLine autoSetDimension:ALDimensionHeight toSize:0.5];
        [cell.buttomLine autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:cell.contentView];
        [cell.buttomLine autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:cell.contentView];
    }
    else
    {
        [cell updateConstraints];
        [cell.buttomLine autoRemoveConstraintsAffectingView];
        [cell.buttomLine autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:cell.contentView];
        [cell.buttomLine autoSetDimension:ALDimensionHeight toSize:0.5];
        [cell.buttomLine autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:cell.contentView];
        [cell.buttomLine autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:cell.contentLabel];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MobClick event:@"click_pingdaoliebiao"];//maidian_1.2.1
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HWChannelModel *model = self.baseListArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(channelTableView:pushCtroller:)] && self.delegate != nil)
    {
        [self.delegate channelTableView:self pushCtroller:model];
    }
}

#pragma mark - searchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [MobClick event:@"click_pingdaoshurukuang"];//maidian_1.2.1
    if ([self.delegate respondsToSelector:@selector(channelTableView:searchBarIsEditing:)] && self.delegate != nil )
    {
        [self.delegate channelTableView:self searchBarIsEditing:searchBar];
    }
    [self hidenlist];
    
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"失去焦点编辑完毕");
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"联想搜索%@",searchBar.text);
    if (searchText == nil)
    {
        searchText = @"";
    }
    [self setValue:searchText forKeyPath:@"searchView.searchListTableView.searchWord"];
    
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"键盘搜索键被点击");
}

#pragma mark -
/**
 *  searchBar编辑时隐藏导航条
 */
- (void)hidenlist
{
    [self.viewController.navigationController setNavigationBarHidden:YES animated:YES];
    self.baseTable.hidden = YES;
    self.searchView.hidden = NO;
    self.searchBar.frame = CGRectMake(ksearchBarX, ksearchBarY, ksearchBarW, ksearchBarH);
    NSLog(@"ksearchBarH === %f",ksearchBarH);
    [self.searchView addSubview:self.searchBar];
    
}

#pragma mark - actions
/**
 *  取消按钮
 */
- (void)cancelAction:(UIButton *)btn
{
    
    if ([self.delegate respondsToSelector:@selector(channelTableView:cancelButtonClicked:)] && self.delegate != nil)
    {
        [self.delegate channelTableView:self cancelButtonClicked:btn];
    }
    self.baseTable.hidden = NO;
    self.searchView.hidden = YES;
    [self.searchBar resignFirstResponder];
    [self.viewController.navigationController setNavigationBarHidden:NO animated:YES];
    self.searchBar.frame = CGRectMake(ksearchBarX, 10, kScreenWidth - 2 * ksearchBarX, ksearchBarH);
    self.searchBar.text = nil;
    [self.headerView addSubview:self.searchBar];
}

@end
