//
//  HWRedPacketViewController.m
//  HaoWu_4.0
//
//  Created by zhangxun on 14-7-31.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWRedPacketViewController.h"
#import "RedPacketCell.h"
#import "HWRedPacketObject.h"
#import "HWRedDetailViewController.h"

@interface HWRedPacketViewController ()

@property (nonatomic,strong)UIView *emptyView;

@end

#define kDelTag 999
#define kBottomTag 888

@implementation HWRedPacketViewController
@synthesize emptyView;

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
    self.navigationItem.titleView = [Utility navTitleView:@"红包"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.isNeedHeadRefresh = YES;
    self.baseTableView.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - 50);
    self.baseTableView.allowsSelectionDuringEditing = YES;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    self.baseTableView.tableHeaderView = view;
    baseTableView.backgroundColor = [UIColor clearColor];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CONTENT_HEIGHT - 50, kScreenWidth, 50)];
    bottomView.backgroundColor = [UIColor clearColor];
    bottomView.tag = kBottomTag;
    
    UIButton *hideBUtton = [UIButton buttonWithType:UIButtonTypeCustom];
    hideBUtton.frame = CGRectMake(kScreenWidth - 27, 5, 16, 16);
    [hideBUtton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [hideBUtton addTarget:self action:@selector(hideBottom:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:hideBUtton];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    whiteView.backgroundColor = [UIColor clearColor];
    [bottomView addSubview:whiteView];
    
    UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 15, kScreenWidth - 80, 20)];
    tipsLabel.text = @"朋友买房预约成功，可获得预约红包！";
    tipsLabel.backgroundColor = [UIColor clearColor];
    tipsLabel.textColor = [UIColor grayColor];
    tipsLabel.font = [UIFont fontWithName:FONTNAME size:12.0f];
    [bottomView addSubview:tipsLabel];
    [self.view addSubview:bottomView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self autoDragRefresh];
}

/**
 *	@brief	编辑tableview
 *
 *	@return	N/A
 */
- (void)doEdit
{
    if (baseTableView.editing)
    {
        [self.baseTableView setEditing:NO animated:YES];
    }
    else
    {
        [self.baseTableView setEditing:YES animated:YES];
    }
    
}

/**
 *	@brief	隐藏底部按钮
 *
 *	@param 	button 	点击的按钮
 *
 *	@return	N/A
 */
- (void)hideBottom:(UIButton *)button
{
    [UIView animateWithDuration:0.5 animations:^{
        self.baseTableView.frame =CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT);
        button.superview.frame = CGRectMake(0, CONTENT_HEIGHT, kScreenWidth, 50);
    } completion:^(BOOL finished) {
        [button.superview removeFromSuperview];
    }];
}


/**
 *	@brief	请求红包列表
 *
 *	@return	N/A
 */
