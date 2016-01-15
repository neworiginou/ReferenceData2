//
//  HWShareRefreshView.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/17.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：福利社 红包 界面 view
//
//  修改记录：
//      姓名          日期                      修改内容
//     蔡景鹏         2015-1-17               创建文件
//

#import "HWShareRefreshView.h"
#import "HWCoreDataManager.h"
#import "AppDelegate.h"

@implementation HWShareRefreshView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self queryListData];
    }
    return self;
}

- (void)initialData
{
    self.baseListArr = (NSMutableArray *)[HWCoreDataManager searchAllShareItem];
    if (self.baseListArr.count < kPageCount)
    {
        isLastPage = YES;
    }
}



#pragma mark -
#pragma mark Share Method

/**
 *	@brief	判断是否有返现请求方法
 *
 *	@return	x
 */
- (void)requestBeforeShare
{
    //判断是否有返现
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:_toShareItem.activityId forKey:@"activityId"];
    [dict setPObject:@"1" forKey:@"channel"];
    
    [Utility showMBProgress:self message:LOADING_TEXT];
    
    
    [manager redPacketPost:kShareBefore parameters:dict queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self];
        _beforeShareState = [responseObject stringObjectForKey:@"data"];
        if ([_beforeShareState isEqualToString:@"1"])
        {
            // 分享有钱
            [self shareFunction];
        }
        else
        {
            // 分享没钱
            
            NSString *msg = [responseObject stringObjectForKey:@"detail"];
            if ([msg isEqualToString:@""])
            {
                msg = @"分享红包被抢完啦，你还要继续分享吗？";
            }
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            
        }
        
        
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
    }];
    
    //    [manager POST:kShareBefore parameters:dict queue:nil success:^(id responseObject) {
    //        [Utility hideMBProgress:self];
    //        _beforeShareState = [responseObject stringObjectForKey:@"data"];
    //        if ([_beforeShareState isEqualToString:@"1"])
    //        {
    //            // 分享有钱
    //            [self shareFunction];
    //        }
    //        else if ([_beforeShareState isEqualToString:@"0"])
    //        {
    //            // 分享没钱
    //
    //            NSString *msg = [responseObject stringObjectForKey:@"detail"];
    //            if ([msg isEqualToString:@""])
    //            {
    //                msg = @"分享红包被抢完啦，你还要继续分享吗？";
    //            }
    //
    //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //            [alert show];
    //
    //        }
    //
    //    } failure:^(NSString *code, NSString *error) {
    //        [Utility hideMBProgress:self];
    //        [Utility showToastWithMessage:error inView:self];
    //    }];
    
}

- (void)shareFunction
{
    [MobClick event:@"click_share_kickbacks"];
    
    if ([HWUserLogin verifyBindMobileWithPopVC:self.superVC showAlert:YES])
    {
        if ([HWUserLogin verifyIsLoginWithPresentVC:self.superVC toViewController:nil])
        {
            if (delegate && [delegate respondsToSelector:@selector(toShareActivityWithState:item:image:)])
            {
                UIImage *shareImage = nil;
                if ([_toShareCell.headImageView.image isEqual:[UIImage imageNamed:@"redDefault"]] ||
                    _toShareCell.headImageView.image == nil)
                {
                    shareImage = [UIImage imageNamed:@"Icon"];
                }
                else
                {
                    shareImage = _toShareCell.headImageView.image;
                }
                
                [delegate toShareActivityWithState:_beforeShareState item:_toShareItem image:shareImage];
            }
        }
    }
}

#pragma mark -
#pragma mark            Private Method

- (void)getMaxCoolTime:(NSArray *)array
{
    for (int i = 0; i < self.baseListArr.count; i++)
    {
        HWShareItemClass *sItem = [self.baseListArr objectAtIndex:i];
        NSInteger freezeTime = [sItem.freezeRemainMillis integerValue] / 1000.0f;
        maxFreezeTime = freezeTime > maxFreezeTime ? freezeTime : maxFreezeTime;
    }
}

- (void)doCountdown
{
    if (maxFreezeTime - coolTime <= 0)
    {
        [timer invalidate];
    }
    NSInteger remaintime = maxFreezeTime - coolTime ;
    
    coolTime ++;
    [self.baseTable reloadData];
}

