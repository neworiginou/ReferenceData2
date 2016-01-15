//
//  HWRecommendView.m
//  Community
//
//  Created by niedi on 15/4/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：邻里圈首页 推荐View
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪        2015-04-15                 创建文件
//      聂迪        2015-04-27                 完善UI及内容
//

#import "HWRecommendView.h"
#import "DCycleBanner.h"
#import "HWDetailViewController.h"

#define chuanChuanMenLabTag 8888

@implementation HWRecommendView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.villageTalkCount = @"0";
        self.cityTalkCount = @"0";
        isLastPage = YES;
        
        //banner缓存
        NSArray *bannerArr = [HWCoreDataManager bannerModel];
        if (bannerArr != nil)
        {
            self.bannerModelArr = [NSArray arrayWithArray:bannerArr];
            if (self.bannerModelArr.count > 0)
            {
                [self initTableViewHeaderViewWithBanner];
            }
            else
            {
                [self initTableViewHeaderViewWithoutBanner];
            }
        }
        else
        {
            [self initTableViewHeaderViewWithoutBanner];
        }
        //推荐列表缓存读取
        self.baseListArr = [NSMutableArray arrayWithArray:[HWCoreDataManager channelItemForRecommend]];

        //邻居说和同城说缓存
        NSUserDefaults *standDefaults = [NSUserDefaults standardUserDefaults];
        self.villageTalkCount = [standDefaults objectForKey:@"villageTalkCount"] == nil ? @"0" : [standDefaults objectForKey:@"villageTalkCount"];
        self.cityTalkCount = [standDefaults objectForKey:@"cityTalkCount"] == nil ? @"0" : [standDefaults objectForKey:@"cityTalkCount"];
        
        [self.baseTable reloadData];
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


#pragma mark -
#pragma mark - 数据请求

- (void)queryListData
{
    [self queryDataForBanner];  //banner
    [self queryDataForList];    //列表数据
}

- (void)queryDataForBanner
{
    /*接口名称：/hw-sq-app-web/topic/topicBanner.do
     输入参数：
     key：uuid
     page：页码
     size：每页数量
     输出参数：
     "id",推广活动
     "activity_name",活动名称
     "activity_url",活动URL
     "activity_start_time",活动开始时间
     "activity_end_time",活动结束时间*/
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kNeighbourTopBanner parameters:param queue:nil success:^(id responese)
     {
         NSDictionary *dict = [responese objectForKey:@"data"];
         NSArray *activityList = [dict arrayObjectForKey:@"activityList"];
         NSMutableArray *tmpArr = [NSMutableArray array];
         for (NSDictionary *tmpDict in activityList)
         {
             HWNeighbourBannerModel *moedl = [[HWNeighbourBannerModel alloc] initWithDict:tmpDict];
             [tmpArr addObject:moedl];
         }
         self.bannerModelArr = [NSArray arrayWithArray:tmpArr];
         if (self.bannerModelArr.count > 0)
         {
             [self initTableViewHeaderViewWithBanner];
         }
         else
         {
             [self initTableViewHeaderViewWithoutBanner];
         }
         [HWCoreDataManager addNeighbourBannerModel:self.bannerModelArr];
         
     }
        failure:^(NSString *code, NSString *error)
     {
         if (self.bannerModelArr.count <= 0)
         {
             [self initTableViewHeaderViewWithoutBanner];
         }
         [Utility showToastWithMessage:error inView:self];
     }];
}

