//
//  HWGoodsListView.m
//  Community
//
//  Created by lizhongqiang on 15/4/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWGoodsListView.h"
#import "HWGoodsDetailViewController.h"
#import "HWCountDownCustomView.h"
#import "HWCoreDataManager.h"
#import "AppDelegate.h"

@interface HWGoodsListView ()<HWGoodsDetailViewControllerDelegate>
{
//    NSString *_selectTime;
}
@end

@implementation HWGoodsListView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryListData) name:HWAlertItemNotification object:nil];
        [self setBackgroundColor:BACKGROUND_COLOR];
        
        [self queryListData];
    }
    return self;
}

- (void)queryListData
{
    [Utility hideMBProgress:self];
    [Utility showMBProgress:self message:LOADING_TEXT];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager cutManager];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
//    [param setPObject:[NSString stringWithFormat:@"%d",self.currentPage] forKey:@"pageNumber"];
//    [param setPObject:[NSString stringWithFormat:@"%d",kPageCount] forKey:@"pageSize"];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:@"1" forKey:@"source"];
    [manager POST:kCutProductList parameters:param queue:nil success:^(id responese) {
//        NSLog(@"%@",responese);
        _theTime = 0;
        //0未开始，1 进行中，2流标，3已开奖,4活动结束
        [Utility hideMBProgress:self];
        isLastPage = YES;
//        self.wuDiXianChannelId = [[responese dictionaryObjectForKey:@"data"] stringObjectForKey:@"wdx"];
//        [self jumpTowuDiXianChannel];
        [self.baseListArr removeAllObjects];
        NSArray *array = [[responese dictionaryObjectForKey:@"data"] arrayObjectForKey:@"list"];
        
        for (int i = 0; i < array.count; i ++)
        {
            HWGoodsListModel *model = [[HWGoodsListModel alloc] initWithDict:array[i]];
            [self.baseListArr addObject:model];
        }
        
        if (self.baseListArr.count == 0)
        {
            [self showEmpty:@"暂无砍价活动" withOffset:0];
        }
        else
        {
            [self hideEmptyView];
        }
        
        [self doneLoadingTableViewData];
        [self.baseTable reloadData];
        
        [_theTimer invalidate];
        _theTimer = nil;
        [self startTimer];
        _theTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_theTimer forMode:NSRunLoopCommonModes];
        
    } failure:^(NSString *code, NSString *error) {
        [self doneLoadingTableViewData];
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
//        if (self.baseListArr.count == 0)
//        {
//            [self showEmpty:@"暂无砍价活动" withOffset:0];
//        }
        NSLog(@"%@",error);
    }];
}

- (void)jumpTowuDiXianChannel
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(setWuDiXianChannelId:)])
    {
        [self.delegate setWuDiXianChannelId:self.wuDiXianChannelId];
    }
}