- (void)queryListData
{
    /*
     入参:cityId=[城市id]&key=[登录key]
     出参:
     content: [
     {
     activityContent = "";
     activityId = 1002559002559;
     activityTitle = "\U4e0a\U6d77\U8bd7\U57df\U56fd\U9645";
     freezeRemainMillis = 0;
     haiwaiCountry = 0;
     houseAddress = "\U4e0a\U6d77\U5b9d\U5c71";
     houseAvgPrice = 10000;
     houseId = 12796;
     houseName = "\U4e0a\U6d77\U8bd7\U57df\U56fd\U9645";
     housePic = "http://172.16.10.35/m_uploads/fb76d6110055af2232b5d55dcc380611";
     housePromo = "1,2,3,4";
     localPhone = 0;
     restMoney = 14920;
     shareLinkTitle = "\U4e0a\U6d77\U8bd7\U57df\U56fd\U9645";
     shareState = 1;
     shareUrl = "http://172.16.10.35/m/share/shareWap1?activity=3837&project_activity_id=1002559002559&broker_id=1000002480687";
     sharedMoney = 5;
     sharedTime = "<null>";
     startTime = 1404144000000;
     totalMoney = 0;
     totalSharedAmount = 15000;
     }
     */
    [Utility hideMBProgress:self];
    [Utility showMBProgress:self message:@"请求数据"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    NSString *cityId = [HWUserLogin currentUserLogin].cityId;
    [param setPObject:[Utility getCityNameById:cityId] forKey:@"cityName"];
//    [param setObject:@"上海市" forKey:@"cityName"];
    [param setPObject:[NSString stringWithFormat:@"%d",self.currentPage] forKey:@"page"];
    [param setPObject:[NSString stringWithFormat:@"%d",kPageCount] forKey:@"size"];
    [param setPObject:@"1" forKey:@"channel"];
    
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    [manager redPacketPost:kActiveList parameters:param queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self];
        NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
        NSArray *contents = [dataDic arrayObjectForKey:@"content"];
        NSMutableArray *array = [NSMutableArray array];
        
        for (int i = 0; i < contents.count; i++)
        {
            HWShareItemClass *shareItem = [[HWShareItemClass alloc] initWithDictionary:[contents objectAtIndex:i]];
            //            shareItem.freezeRemainMillis = @"100000";
            [array addObject:shareItem];
        }
        
        if(array.count < kPageCount)
        {
            isLastPage = YES;
        }
        else
        {
            isLastPage = NO;
        }
        
        if (self.currentPage == 0)
        {
            self.baseListArr = [NSMutableArray arrayWithArray:array];
            //保存数据库
            if (self.baseListArr != 0)
            {
                [HWCoreDataManager removeAllShareItem];
                [HWCoreDataManager addShareItem:self.baseListArr];
            }
        }
        else
        {
            [self.baseListArr addObjectsFromArray:array];
        }
        
        
        [self.baseTable reloadData];
        
        if(self.baseListArr.count == 0)
        {
            [self showEmptyView:@"暂无活动"];
        }else{
            [self hideEmptyView];
        }
        
        [self doneLoadingTableViewData];
        //获取分享冷却时间
        [timer invalidate];
        timer = nil;
        
        maxFreezeTime = 0;
        [self getMaxCoolTime:self.baseListArr];
        
        for (HWShareItemClass *item in self.baseListArr)
        {
            int time = [item.freezeRemainMillis integerValue] / 1000.0;       //秒
            //开启定时器
            
            if (time > 0 && item.started.intValue == 1)
            {
                if (timer == nil)
                {
                    coolTime = 0;
                    activeTimer = YES;
                    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(doCountdown) userInfo:nil repeats:YES];
                    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
                }
                
                //                return ;
            }
            else if (time > 0 && item.started.intValue == 0)
            {
                //                活动未开始
                if (timer == nil)
                {
                    coolTime = 0;
                    activeTimer = YES;
                    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(doCountdown) userInfo:nil repeats:YES];
                    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
                }
                
            }
        }
        
        
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self];
        [self doneLoadingTableViewData];
        NSLog(@"houselist error hwhttprequest:%@",error);
        
        if (self.baseListArr.count == 0)
        {
            [self showEmptyView:@"暂无活动"];
        }
        else
        {
            [self hideEmptyView];
        }
        
    }];
    
}


#pragma mark -
#pragma mark TableView Delegate DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWActivityCell *cell = (HWActivityCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[HWActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.headImageView.backgroundColor = [UIColor clearColor];
    cell.delegate = self;
    [cell setShareItem:[self.baseListArr objectAtIndex:indexPath.row]];
    [cell setCoolTime:coolTime];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 25)];
    v.backgroundColor = BACKGROUND_COLOR;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 25)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"返现分享";
    label.textColor = THEME_COLOR_TEXT;
    label.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    [v addSubview:label];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 25 - 0.5f, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [v addSubview:line];
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HWShareItemClass *shareItem = [self.baseListArr objectAtIndex:indexPath.row];
    HWActivityCell *cell = (HWActivityCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (delegate && [delegate respondsToSelector:@selector(toSelectShareDetail:coolTime:shareImage:shareMethod:)])
    {
        [delegate toSelectShareDetail:shareItem coolTime:coolTime shareImage:cell.headImageView.image shareMethod:shareItem.shareMethod];
    }
}

#pragma mark -
#pragma mark HWRedPkgFirstPageCell Delegate

- (void)didClickShareButtonWithCell:(HWActivityCell *)cell
{
    _toShareItem = cell.myShareItem;
    _toShareCell = cell;
    [self requestBeforeShare];
}

- (void)remaindTime:(NSInteger)time
{
    if (time > 0)
    {
        activeTimer = YES;
    }
}

#pragma mark -
#pragma mark        UIAlertDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self shareFunction];
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