- (void)queryDataForList
{
    /*接口名称：/hw-sq-app-web/topic/recommendChannelIndex.do
     输入参数：
     key：uuid
     输出参数：
     {
     "status": "1",
     "data":
     { "passVillageList": [ "1", "2", "3" ],穿越小区villageId "neighbourTalkCount": null,邻居说数量 "cityTalkCount": null,同城说数量 "recommendChannelList": [ "channelId": 104044645,频道id "channelName": "广东话邓华德",频道名称 "channelIcon": null,频道logo url "creatorName": null,创建人 "joinCount": null 参与数量 ] }
     
     ,
     "detail": "请求数据成功!",
     "key": "a79dbe5c-bf01-4c47-b4ac-ed9ca9c6b1d0"
     }*/
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kNeighbourHomePageList parameters:param queue:nil success:^(id responese)
     {
         NSDictionary *dict = [responese objectForKey:@"data"];
         self.passVillageIdArr = [dict arrayObjectForKey:@"passVillageList"];
         UILabel *chuanChuanMenLab = (UILabel *)[self viewWithTag:chuanChuanMenLabTag];
         if (self.passVillageIdArr.count > 0)
         {
             chuanChuanMenLab.text = @"串串门儿";
         }
         else
         {
             chuanChuanMenLab.text = @"";
         }
         
         self.villageTalkCount = [[dict stringObjectForKey:@"neighbourTalkCount"] isEqualToString:@""] ? @"0" : [dict stringObjectForKey:@"neighbourTalkCount"];
         self.cityTalkCount = [[dict stringObjectForKey:@"cityTalkCount"] isEqualToString:@""] ? @"0" : [dict stringObjectForKey:@"cityTalkCount"];
         
         NSUserDefaults *standDefault = [NSUserDefaults standardUserDefaults];
         [standDefault setObject:self.villageTalkCount forKey:@"villageTalkCount"];
         [standDefault setObject:self.cityTalkCount forKey:@"cityTalkCount"];
         [standDefault synchronize];
         
         NSArray *array = [dict objectForKey:@"recommendChannelList"];
         [self.baseListArr removeAllObjects];
         for (NSInteger i = 0; i < array.count; i ++ )
         {
             NSDictionary *dic = [array pObjectAtIndex:i];
             HWChannelModel *model = [[HWChannelModel alloc] initWithChannel:dic];
             model.channelColor = [Utility randColor];
             [self.baseListArr addObject:model];
         }
         isLastPage = YES;
         [HWCoreDataManager addChannelItemForRecommend:self.baseListArr];
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
     }
          failure:^(NSString *code, NSString *error)
     {
         [Utility showToastWithMessage:error inView:self];
         [self doneLoadingTableViewData];
     }];
}


#pragma mark -
#pragma mark - initTableViewHeaderView
- (void)initTableViewHeaderViewWithBanner
{
    UIView *tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 165 * kScreenRate + 40)];
    tableViewHeaderView.backgroundColor = [UIColor clearColor];
    self.baseTable.tableHeaderView = tableViewHeaderView;
    
    //轮播banner
    DCycleBanner *banner = [DCycleBanner cycleBannerWithFrame:CGRectMake(0, 0, kScreenWidth, 165 * kScreenRate) bannerImgCount:self.bannerModelArr.count];
    [banner setImageViewAtIndex:^(UIImageView *bannerImageView, NSUInteger indexAtBanner) {
        HWNeighbourBannerModel *model = [_bannerModelArr pObjectAtIndex:indexAtBanner];
        bannerImageView.backgroundColor = IMAGE_DEFAULT_COLOR;
        __weak UIImageView *weakImgV = bannerImageView;
        [bannerImageView setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithUrl:model.activityPictureURL]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (error == nil)
            {
                weakImgV.image = image;
            }
            else
            {
                weakImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
            }
        }];
    }];
    [banner setImageTapAction:^(NSUInteger indexAtBanner) {
        [self bannerImgVClickAtIndex:indexAtBanner];
        [self bannerClickStatisticalAtIndex:indexAtBanner];
    }];
    [banner setTimerFire:YES];
    [tableViewHeaderView addSubview:banner];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 165 * kScreenRate, kScreenWidth, 40)];
    view.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
    
    UILabel *label = [UILabel newAutoLayoutView];
    [view addSubview:label];
    [label autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    label.textColor = THEME_COLOR_SMOKE;
    label.text = @"区域话题";
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
    if (self.passVillageIdArr.count > 0)
    {
        rightLab.text = @"串串门儿";
    }
    else
    {
        rightLab.text = @"";
    }
    rightLab.tag = chuanChuanMenLabTag;
    [view addSubview:rightLab];
    
    view.tag = 1101;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableSectionHeaderClick:)];
    [view addGestureRecognizer:tap];
    
    [Utility bottomLine:view];
    [Utility topLine:view];
    [tableViewHeaderView addSubview:view];
}
/*"topic:coupon:index:{话题Id}"
 "topic:coupon:detail:{主题Id}"
 {
 activityId = 1035683649;
 activityName = "\U597d\U5c4b\U4e2d\U56fd";
 activityPictureURL = "hw-sq-app-web/banner/getBannerPicture.do?pictureId=554186fce4b007d58f466efe";
 activityURL = "topic:coupon:index:{1002029085}";
 }
 */