- (void)queryListData
{
    [emptyView removeFromSuperview];
    emptyView = nil;
    
    // 无上拉加载更多
    isLastPage = YES;
    
    [Utility hideMBProgress:self.view];
    [Utility showMBProgress:self.view message:@"请求数据"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:@"1" forKey:@"channel"];
    [manager redPacketPost:kGetRedPocketList parameters:param queue:nil success:^(id responseObject) {
        time = 0;
        if (!_redPacketArray) {
            _redPacketArray = [NSMutableArray array];
        }
        [_redPacketArray removeAllObjects];
        //        responseObject = @{@"data": @{@"appointment": @[@{@"redId": @"1",@"activityName":@"活动1",@"rewardTime":@"11111,11,11",@"rewardMoney":@"100"},@{@"redId": @"2",@"activityName":@"活动2",@"rewardTime":@"2222,22,22",@"rewardMoney":@"200"}],
        //                                                  @"fork":@[@{@"redId":@"3",@"activityName":@"活动 3",@"rewardTime":@"3333,33,33",@"minReward":@"1",@"maxReward":@"50",@"effectiveTimeMills":@"1000000000",@"status":@"0",@"rewardMoney":@"100"},@{@"redId":@"3",@"activityName":@"活动 3",@"rewardTime":@"3333,33,33",@"minReward":@"10",@"maxReward":@"50",@"effectiveTimeMills":@"10000",@"status":@"1",@"rewardMoney":@"100"},@{@"redId":@"3",@"activityName":@"活动 3",@"rewardTime":@"3333,33,33",@"minReward":@"100",@"maxReward":@"50",@"effectiveTimeMills":@"100000",@"status":@"-1",@"rewardMoney":@"100"}]}};
        
        NSMutableArray *shareArray = [NSMutableArray array];
        NSMutableArray *appointmentArray = [NSMutableArray array];
        NSMutableArray *otherArray = [NSMutableArray array];
        for (int i = 0; i < [[[responseObject dictionaryObjectForKey:@"data"]arrayObjectForKey:@"fork"]count]; i++)
        {
            HWRedPacketObject *object = [[HWRedPacketObject alloc]init];
            [object fillWithDictionary:[[[responseObject dictionaryObjectForKey:@"data"]arrayObjectForKey:@"fork"]objectAtIndex:i]];
            [shareArray addObject:object];
        }
        [_redPacketArray addObject:shareArray];
        
        for (int i = 0; i < [[[responseObject dictionaryObjectForKey:@"data"]arrayObjectForKey:@"appointment"]count]; i++)
        {
            HWRedPacketObject *object = [[HWRedPacketObject alloc]init];
            [object fillWithDictionary:[[[responseObject dictionaryObjectForKey:@"data"]arrayObjectForKey:@"appointment"]objectAtIndex:i]];
            [appointmentArray addObject:object];
        }
        [_redPacketArray addObject:appointmentArray];
        for (int i = 0; [[[responseObject dictionaryObjectForKey:@"data"]arrayObjectForKey:@"other"]count]; i++)
        {
            HWRedPacketObject *object = [[HWRedPacketObject alloc]init];
            [object fillWithDictionary:[[[responseObject dictionaryObjectForKey:@"data"]arrayObjectForKey:@"other"]objectAtIndex:i]];
            [otherArray addObject:object];
        }
        if ([otherArray count] > 0)
        {
            [_redPacketArray addObject:otherArray];
        }
        
        [self doneLoadingTableViewData];
        
        if ([shareArray count] == 0 && [appointmentArray count] == 0 && [otherArray count] == 0)
        {
            [self emptyList];
        }
        
        [self.baseTableView reloadData];
        
        [_theTimer invalidate];
        _theTimer = nil;
        [self startTimer];
        _theTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_theTimer forMode:NSRunLoopCommonModes];
        
        [Utility hideMBProgress:self.view];

    } failure:^(NSString *code, NSString *error) {
        [self emptyList];
        [Utility hideMBProgress:self.view];
        [self doneLoadingTableViewData];

    }];
    
}

/**
 *	@brief	无红包页面
 *
 *	@return	N/A
 */
- (void)emptyList
{
    [emptyView removeFromSuperview];
    emptyView = nil;
    
    emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 64)];

    emptyView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    [self.view addSubview:emptyView];
    
    UIImageView *purseIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 128/2.0, 162/2.0)];
    purseIV.image = [UIImage imageNamed:@"redPacket_big"];
    purseIV.center = CGPointMake(kScreenWidth / 2.0, 120);
    [emptyView addSubview:purseIV];
    
    UILabel *noPacketLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, purseIV.frame.origin.y + purseIV.frame.size.height + 30, self.view.frame.size.width, 20)];
    noPacketLabel.textColor = [UIColor lightGrayColor];
    noPacketLabel.font = [UIFont fontWithName:FONTNAME size:14];
    noPacketLabel.textAlignment = NSTextAlignmentCenter;
    noPacketLabel.text = @"您还没有红包哦~";
    noPacketLabel.backgroundColor = [UIColor clearColor];
    [emptyView addSubview:noPacketLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(queryListData)];
    [emptyView addGestureRecognizer:tap];
    
    for (UIView *view in self.view.subviews)
    {
        if (view.tag == kBottomTag)
        {
            [self.view bringSubviewToFront:view];
        }
    }
}

/**
 *	@brief	启动计时器倒计时
 *
 *	@return	N/A
 */
