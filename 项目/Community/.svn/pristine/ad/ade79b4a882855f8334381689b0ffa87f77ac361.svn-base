//
//  HWChannelView.m
//  Community
//
//  Created by zhangxun on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//  
//  功能描述：邻里圈 个人主页View
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪        2015-04-15                 创建文件
//

#import "HWChannelView.h"
#import "HWChannelItemClass.h"
#import "HWChannelNewCell.h"
#import "HWChannelVoiceCell.h"
#import "HWGeneralizeCell.h"

#import "HWActivityViewController.h"
#import "HWNoFoundPicView.h"
#import "HWTopicListViewController.h"
#import "HWApplicationDetailViewController.h"

@implementation HWChannelView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = BACKGROUND_COLOR;
        self.baseTable.frame = frame;
        self.baseTable.delegate = self;
        self.baseTable.dataSource = self;
        self.baseTable.backgroundColor = [UIColor clearColor];
        self.isNeedHeadRefresh = YES;
        self.isTopicList = NO;  //默认不是某话题列表
        self.chuanChuanMenCanNotHandle = NO;    //串串门不可操作 默认可操作
        self.isPersonalTopic = NO;
    
        _nofoundView = [[HWNoFoundPicView alloc]initWithText:@"此话题下暂无内容"];
        
        _bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 157 * kScreenRate + 20)];
        _bannerView.backgroundColor = [UIColor whiteColor];
        _bannerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(8 * kScreenRate, 10, kScreenWidth - 2 * 8 * kScreenRate, 157 *kScreenRate)];
        _bannerImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showAct)];
        [_bannerImgView addGestureRecognizer:tap];
        [_bannerView addSubview:_bannerImgView];
    }
    return self;
}

- (void)setChannelModel:(HWChannelModel *)channelModel
{
    if (_channelModel != channelModel)
    {
        _channelModel = channelModel;
        
        if (_channelModel.passVillageIdArr != nil && _channelModel.passVillageIdArr.count > 0)
        {
            self.chuanChuanMenVillageIdArr = [NSArray arrayWithArray:_channelModel.passVillageIdArr];
            self.lastvillageArrIndex = 0;
            self.isChangedVillageId = NO;
            self.currentVillageId = self.chuanChuanMenVillageIdArr[0];
            
            if ([_channelModel.channelName isEqualToString:@"串串门儿"])
            {
                self.chuanChuanMenCanNotHandle = YES;   //yes不可操作
            }
        }
    }
}

//邻居说数据小于50条加头视图
- (void)loadTableViewHeaderView
{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 210 * kScreenRate)];//kHeaderViewH
    _headerView.backgroundColor =[UIColor clearColor];
    
    UIImageView *kImgV = [[UIImageView alloc] initWithFrame:CGRectMake(23 * kScreenRate, 36 * kScreenRate, 63 * kScreenRate, 45 * kScreenRate)];
    kImgV.backgroundColor = [UIColor clearColor];
    kImgV.image = [UIImage imageNamed:@"kaolaku"];
    [_headerView addSubview:kImgV];
    
    UIImageView *mImgV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(kImgV.frame) + 8 * kScreenRate, 45 * kScreenRate, kScreenWidth - CGRectGetMaxX(kImgV.frame) - 40 * kScreenRate, 70 * kScreenRate)];
    mImgV.image = [UIImage imageNamed:@"qipao"];