//banner点击统计
- (void)bannerClickStatisticalAtIndex:(NSUInteger)index
{
    HWNeighbourBannerModel *bannerModel = [_bannerModelArr pObjectAtIndex:index];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
    [param setPObject:bannerModel.activityId forKey:@"activityId"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KBannerClickStatistical parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"banner统计 responese ========================= %@",responese);
         
     } failure:^(NSString *code, NSString *error) {
         NSLog(@"banner统计错误 %@", error);
     }];
}

- (void)bannerImgVClickAtIndex:(NSUInteger)index
{
    HWNeighbourBannerModel *bannerModel = [_bannerModelArr pObjectAtIndex:index];
    if ([bannerModel.activityURL rangeOfString:@"topic:coupon:index:"].location != NSNotFound)  //话题
    {
        NSString *channelIdStr = nil;
        if (bannerModel.activityURL.length > 20)
        {
            channelIdStr = [bannerModel.activityURL substringFromIndex:20];
            if (channelIdStr.length > 0) {
                channelIdStr = [channelIdStr substringToIndex:channelIdStr.length -1];
            }
            else
            {
                channelIdStr = nil;
            }
        }
        if (channelIdStr != nil)
        {
            HWChannelModel *model = [[HWChannelModel alloc] init];
            model.channelId = channelIdStr;
            model.channelName = bannerModel.activityName;
            model.passVillageIdArr = nil;
            if ([self.delegate respondsToSelector:@selector(recommendView:pushVC:)] && self.delegate)
            {
                [self.delegate recommendView:self pushVC:model];
            }
        }
    }
    else if ([bannerModel.activityURL rangeOfString:@"topic:coupon:detail:"].location != NSNotFound)  //主题
    {
        NSString *topicIdStr = nil;
        if (bannerModel.activityURL.length > 21)
        {
            topicIdStr = [bannerModel.activityURL substringFromIndex:21];
            if (topicIdStr.length > 0) {
                topicIdStr = [topicIdStr substringToIndex:topicIdStr.length -1];
            }
            else
            {
                topicIdStr = nil;
            }
        }
        if (topicIdStr != nil)
        {
            if ([self.delegate respondsToSelector:@selector(recommendView:pushVC:)] && self.delegate)
            {
                HWDetailViewController *detailVC = [[HWDetailViewController alloc] initWithCardId:topicIdStr];
                detailVC.resourceType = detailResourceNeighbour;
                detailVC.chuanChuanMenCanNotHandle = NO;
                if ([self.delegate respondsToSelector:@selector(pushVC:)] && self.delegate != nil)
                {
                    [self.delegate pushVC:detailVC];
                }
            }
        }
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewHeaderPictureClick:)])
        {
            [self.delegate tableViewHeaderPictureClick:bannerModel];
        }
    }
}

