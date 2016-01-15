//
//  HWPersonDynamicRefreshView.m
//  Community
//
//  Created by hw500027 on 15/1/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：显示个人动态 @我的 接收评论 赞 主题信息
//  修改记录：
//	姓名      日期         修改内容
//  陆晓波    2015-01-14   调试接口
//  陆晓波    2015-01-15   合并收到的评论及发送的评论
//  陆晓波    2015-01-19   添加播放语音按钮
//  陆晓波    2015-01-20   重复加载语音按钮修改
//  陆晓波    2015-01-21   上拉加载数据错误修改，入参size改成page,添加接受语音播放通知
//  陆晓波    2015-01-22   queryListData方法在HWPersonDynamicDetailVC viewWillAppear中实现
//  陆晓波    2015-01-23   埋点，去除2015-01-22修改内容
//  陆晓波    2015-01-29   无数据时，提示信息修改

#import "HWPersonDynamicRefreshView.h"
#import "HWPersonDynamicRefreshCell.h"
#import "HWPersonDynamicDetailVC.h"

@implementation HWPersonDynamicRefreshView
@synthesize delegate;


-(id)initWithFrame:(CGRect)frame andDataType:(NSInteger)dataType
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.dataType = dataType;
        [self queryListData];
    }
    return self;
}

-(void)queryListData
{
    [Utility hideMBProgress:self];
    [Utility showMBProgress:self message:@"请求数据"];
    
    NSArray *postUrlArray = @[kAtDynamicIndex,kReplyDynamicIndex,kPraiseDynamicIndex,kTopicDynamicIndex];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    [param setPObject:@(self.currentPage) forKey:@"page"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:[postUrlArray pObjectAtIndex:self.dataType] parameters:param queue:nil success:^(id responese)
    {        
        [Utility hideMBProgress:self];
        NSArray *array = [[responese dictionaryObjectForKey:@"data"]arrayObjectForKey:@"content"];
        NSLog(@"个人动态 array==%@",array);
        if (array.count < kPageCount)
        {
            isLastPage = YES;
        }
        else
        {
            isLastPage = NO;
        }
        
        if (self.currentPage == 0)
        {
            [self.baseListArr removeAllObjects];
        }
        for (NSDictionary *dic in array)
        {
            HWPersonDynamicModel *model = [[HWPersonDynamicModel alloc]initWithDic:dic];
            [self.baseListArr addObject:model];
        }
        
        [self.baseTable reloadData];
        [self doneLoadingTableViewData];
        
        if (self.baseListArr.count == 0)
        {
            [self showEmptyView:@"暂无数据"];
        }
        else
        {
            [self hideEmptyView];
        }
    }
    failure:^(NSString *code, NSString *error)
    {
        NSLog(@"个人动态 error==%@",error);
        
        [self doneLoadingTableViewData];
        if (self.baseListArr.count == 0)
        {
            [self showEmptyView:@"点击重新加载"];
        }
        else
        {
            [self hideEmptyView];
        }
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
    }];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5f)];
    headLine.backgroundColor = THEME_COLOR_LINE;
    return headLine;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5f;
}

#pragma mark - tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellid = @"cellid";
    HWPersonDynamicRefreshCell *dynamicRefreshCell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!dynamicRefreshCell)
    {
        dynamicRefreshCell = [[HWPersonDynamicRefreshCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    dynamicRefreshCell.indexPath = indexPath;
    
    //根据dataType 判断加载
    if (self.dataType == 0)
    {
        //@我的
        [dynamicRefreshCell setMineTypeInfo:[self.baseListArr pObjectAtIndex:indexPath.row]];
    }
    else if (self.dataType == 1)
    {
        //评论
        [dynamicRefreshCell setCommentTypeInfo:[self.baseListArr pObjectAtIndex:indexPath.row]];
    }
    else if (self.dataType == 2)
    {
        //赞
        [dynamicRefreshCell setLikeTypeInfo:[self.baseListArr pObjectAtIndex:indexPath.row]];
    }else
    {
        //主题
        [dynamicRefreshCell setThemeTypeInfo:[self.baseListArr pObjectAtIndex:indexPath.row]];
    }
    
    dynamicRefreshCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return dynamicRefreshCell;
}

#pragma -
#pragma mark Play Audio

- (void)downloadingAudio:(NSNotification *)notification
{
    NSDictionary *dic = notification.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    
    HWPersonDynamicModel *model = [self.baseListArr pObjectAtIndex:index.row];
    model.itemPlayMode = DownloadingPlayMode;
    [self.baseTable reloadData];
}

- (void)downloadAudioFinish:(NSNotification *)notificaiton
{
    NSDictionary *dic = notificaiton.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    
    HWPersonDynamicRefreshCell *cell = (HWPersonDynamicRefreshCell *)[self.baseTable cellForRowAtIndexPath:index];
    [cell doPlay];
}

- (void)downloadAudioFailed:(NSNotification *)notificaiton
{
    NSDictionary *dic = notificaiton.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    HWPersonDynamicModel *model = [self.baseListArr pObjectAtIndex:index.row];
    model.itemPlayMode = StopPlayMode;
    [self.baseTable reloadData];
    
    [Utility showToastWithMessage:@"播放失败" inView:self];
}

- (void)startPlayNotification:(NSNotification *)notificaiton
{
    NSDictionary *dic = notificaiton.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    
    HWPersonDynamicModel *model = [self.baseListArr pObjectAtIndex:index.row];
    model.itemPlayMode = PlayingPlayMode;
    [self.baseTable reloadData];
}

- (void)pausePlayNotification:(NSNotification *)notificaiton
{
    NSDictionary *dic = notificaiton.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    
    HWPersonDynamicModel *model = [self.baseListArr pObjectAtIndex:index.row];
    model.itemPlayMode = StopPlayMode;
    [self.baseTable reloadData];
    
}

- (void)stopPlayNotification:(NSNotification *)notificaiton
{
    NSDictionary *dic = notificaiton.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    
    NSLog(@"########### %d , %d",self.baseListArr.count, index.row);
    
    HWPersonDynamicModel *model = [self.baseListArr pObjectAtIndex:index.row];
    
    model.itemPlayMode = StopPlayMode;
    [self.baseTable reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return [HWPersonDynamicRefreshCell getCellHeight:_dict];
    if (self.dataType == 3)
    {
        return 125;
    }else
    {
        return 155;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (delegate && [delegate respondsToSelector:@selector(didSelectPersonDynamicRefreshView:)])
    {
        /* 埋点
         ”@我的动态列表“>点击卡片      click_movement_atmecard
         ”评论动态列表“>点击评论卡片    click_movement_commentcard
         ”点赞动态列表“>点击赞卡片     click_movement_liketcard
         ”主题列表“>点击主题卡片      click_movement_feedtcard
         */
        NSArray *mobClickArray = @[@"click_movement_atmecard",@"click_movement_commentcard",@"click_movement_liketcard",@"click_movement_feedtcard"];
        [MobClick event:[mobClickArray pObjectAtIndex:self.dataType]];//maidian_1.2.1
        
        [delegate didSelectPersonDynamicRefreshView:[self.baseListArr pObjectAtIndex:indexPath.row]];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