//    mImgV.backgroundColor = [UIColor whiteColor];
    [_headerView addSubview:mImgV];
    
    UILabel *tLab = [[UILabel alloc] initWithFrame:CGRectMake(15 * kScreenRate, 8, mImgV.frame.size.width - 2 * 15 * kScreenRate, (70 - 30) * kScreenRate)];
    tLab.numberOfLines = 0;
    tLab.backgroundColor = [UIColor clearColor];
    tLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    tLab.textColor = THEME_COLOR_SMOKE;
    tLab.text = @"考拉君在这里等你很久了~快邀请你的邻居一起玩吧~";
    [mImgV addSubview:tLab];
    
    UILabel *bLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * kScreenRate, (70 - 28) * kScreenRate, tLab.frame.size.width, 25 * kScreenRate)];
    bLab.numberOfLines = 0;
    bLab.backgroundColor = [UIColor clearColor];
    bLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL12];
    bLab.textColor = THEME_COLOR_SMOKE;
    bLab.text = @"-任性de考拉君";
    bLab.textAlignment = NSTextAlignmentRight;
    [mImgV addSubview:bLab];
    
    UIButton *ccmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ccmBtn.frame = CGRectMake(0, 145 * kScreenRate, 150 * kScreenRate, 40 * kScreenRate);
    CGPoint center = ccmBtn.center;
    center.x = kScreenWidth / 2.0f;
    ccmBtn.center = center;
    [ccmBtn setGreenBorderStyle];
    [ccmBtn setTitle:@"串串门儿" forState:UIControlStateNormal];
    [ccmBtn addTarget:self action:@selector(chuanChuanMenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    if (!(_channelModel.passVillageIdArr != nil && _channelModel.passVillageIdArr.count > 0))
    {
        ccmBtn.hidden = YES;
    }
    [_headerView addSubview:ccmBtn];
    
    self.baseTable.tableHeaderView = _headerView;
}

- (void)chuanChuanMenBtnClick
{
    HWChannelModel *model = [[HWChannelModel alloc] init];
    model.channelId = @"串串门儿";
    model.channelName = @"串串门儿";
    model.passVillageIdArr = _channelModel.passVillageIdArr;
    HWTopicListViewController *vc = [[HWTopicListViewController alloc]init];
    vc.channelModel = model;
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushController:)])
    {
        [self.delegate pushController:vc];
    }
}

#pragma -
#pragma mark Play Audio

- (void)downloadingAudio:(NSNotification *)notification
{
    NSDictionary *dic = notification.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    
    HWChannelItemClass *itemClass = [self.baseListArr objectAtIndex:index.row];
    itemClass.itemPlayMode = DownloadingPlayMode;
    [self.baseTable reloadData];
}

- (void)downloadAudioFinish:(NSNotification *)notificaiton
{
    NSDictionary *dic = notificaiton.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    
    HWChannelVoiceCell *cell = (HWChannelVoiceCell *)[self.baseTable cellForRowAtIndexPath:index];
    [cell doPlay];
}

- (void)downloadAudioFailed:(NSNotification *)notificaiton
{
    NSDictionary *dic = notificaiton.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    HWChannelItemClass *itemClass = [self.baseListArr objectAtIndex:index.row];
    itemClass.itemPlayMode = StopPlayMode;
    [self.baseTable reloadData];
    
    [Utility showToastWithMessage:@"播放失败" inView:self];
}

- (void)startPlayNotification:(NSNotification *)notificaiton
{
    NSDictionary *dic = notificaiton.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    
    HWChannelItemClass *itemClass = [self.baseListArr objectAtIndex:index.row];
    itemClass.itemPlayMode = PlayingPlayMode;
    [self.baseTable reloadData];
}

- (void)pausePlayNotification:(NSNotification *)notificaiton
{
    NSDictionary *dic = notificaiton.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    
    HWChannelItemClass *itemClass = [self.baseListArr objectAtIndex:index.row];
    itemClass.itemPlayMode = StopPlayMode;
    [self.baseTable reloadData];
    
}

- (void)stopPlayNotification:(NSNotification *)notificaiton
{
    NSDictionary *dic = notificaiton.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    HWChannelItemClass *itemClass = [self.baseListArr objectAtIndex:index.row];
    itemClass.itemPlayMode = StopPlayMode;
    [self.baseTable reloadData];
    
}

/**
 *	@brief	刷新列表
 *
 *	@return	N/A
 */
- (void)refreshList
{
    self.currentPage = 0;
    [self queryListData];
}

- (void)queryListData
{
    if (self.userId != nil)
    {
        [self queryListDataForPersonalTheme];   //个人主页 - 个人主题
        self.isPersonalTopic = YES;
    }
    else
    {
        if ([_channelModel.channelId isEqualToString:@"邻居说"])
        {
            [self queryListDataForChuanChuanMen];   //穿越小区id为空，为空表示登陆人所居住的小区id）
        }
        else if ([_channelModel.channelId isEqualToString:@"同城说"])
        {
            [self queryListDataForCitySpeak];
        }
        else if ([_channelModel.channelId isEqualToString:@"串串门儿"])
        {
            [self queryListDataForChuanChuanMen];
        }
        else
        {
            self.isTopicList = YES;
            [self queryListDataForNormal];
        }
    }
}