- (void)startTimer
{
    //0未开始，1 进行中，2流标，3已开奖,4活动结束
    _theTime ++;
    NSArray *array = [self.baseTable visibleCells];
    for (int i = 0; i < [array count]; i ++)
    {
        HWGoodsListCell *cell = [array objectAtIndex:i];
        long long num = ABS([cell.remainMs longLongValue]) / 1000.0f;
        num -= _theTime;
        if ([cell.status isEqualToString:@"0"] && num >= 0)
        {
            
            NSLog(@"这里未开始time = %lld",num);
            
            cell.clockLabel.text = [NSString stringWithFormat:@"%.2lld:%.2lld:%.2lld",num / 3600, (num % 3600) / 60, num % 60];
            CGSize clockSize = [Utility calculateStringWidth:cell.clockLabel.text font:cell.clockLabel.font constrainedSize:CGSizeMake(CGFLOAT_MAX, 21)];
            float widthContent = clockSize.width + 19 + 10;
            cell.clockTimeImg.frame = CGRectMake((kScreenWidth - widthContent - 10) / 2, 60 * kScreenRate, 19, 18);
            cell.clockLabel.frame = CGRectMake((kScreenWidth - widthContent - 10) / 2 + 23, 59 * kScreenRate, clockSize.width, 21);
        }
        else if ([cell.status isEqualToString:@"1"] && num >= 0)
        {
//            num -= _theTime;
            cell.countDownLabel.text = [NSString stringWithFormat:@"%.2lld:%.2lld:%.2lld",num / 3600, (num % 3600) / 60, num % 60];
            //修改UI
            CGSize countDownSize = [Utility calculateStringWidth:cell.countDownLabel.text font:cell.countDownLabel.font constrainedSize:CGSizeMake(CGFLOAT_MAX, 21)];
            
            cell.timeList.frame = CGRectMake(kScreenWidth - countDownSize.width - 20 - 35, (134 - 5 - 18.5f) * kScreenRate, countDownSize.width + 35, 18.5f);
            cell.countDownImage.frame = CGRectMake(5, 3, 13, 12.5);
            cell.countDownLabel.frame = CGRectMake(27, 0, countDownSize.width, 19);
            
        }
        
        if (num <= 0)
        {
            [self queryListData];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.baseListArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200.0f * kScreenRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10.0f)];
    [view setBackgroundColor:BACKGROUND_COLOR];
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[HWGoodsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.delegate = self;
    [cell setCellWithModel:(HWGoodsListModel *)[self.baseListArr objectAtIndex:indexPath.section]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWGoodsListModel *model = (HWGoodsListModel *)[self.baseListArr objectAtIndex:indexPath.section];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([model.status isEqualToString:@"1"])    //1开始 0未开始
    {
        if (delegate && [delegate respondsToSelector:@selector(cellSelectPushVC:)])
        {
            HWGoodsDetailViewController *detail = [[HWGoodsDetailViewController alloc] init];
            detail.productId = model.productId;
            detail.delegate = self;
            [detail.navigationController setNavigationBarHidden:YES animated:NO];
            [delegate cellSelectPushVC:detail];
        }
    }
}

#pragma mark - 设置闹钟
- (void)setClockWithModel:(HWGoodsListModel *)listModel
{
    HWCountDownCustomView * countView = [[HWCountDownCustomView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT + 64) WithType:@"开始"];
    [countView show];
    
    if (self.selectTime.length != 0)
    {
        [countView resetSlideViewWithMinutes:self.selectTime withConstant:self.floatConstant];
    }
    
    __weak HWGoodsListView *weakSelf = self;
    countView.afterSureBtnBlock = ^(float constant)
    {
        weakSelf.floatConstant = constant;
    };
    
    countView.sureBtnBlock = ^(NSInteger time)
    {
        weakSelf.selectTime = [NSString stringWithFormat:@"%d",time / 60];
        [Utility removeAlertItemWithProductId:listModel.productId];
        if (time == 0)
        {
            [[HWUserLogin currentUserLogin] removeAlertItemById:listModel.productId];
            [weakSelf queryListData];
            return ;
        }
//
        long long alertTime = ABS(listModel.remainMs.longLongValue) / 1000.0f - time - _theTime;
        if (alertTime <= 0)
        {
            AppDelegate *appDel = SHARED_APP_DELEGATE;
            [Utility showToastWithMessage:[NSString stringWithFormat:@"还有%.0f分钟就开始了", ceilf(listModel.remainMs.longLongValue / 1000.0f - _theTime) / 60.0f ] inView:appDel.window];
            return;
        }
        
        long long alertTimeStamp = [[NSDate date] timeIntervalSince1970] + alertTime;
        
        HWAlertModel *model = [[HWAlertModel alloc] init];
        model.goodsId = listModel.productId;
        model.alertTime = [NSString stringWithFormat:@"%lld", alertTimeStamp];
        [[HWUserLogin currentUserLogin] saveUserAlertTime:model];
        
//        NSLog(@"倒计时%ld",(long)time);
        UIApplication *app = [UIApplication sharedApplication];
        
        if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
        {
            [app registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil]];
        }
        
        UILocalNotification * noti = [[UILocalNotification alloc]init];
        if (noti)
        {
            noti.fireDate = [NSDate dateWithTimeIntervalSince1970:alertTimeStamp];
//            noti.fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTimeStamp];
            noti.timeZone = [NSTimeZone defaultTimeZone];
            noti.soundName = UILocalNotificationDefaultSoundName;
            noti.repeatInterval = NSWeekCalendarUnit;
            noti.alertBody = [NSString stringWithFormat:@"%@ 开始砍价了",listModel.productName];
            NSDictionary * infoDic = [NSDictionary dictionaryWithObject:listModel.productId forKey:@"goodsId"];
            noti.userInfo = infoDic;
            [app scheduleLocalNotification:noti];
            [weakSelf queryListData];
        }
//        [weakSelf queryListData];
        [weakSelf.baseTable reloadData];
        [weakSelf setNeedsUpdateConstraints];
        
    };
}

#pragma mark - HWGoodsDetailViewControllerDelegate
- (void)goodsListRefreshView
{
    [self queryListData];
}

- (void)dealloc
{
    self.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAlertItemNotification object:nil];
}

@end