- (void)initTableViewHeaderViewWithoutBanner
{
    UIView *tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    tableViewHeaderView.backgroundColor = [UIColor clearColor];
    self.baseTable.tableHeaderView = tableViewHeaderView;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
    
    UILabel *label = [UILabel newAutoLayoutView];
    [view addSubview:label];
    [label autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    label.textColor = THEME_COLOR_SMOKE;
    label.text = @"区域话题";
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
    if (self.passVillageIdArr.count > 0)
    {
        rightLab.text = @"串串门儿";
    }
    else
    {
        rightLab.text = @"";
    }
    rightLab.tag = chuanChuanMenLabTag;
    [view addSubview:rightLab];
    
    view.tag = 1101;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableSectionHeaderClick:)];
    [view addGestureRecognizer:tap];
    
    [Utility bottomLine:view];
    [Utility topLine:view];
    [tableViewHeaderView addSubview:view];
}

#pragma mark -
#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 2;
    }
    else
    {
        return self.baseListArr.count;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        view.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
        
        UILabel *label = [UILabel newAutoLayoutView];
        [view addSubview:label];
        [label autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        label.textColor = THEME_COLOR_SMOKE;
        if (section == 0)
        {
            label.text = @"区域话题";
        }
        else
        {
            label.text = @"推荐话题";
        }
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
        if (section == 0)
        {
            if (self.passVillageIdArr.count > 0)
            {
                rightLab.text = @"串串门儿";
            }
            else
            {
                rightLab.text = @"";
            }
        }
        else
        {
            rightLab.text = @"更多";
        }
        [view addSubview:rightLab];
        
        view.tag = 1101 + section;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableSectionHeaderClick:)];
        [view addGestureRecognizer:tap];
        
        [Utility bottomLine:view];
//        [Utility topLine:view];
        return view;
    }
    else
    {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 40;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWRecommendChannelCell *cell = [HWRecommendChannelCell cellWithTableView:tableView];
    HWChannelModel *model;
    
    if (indexPath.section == 0)
    {
        NSArray *titleArr = @[@"邻居说", @"同城说"];
        NSArray *countArr = @[self.villageTalkCount, self.cityTalkCount];
        model = [[HWChannelModel alloc] init];
        model.channelId = titleArr[indexPath.row];
        model.channelIcon = @"";
        model.channelName = titleArr[indexPath.row];
        model.partInCount = countArr[indexPath.row];
        model.createrName = @"";
        model.channelColor = [Utility randColor];
        
        cell.model = model;
        
        if (indexPath.row == 1)
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
    }
    else
    {
        model = [self.baseListArr pObjectAtIndex:indexPath.row];
        
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
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0)
    {
        NSArray *titleArr = @[@"邻居说", @"同城说"];
        HWChannelModel *model = [[HWChannelModel alloc] init];
        model.channelId = titleArr[indexPath.row];
        model.channelName = titleArr[indexPath.row];
        model.passVillageIdArr = self.passVillageIdArr;
        if ([self.delegate respondsToSelector:@selector(recommendView:pushVC:)] && self.delegate)
        {
            [self.delegate recommendView:self pushVC:model];
        }
    }
    else
    {
        HWChannelModel *model = self.baseListArr[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(recommendView:pushVC:)] && self.delegate != nil)
        {
            [self.delegate recommendView:self pushVC:model];
        }
    }
}

//tableview 分区头点击事件
- (void)tableSectionHeaderClick:(UITapGestureRecognizer *)sender
{
    UIView *view = sender.view;
    if (view.tag == 1101)
    {
        if (self.passVillageIdArr.count > 0)
        {
            HWChannelModel *model = [[HWChannelModel alloc] init];
            model.channelId = @"串串门儿";
            model.channelName = @"串串门儿";
            model.passVillageIdArr = self.passVillageIdArr;
            if ([self.delegate respondsToSelector:@selector(recommendView:pushVC:)] && self.delegate)
            {
                [self.delegate recommendView:self pushVC:model];
            }
        }
    }
    else if (view.tag == 1102)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(pushVC:)])
        {
            HWMoreRecommendVC *moreVC = [[HWMoreRecommendVC alloc] init];
            [self.delegate pushVC:moreVC];
        }
    }
}

@end