- (void)changeChuanChuanMenVillageIdQuery
{
    if (self.lastvillageArrIndex + 1 < self.chuanChuanMenVillageIdArr.count)
    {
        self.isChangedVillageId = YES;
        self.currentPage = 0;
        self.currentVillageId = self.chuanChuanMenVillageIdArr[self.lastvillageArrIndex + 1];
        [self queryListDataForChuanChuanMen];
    }
    else
    {
        self.lastvillageArrIndex = -1;
        [self changeChuanChuanMenVillageIdQuery];
    }
}

- (void)queryListDataForPersonalTheme
{
    /*接口：/hw-sq-app-web/me/userTopicIndex.do
     入参：userId 要查看的用户id
            分页
     key 当前登陆用户的key
     出参：
     {
     'status': '1',
     'data': {
     'content': [
     {
     'userId': 1000744000750,
     'nickName': '秋水123456',
     'headUrl': 'file/downloadByKey.do?mKey=54ca199ee4b0acaaad14f304',
     'topicContent': '下雨了',
     'topicAttUrl': null,
     'soundTime': null,
     'topicMongodbKey': null,
     'createTimeStr': '2015-02-05 22:54:22',
     'createTime': 1423148062000,
     'releaseType': 1,
     'mongodbKey': '54ca199ee4b0acaaad14f304',
     'topicId': 1033952926
     }
     ],
     'size': 10,
     'number': 0,
     'firstPage': true,
     'lastPage': false,
     'sort': null,
     'totalElements': 34,
     'totalPages': 4,
     'numberOfElements': 10
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
    [manager POST:kPersonalTheme parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"responese ========================= %@",responese);
         if (self.currentPage == 0)
         {
             [self.baseListArr removeAllObjects];
         }
         
         NSArray *arr = [[responese dictionaryObjectForKey:@"data"] arrayObjectForKey:@"content"];
         if (arr.count < kPageCount)
         {
             isLastPage = YES;
         }
         else
         {
             isLastPage = NO;
         }
         
         for (int i = 0; i < arr.count; i ++)
         {
             HWChannelItemClass *model = [[HWChannelItemClass alloc]init];
             [model fillWithDictForPersonalTheme:arr[i]];
             if (!self.baseListArr)
             {
                 self.baseListArr = [NSMutableArray array];
             }
             [self.baseListArr addObject:model];
         }
         
         self.baseTable.tableHeaderView = nil;
         
         //MYP add
         if (self.baseListArr.count > 0)
         {
             self.baseTable.tableFooterView = nil;
         }
         else
         {
             _nofoundView = [[HWNoFoundPicView alloc]initWithText:@"该用户还没有创建任何主题喔~"];
             self.baseTable.tableFooterView = _nofoundView;
         }
         
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
     } failure:^(NSString *code, NSString *error) {
         if (self.baseListArr.count == 0) {
             self.baseTable.tableFooterView = _nofoundView;
         }
         [self doneLoadingTableViewData];
         [Utility showToastWithMessage:error inView:self];
     }];
    /*{
     createTime = 1423727312000;
     createTimeStr = "2015-02-12 15:48:32";
     headUrl = "file/downloadByKey.do?mKey=54d1e910e4b0f935324f08e6";
     mongodbKey = 54d1e910e4b0f935324f08e6;
     nickName = "Ning 21";
     releaseType = 8;
     soundTime = "<null>";
     topicAttUrl = "<null>";
     topicContent = "\U5751\U7239\Uff0c\U600e\U4e48\U8001\U5360\U7ebf\U5462\Uff01";
     topicId = 1034481474;
     topicMongodbKey = "<null>";
     userId = 1029097029097;
     }*/
}