- (void)startTimer
{
    time ++;
    NSArray *array = [self.baseTableView visibleCells];
    for (int i = 0;i < [array count];i++)
    {
        RedPacketCell *cell = [array objectAtIndex:i];
        if ([baseTableView indexPathForCell:cell].section == 1 && cell.effectiveTimeMills > 0 && ![cell.status isEqualToString:@"1"])
        {
            long a = (long)[cell.effectiveTimeMills longLongValue] / 1000;
            a -= time;
            if (a<=0)
            {
                [cell countDownFinish];
            }
            else
            {
                if (a / (3600 * 24) > 0)
                {
                    cell.dateLabel.text = [NSString stringWithFormat:@"%ld天%ld小时%ld分钟", a / (3600 * 24), (a % (3600 * 24)) / 3600, (a % 3600) / 60];
                }
                else
                {
                    cell.dateLabel.text = [NSString stringWithFormat:@"%ld小时%ld分钟%ld秒", a / 3600, (a % 3600) / 60, a % 60];
                }
            }
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_redPacketArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_redPacketArray objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([[_redPacketArray objectAtIndex:section] count] > 0)
    {
        return 30.0f;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == [_redPacketArray count] - 1)
    {
        return 0;
    }
    if ([[_redPacketArray objectAtIndex:section] count] > 0)
    {
        return 20.0f;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0f;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        _delIndex = indexPath;
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"红包一旦删除，无法恢复" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = kDelTag;
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == kDelTag)
    {
        if (buttonIndex == 1)
        {
//            [[_redPacketArray objectAtIndex:_delIndex.section]removeObjectAtIndex:_delIndex.row];
            
            [self delRedPacket];
        }
    }
}

/**
 *	@brief	删除红包
 *
 *	@return	N/A
 */
- (void)delRedPacket
{
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    HWRedPacketObject *redObj = [[_redPacketArray objectAtIndex:_delIndex.section]objectAtIndex:_delIndex.row];
    [parm setObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [parm setObject:redObj.keyId forKey:@"id"];
    [parm setObject:_delIndex.section == 0 ? @"1":@"2" forKey:@"type"];
    [parm setPObject:@"1" forKey:@"channel"];
    [manager redPacketPost:kDelRedPackage parameters:parm queue:nil success:^(id responseObject) {
        [[_redPacketArray objectAtIndex:_delIndex.section]removeObjectAtIndex:_delIndex.row];
        [self.baseTableView reloadSections:[NSIndexSet indexSetWithIndex:_delIndex.section] withRowAnimation:UITableViewRowAnimationFade];
        
        if (_redPacketArray.count == 0)
        {
            [self emptyList];
        }

    } failure:^(NSString *code, NSString *error) {
        
    }];
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    label.font = [UIFont fontWithName:FONTNAME size:16];
    label.textColor = [UIColor grayColor];
    if (section ==0)
    {
        label.text = [NSString stringWithFormat:@"   关注红包%d个",[[_redPacketArray objectAtIndex:section] count]];
    }
    else if (section == 1)
    {
        label.text = [NSString stringWithFormat:@"   预约红包%d个",[[_redPacketArray objectAtIndex:section] count]];
    }
    else
    {
        label.text = [NSString stringWithFormat:@"   其他红包%d个",[[_redPacketArray objectAtIndex:section] count]];
    }
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = THEME_COLOR_SMOKE;
    UIView *topLineV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    topLineV.backgroundColor = THEME_COLOR_LINE;
    [label addSubview:topLineV];
    UIView *bottomLineV = [[UIView alloc]initWithFrame:CGRectMake(10, 29.5, kScreenWidth - 20, 0.5)];
    bottomLineV.backgroundColor = THEME_COLOR_LINE;
    [label addSubview:bottomLineV];
    return label;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor = [UIColor clearColor  ];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    RedPacketCell *cell = (RedPacketCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];;
    if (!cell)
    {
        cell = [[RedPacketCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell sizeFitWithObject:(HWRedPacketObject *)[[_redPacketArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] section:indexPath.section];
    
    if (indexPath.row == [[_redPacketArray objectAtIndex:indexPath.section] count] - 1)
    {
        [cell setFinaLine];
    }
    else
    {
        [cell setNormalLine];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.editing)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RedPacketCell *cell = (RedPacketCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSInteger waitTime = 0;
    if ([cell.effectiveTimeMills intValue] > 0)
    {
        waitTime = [cell.effectiveTimeMills intValue] / 1000 - time;
    }
    HWRedDetailViewController *redDetail = [[HWRedDetailViewController alloc] initWithRedObj:[[_redPacketArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] waitTime:waitTime];
    [self.navigationController pushViewController:redDetail animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