- (void)queryListDataForCitySpeak
{
    /*接口名称：/hw-sq-app-web/topic/citySpeak.do
     输入参数：
     key：uuid
     page：页码
     size：每页数量
     输出参数：
     {
     "status": "1",
     "data": {
     "topicList": {
     "content": [
     { "topicId": 主题id, "title": ,台头 "content": "真不是赴日地",主题内容 "replyCount": 3,评论数量 "praiseCount": 0,点赞数量 "createTime": 1425884938000,创建时间 "userId": 1033829033833, "releaseType": 1,主题类型 "villageName": null, "villageId": 206762033805, "hasPraise": null,是否点赞 "mongodbKey": null, "soundTime": null, "fileName": null, "channelName": null,频道名称 "channelId": null频道id }
     ],
     "size": 10,
     "number": 0,
     "totalPages": 10,
     "numberOfElements": 10,
     "sort": null,
     "totalElements": 92,
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
    [manager POST:kNeighbourCitySpeak parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"responese ========================= %@",responese);
         if (self.currentPage == 0)
         {
             [self.baseListArr removeAllObjects];
         }
         
         NSArray *arr = [[[responese dictionaryObjectForKey:@"data"] dictionaryObjectForKey:@"topicList"] arrayObjectForKey:@"content"];
         if (arr.count < kPageCount)
         {
             isLastPage = YES;
         }
         else
         {
             isLastPage = NO;
         }
         
         for (int i = 0; i < arr.count; i ++)
         {
             HWChannelItemClass *model = [[HWChannelItemClass alloc]init];
             [model fillWithDictionary:arr[i]];
             if (!self.baseListArr)
             {
                 self.baseListArr = [NSMutableArray array];
             }
             [self.baseListArr addObject:model];
         }
         
         self.baseTable.tableHeaderView = nil;
         
         //MYP add
         if (self.baseListArr.count > 0)
         {
             self.baseTable.tableFooterView = nil;
         }
         else
         {
             self.baseTable.tableFooterView = _nofoundView;
         }
         
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
     } failure:^(NSString *code, NSString *error) {
         if (self.baseListArr.count == 0) {
             self.baseTable.tableFooterView = _nofoundView;
         }
         [self doneLoadingTableViewData];
         [Utility showToastWithMessage:error inView:self];
     }];
}

- (void)queryListDataForChuanChuanMen
{
    /*接口名称：/hw-sq-app-web/topic/neighbourSpeak.do
     输入参数：
     key：uuid
     villageId：穿越小区id （可为空，为空就是登陆人所居住的小区id）
     page：页码
     size：每页数量
     输出参数：
     {
     "status": "1",
     "data": {
     "haveContent": 1,是否有内容， 0无内容，1有内容
     "isPass": 0,是否穿越，0未穿越，1穿越
     "topicList":
     { "content": [ { "topicId": 1035170140,主题id "title": "34fr4r",台头 "content": "324324",内容 "replyCount": 0,评论数量 "praiseCount": 0,点赞数量 "createTime": 1427967849000,创建时间 "userId": 1012402012411,作者id "releaseType": 0,业务类型 "villageName": null,小区名称 "villageId": 206762033805,小区id "hasPraise": null, "mongodbKey": null, "soundTime": null, "fileName": null, "channelName": null,频道名称 "channelId": null 频道id }
     
     ],
     "size": 10,
     "number": 0,
     "sort": null,
     "numberOfElements": 10,
     "totalPages": 108,
     "totalElements": 1075,
     "firstPage": true,
     "lastPage": false
     }
     },
     "detail": "请求数据成功!",
     "key": "a79dbe5c-bf01-4c47-b4ac-ed9ca9c6b1d0"
     }*/
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    if ([_channelModel.channelId isEqualToString:@"串串门儿"])
    {
        [param setPObject:self.currentVillageId forKey:@"villageId"];
    }
    [param setPObject:@(self.currentPage) forKey:@"page"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kNeighbourChuanChuanMen parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"responese ========================= %@",responese);
         if (self.isChangedVillageId)   //区分是点击切换小区或刷新，yes为切换小区
         {
             self.isChangedVillageId = NO;
             self.lastvillageArrIndex++;    //请求成功再切换下一个小区
             [self.baseListArr removeAllObjects];
         }
         
         if ([_channelModel.channelId isEqualToString:@"邻居说"])
         {
             NSString *totalElementsStr = [[[responese dictionaryObjectForKey:@"data"] dictionaryObjectForKey:@"topicList"] stringObjectForKey:@"totalElements"];
             if (totalElementsStr.intValue < 50)
             {
                 [self loadTableViewHeaderView];
             }
             else
             {
                 self.baseTable.tableHeaderView = nil;
             }
         }
         else //即 串串门儿
         {
             self.baseTable.tableHeaderView = nil;
             if (![[[responese dictionaryObjectForKey:@"data"] stringObjectForKey:@"villageId"] isEqualToString:self.currentVillageId]) //返回的villageId 和 currentVillageId 不一样，抛弃此组数据
             {
                 return ;
             }
             else
             {
                 if (self.delegate && [self.delegate respondsToSelector:@selector(changeNavTitle:)])
                 {
                     NSString *title = [[responese dictionaryObjectForKey:@"data"] stringObjectForKey:@"villageName"];
                     [self.delegate changeNavTitle:title];
                 }
             }
         }
         
         if (self.currentPage == 0)
         {
             [self.baseListArr removeAllObjects];
         }
         
         NSArray *arr = [[[responese dictionaryObjectForKey:@"data"] dictionaryObjectForKey:@"topicList"] arrayObjectForKey:@"content"];
         if (arr.count < kPageCount)
         {
             isLastPage = YES;
         }
         else
         {
             isLastPage = NO;
         }
         
         for (int i = 0; i < arr.count; i ++)
         {
             HWChannelItemClass *model = [[HWChannelItemClass alloc] init];
             [model fillWithDictionary:arr[i]];
             if (!self.baseListArr)
             {
                 self.baseListArr = [NSMutableArray array];
             }
             [self.baseListArr addObject:model];
         }
         
         [self.baseTable reloadData];
         if (self.baseListArr.count > 0)
         {
             self.baseTable.tableFooterView = nil;
         }
         else
         {
             if ([_channelModel.channelId isEqualToString:@"串串门儿"])
             {
                 _nofoundView = [[HWNoFoundPicView alloc]initWithText:@"此小区下暂无内容"];
                 self.baseTable.tableFooterView = _nofoundView;
             }
         }
         [self doneLoadingTableViewData];
     } failure:^(NSString *code, NSString *error) {
         if ([_channelModel.channelId isEqualToString:@"邻居说"])
         {
             [self loadTableViewHeaderView];
         }
         [self doneLoadingTableViewData];
         [Utility showToastWithMessage:error inView:self];
     }];
}

- (void)queryListDataForNormal
{
    /*接口名称：/hw-sq-app-web/channel/channelDetail.do
     输入参数：
     key：uuid
     channelId：频道id
     page：页码
     size：每页数量
     输出参数：
     {
     "status": "1",
     "data": {
     "bannerIcon": null,活动卡片名称
     "bannerUrl": null,活动卡片url
     "topicList": {
     "content": [
     { "topicId": 1034715703,主题id "title": null,标题 "content": "兼职",内容 "replyCount": 1,评论数量 "praiseCount": 0,点赞数量 "createTime": 1424071125000,创建时间 "userId": 1029187029186,作者id "releaseType": 1,业务类型 "villageName": "越界☞智慧园",小区名称 "villageId": 206404032015,小区id "hasPraise": 0,是否点赞过 0没有，1有 "mongodbKey": null, "soundTime": null, "fileName": null, "channelName": null,频道名称 "channelId": null 频道id }
     
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
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.channelModel.channelId forKey:@"channelId"];
    [dict setObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setObject:@(kPageCount) forKey:@"size"];
    [dict setObject:[NSString stringWithFormat:@"%d",self.currentPage] forKey:@"page"];
    
    [manager POST:kChannelDetailList parameters:dict queue:nil success:^(id responese)
    {
        NSLog(@"responese ========================= %@",responese);
        if (self.currentPage == 0)
        {
            [self.baseListArr removeAllObjects];
        }
//        NSString *range = [[responese dictionaryObjectForKey:@"data"] stringObjectForKey:@"range"];
//        if ([range isEqualToString:@"1"])
//        {
//            range = @"同城";
//        }
//        else if ([range isEqualToString:@"2"])
//        {
//            range = @"附近";
//        }
//        else
//        {
//            range = @"全国";
//        }
//        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(changeListWithString:)] )
//        {
//            [self.delegate changeListWithString:range];
//        }
//        NSString *title = [[responese dictionaryObjectForKey:@"data"] stringObjectForKey:@"villageName"];
//        [self.delegate changeNavTitle:title];
        
        self.bannerIcon = [[responese dictionaryObjectForKey:@"data"] stringObjectForKey:@"bannerIcon"];
        self.bannerUrl = [[responese dictionaryObjectForKey:@"data"] stringObjectForKey:@"bannerUrl"];
        
        NSArray *arr = [[[responese dictionaryObjectForKey:@"data"] dictionaryObjectForKey:@"topicList"] arrayObjectForKey:@"content"];
        if (arr.count < kPageCount)
        {
            isLastPage = YES;
        }
        else
        {
            isLastPage = NO;
        }
        
        for (int i = 0; i < arr.count; i ++)
        {
            HWChannelItemClass *model = [[HWChannelItemClass alloc]init];
            [model fillWithDictionary:arr[i]];
            if (!self.baseListArr)
            {
                self.baseListArr = [NSMutableArray array];
            }
            [self.baseListArr addObject:model];
        }
        
        //MYP add 如果存在广告
        if (self.bannerIcon.length > 0)
        {
            self.baseTable.tableHeaderView = _bannerView;
            
            __weak UIImageView *blockImgV = _bannerImgView;
            [blockImgV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:self.bannerIcon]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                if (error)
                {
                    NSLog(@"Error : load image fail.");
                    blockImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
                }
                else
                {
                    blockImgV.image = image;
                }
            }];
        }
        else
        {
            self.baseTable.tableHeaderView = nil;
        }
        
        
        //MYP add
        if (self.baseListArr.count > 0)
        {
            self.baseTable.tableFooterView = nil;
        }
        else
        {
            self.baseTable.tableHeaderView = nil;
            self.baseTable.tableFooterView = _nofoundView;
        }
        
        [self.baseTable reloadData];
        [self doneLoadingTableViewData];
    } failure:^(NSString *code, NSString *error) {
        if (self.baseListArr.count == 0)
        {
            self.baseTable.tableFooterView = _nofoundView;
        }
        [self doneLoadingTableViewData];
        [Utility showToastWithMessage:error inView:self];
    }];
}

//添加主题的话题名称
- (void)selectChannel:(HWChannelModel *)channelMode
{
    [Utility hideMBProgress:self];
    HWChannelItemClass *item = [self.baseListArr objectAtIndex:_currentIndex.row];
    HWHTTPRequestOperationManager *managr = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:item.topicId forKey:@"topicId"];
    [dict setObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
    [dict setObject:channelMode.channelId forKey:@"channelId"];
    [dict setObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    [Utility showMBProgress:self message:@"请稍等"];
    [managr POSTAudio:kChangeChannel parameters:dict queue:nil success:^(id responseObject)
     {
         [Utility hideMBProgress:self];
         item.channelName = channelMode.channelName;
         item.channelId = channelMode.channelId;
         [self.baseTable reloadRowsAtIndexPaths:@[_currentIndex] withRowAnimation:UITableViewRowAnimationFade];
     } failure:^(NSString *error) {
         [Utility hideMBProgress:self];
         [Utility showToastWithMessage:error inView:self];
     }];
}

/**
 *	@brief	改变赞数
 *
 *	@param 	likeCount 	赞数
 *
 *	@return	N/A
 */
- (void)changeLike:(NSString *)likeCount isPrise:(NSString *)isPrise
{
    HWChannelItemClass *class = [self.baseListArr objectAtIndex:_currentIndex.row];
    class.praiseCount = likeCount;
    class.hasPraise = isPrise;
    [self.baseTable reloadRowsAtIndexPaths:@[_currentIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
}

/**
 *	@brief	改变评论数
 *
 *	@param 	commentCount 	评论数
 *
 *	@return	N/A
 */
- (void)changeComment:(NSString *)commentCount
{
    HWChannelItemClass *class = [self.baseListArr objectAtIndex:_currentIndex.row];
    class.replyCount = commentCount;
    [self.baseTable reloadRowsAtIndexPaths:@[_currentIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)createHeader
{
    if (self.bannerUrl.length == 0)
    {
        return;
    }
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 0.61f *kScreenRate)];
    imageV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showAct)];
    [imageV addGestureRecognizer:tap];
}

//活动tableViewHeader点击
- (void)showAct
{
//    HWActivityViewController *actVC = [[HWActivityViewController alloc]initWithURL:self.bannerUrl];
//    [self.delegate pushController:actVC];
    HWApplicationDetailViewController *appDetailVC = [[HWApplicationDetailViewController  alloc] init];
    appDetailVC.navigationItem.titleView = [Utility navTitleView:@"活动详情"];
    appDetailVC.appUrl = self.bannerUrl;
    [self.delegate pushController:appDetailVC];
}

//赞
- (void)doLike:(BOOL)isLike WithIndex:(NSIndexPath *)index
{
    [MobClick event:@"click_zantongiconpingdao"]; //maidian_1.2.1
    
    if ([[HWUserLogin currentUserLogin].coStatus isEqualToString:@"1"])
    {
        if ([HWUserLogin verifyBindMobileWithPopVC:self.superVC showAlert:YES])
        {
            if ([HWUserLogin verifyIsLoginWithPresentVC:self.superVC toViewController:nil])
            {
                [self reDoLike:isLike withIndex:index];
            }
        }
    }
    else
    {
        [self reDoLike:isLike withIndex:index];
    }
}

- (void)reDoLike:(BOOL)isLike withIndex:(NSIndexPath *)index
{
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    HWChannelItemClass *newClass = nil;
    if (index)
    {
        newClass = [self.baseListArr objectAtIndex:index.row];
    }
    else
    {
        newClass = [self.baseListArr objectAtIndex:_currentIndex.row];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:newClass.topicId forKey:@"topicId"];
    [dict setObject:isLike ? @"1" : @"0" forKey:@"type"];
    [dict setObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
    [dict setObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    [manager POST:kPraise parameters:dict queue:nil success:^(id responese) {
        [self.baseTable reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(NSString *code, NSString *error) {
        [Utility showToastWithMessage:error inView:self];
    }];
}

//跳转个人主页
- (void)showPersonalHomePageWithIndex:(NSIndexPath *)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushController:)])
    {
        _currentIndex = index;
        
        HWChannelItemClass *itemClass = [self.baseListArr pObjectAtIndex:index.row];
        HWPersonalHomePageVC *homeVc = [[HWPersonalHomePageVC alloc] init];
        homeVc.userId = itemClass.userId;
        [self.delegate pushController:homeVc];
    }
}

- (void)popToPersonalHomePageVC
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(popViewController)])
    {
        [self.delegate popViewController];
    }
}

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
    HWChannelItemClass *itemClass = [self.baseListArr objectAtIndex:indexPath.row];
    switch ([itemClass.releaseType intValue])
    {
        case 2:
        {
            return kIntervalHeight + 159;
        }
            break;
        case 22:
        {
            return kActImageHeight + kIntervalHeight;
        }
        default:
            return [HWChannelNewCell getHeightWithClass:itemClass];
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    static NSString *cellIdentifier1 = @"cell1";
    static NSString *cellIdentifier2 = @"cell2";
    HWChannelItemClass *itemClass = [self.baseListArr objectAtIndex:indexPath.row];
    if ([itemClass.releaseType isEqualToString:@"2"])  //语音
    {
        HWChannelVoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell)
        {
            cell = [[HWChannelVoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            cell.chuanChuanMenCanNotHandle = self.chuanChuanMenCanNotHandle;
            cell.isTopicList = self.isTopicList;
            cell.isPersonalTopic = self.isPersonalTopic;
        }
        [cell rebuildWithInfo:itemClass indexPath:indexPath];
        return cell;
    }
    else if ([itemClass.releaseType isEqualToString:@"22"])
    {
        HWGeneralizeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (!cell)
        {
            cell = [[HWGeneralizeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
        }
        [cell rebuildWithInfo:itemClass indexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        HWChannelNewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (!cell)
        {
            cell = [[HWChannelNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
            cell.delegate = self;
            cell.chuanChuanMenCanNotHandle = self.chuanChuanMenCanNotHandle;
            cell.isTopicList = self.isTopicList;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.isPersonalTopic = self.isPersonalTopic;
        }
        [cell rebuildWithInfo:itemClass indexPath:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MobClick event:@"click_neirongwenzixiangqing"]; //maidian_1.2.1 MYP add
    [MobClick event:@"click_neirongzhaopianxiangqing"]; //maidian_1.2.1 MYP add
    [MobClick event:@"click_pingluniconpingdao"]; //maidian_1.2.1 MYP add
    HWChannelItemClass *itemClass = [self.baseListArr objectAtIndex:indexPath.row];
    _currentIndex = indexPath;
    if (![itemClass.releaseType isEqualToString:@"22"]) //非22
    {
        if ([self.delegate respondsToSelector:@selector(pushToDetailViewController:resourceType:isChuanChuanMen:personalVC:channelId:)] && self.delegate != nil)
        {
            if (self.isTopicList)
            {
                [self.delegate pushToDetailViewController:itemClass.topicId resourceType:detailResourceChannel isChuanChuanMen:self.chuanChuanMenCanNotHandle personalVC:self.personalVC channelId:self.channelModel.channelId];
            }
            else
            {
                [self.delegate pushToDetailViewController:itemClass.topicId resourceType:detailResourceNeighbour isChuanChuanMen:self.chuanChuanMenCanNotHandle personalVC:self.personalVC channelId:self.channelModel.channelId];
            }
        }
    }
    else
    {
        NSString *url;
        if ([itemClass.content rangeOfString:@"[url]"].location == NSNotFound || [itemClass.content rangeOfString:@"[/url]" ].location == NSNotFound)
        {
            url = @"";
        }
        else
        {
            NSRange range1 = [itemClass.content rangeOfString:@"[url]"];
            NSRange range2 = [itemClass.content rangeOfString:@"[/url]"];
            url = [itemClass.content substringWithRange:NSMakeRange(range1.location + 5, range2.location - range1.location - 5)];
        }
        HWActivityViewController *actVC = [[HWActivityViewController alloc]initWithURL:url];
        [self.delegate pushController:actVC];
    }
}

- (void)deleteChannelWithCardIndex:(NSIndexPath *)index
{
    [self.baseListArr removeObjectAtIndex:_currentIndex];
    [self.baseTable reloadData];
}

#pragma mark -
#pragma mark - HWChannelNewCellDelegate\HWChannelVoiceCellDelegate
- (void)showChannelWithIndex:(NSIndexPath *)index
{
    _currentIndex = index;
    
    HWChannelItemClass *itemClass = [self.baseListArr objectAtIndex:index.row];
    HWTopicListViewController *topicList = [[HWTopicListViewController alloc] init];
    HWChannelModel *channelModel = [[HWChannelModel alloc] init];
    channelModel.channelId = itemClass.channelId;
    channelModel.channelName = itemClass.channelName;
    channelModel.channelIcon = nil;
    topicList.channelModel = channelModel;
    if ([self.delegate respondsToSelector:@selector(pushController:)] && self.delegate != nil)
    {
        [self.delegate pushController:topicList];
    }
}

- (void)addChannelWithIndex:(NSIndexPath *)index
{
    _currentIndex = index;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didAddChannel)])
    {
        [self.delegate didAddChannel];
    }
}

- (void)doCommentWithIndex:(NSIndexPath *)index
{
    _currentIndex = index;
    HWChannelItemClass *itemClass = [self.baseListArr objectAtIndex:index.row];
    if ([self.delegate respondsToSelector:@selector(pushToDetailViewController:resourceType:isChuanChuanMen:personalVC:channelId:)] && self.delegate != nil)
    {
        [self.delegate pushToDetailViewController:itemClass.topicId resourceType:detailResourceChannel isChuanChuanMen:self.chuanChuanMenCanNotHandle personalVC:self.personalVC channelId:self.channelModel.channelId];
    }
}

- (void)dealloc
{
//    [super dealloc];
    self.delegate = nil;
}

@end
