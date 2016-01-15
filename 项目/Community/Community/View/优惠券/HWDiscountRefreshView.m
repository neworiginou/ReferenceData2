//
//  HWDiscountRefreshView.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/17.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：优惠券view  带刷新功能
//  修改记录：
//      李中强 2015-01-20 检查代码 请相关人员添加注释
//

#import "HWDiscountRefreshView.h"
#import "HWCoreDataManager.h"

@implementation HWDiscountRefreshView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialHeader];
        [self initialData];
        [self queryListData];
    }
    return self;
}

- (void)initialHeader
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    headerView.backgroundColor = [UIColor clearColor];
    [Utility bottomLine:headerView];
    self.baseTable.tableHeaderView = headerView;
}

- (void)initialData
{
    self.baseListArr = (NSMutableArray *)[HWCoreDataManager searchAllPriviledgeItem];
    if (self.baseListArr.count < kPageCount)
    {
        isLastPage = YES;
    }
    //初始化优惠券活动时间
    priviledgeActivityTime = 0;
}

- (void)refreshPriviledgeType:(NSString *)model
{
    int a = [self.baseListArr indexOfObject:model];
    NSLog(@"%d", a);
}

- (void)getPriviledgeCoolTime:(NSArray*)arry
{
    for (int i = 0; i < self.baseListArr.count; i++)
    {
//        HWPriviledgeModel *item = [self.baseListArr objectAtIndex:i];
//        int coolTimeTemp = [item.timeStr integerValue] / 1000.0f;
//        maxColdTime = coolTimeTemp > maxColdTime ? coolTimeTemp : maxColdTime;
        //add by gusheng
         HWPriviledgeModel *item = [self.baseListArr objectAtIndex:i];
        int coolTimeTemp = [item.remainMsStr integerValue] / 1000.0f;
        if(coolTimeTemp > 0)
        {
            
        }
        else
        {
            coolTimeTemp = 0;
        }
         maxColdTime = coolTimeTemp > maxColdTime ? coolTimeTemp : maxColdTime;
       
        //end
        
    }
}

- (void)countNum:(id)sender
{
    if (maxColdTime - priviledgeActivityTime <= 0)
    {
        [priviledgeTimer invalidate];
        [self.baseTable reloadData];
        return;
    }
    priviledgeActivityTime ++;
    [self.baseTable reloadData];
}

- (void)queryListData
{
    /*URL: coupon/list.do
     请求参数:
     provinceId	省份ID
     cityId	城市ID
     districtId	区县ID
     villageId	小区ID
     page	页码
     size	条数
     返回结果:
     {
     "status": "1",
     "data": {
     "content": [
     { "couponId": 1, "name": "12123123213", "count": null, "type": 1, "listPic": null, "getTimeStart": 1417926481000, "offlineTime": 1418905688000, "status": 3 }
     ,
     { "couponId": 2, "name": "12123123213", "count": null, "type": 2, "listPic": null, "getTimeStart": 1417962481000, "offlineTime": 1418819288000, "status": 3 }
     ,
     { "couponId": 3, "name": "12123123213", "count": null, "type": 1, "listPic": null, "getTimeStart": 1418045281000, "offlineTime": 1418732891000, "status": 3 }
     ],
     "size": 20,
     "number": 0,
     "sort": null,
     "totalPages": 1,
     "numberOfElements": 3,
     "lastPage": true,
     "firstPage": true,
     "totalElements": 3
     },
     "detail": "请求数据成功!",
     "key": "ad5d8829-fa15-44db-87be-00acecf67ee5"
     }
     */
    [Utility hideMBProgress:self];
    [Utility showMBProgress:self message:@"请求数据"];
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:user.villageId forKey:@"villageId"];
    [param setPObject:user.cityId forKey:@"cityId"];
    
    if ([user.cityId length] >= 2)
    {
        NSString *provinceIdStr = [NSString stringWithFormat:@"%@0000",[user.cityId substringToIndex:2]];
        [param setPObject:provinceIdStr forKey:@"provinceId"];
    }
    
    [param setPObject:[NSString stringWithFormat:@"%d",self.currentPage] forKey:@"page"];
    [param setPObject:[NSString stringWithFormat:@"%d",kPageCount] forKey:@"size"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];

    [manager POST:kPriviledgeLists parameters:param queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self];
        NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
        NSArray *contents = [dataDic arrayObjectForKey:@"content"];
        NSMutableArray *array = [NSMutableArray array];
        
        for (int i = 0; i < contents.count; i++)
        {
            HWPriviledgeModel *shareItem = [[HWPriviledgeModel alloc] initWithDic:[contents objectAtIndex:i]];
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
            if (self.baseListArr.count != 0)
            {
                [HWCoreDataManager removeAllPriviledgeItem];
                [HWCoreDataManager addPriviledgeItem:self.baseListArr];
            }
        }
        else
        {
            [self.baseListArr addObjectsFromArray:array];
        }
        [self.baseTable reloadData];
        
        if (self.baseListArr.count == 0)
        {
            [self showEmptyView:@"暂无优惠券"];
        }
        else
        {
            [self hideEmptyView];
        }
        
        [self doneLoadingTableViewData];
        //初始化优惠劵定时器
        priviledgeActivityTime = 0;
        [priviledgeTimer invalidate];
        priviledgeTimer = nil;
        [self getPriviledgeCoolTime:self.baseListArr];
        
        if (maxColdTime > 0)
        {
            priviledgeTimer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(countNum:) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop]addTimer:priviledgeTimer forMode:NSRunLoopCommonModes];
        }
        
    } failure:^(NSString *code, NSString *error) {
        
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
        
        [self doneLoadingTableViewData];
        NSLog(@"houselist error hwhttprequest:%@",error);
        if (self.baseListArr.count == 0)
        {
            [self showEmptyView:@"暂无优惠券"];
        }
        else
        {
            [self hideEmptyView];
        }
        
    }];
}

#pragma mark -
#pragma mark        UITableView Delegate

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
    static NSString *cellIdentifier = @"PriviledgeIdentifier";
    HWPriviledgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[HWPriviledgeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    int row = (int)indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setPriviledgeValue:[self.baseListArr pObjectAtIndex:row]];
    [cell setCoolTime:priviledgeActivityTime];
    cell.delegate = self;
    
    if (indexPath.row == self.baseListArr.count - 1)
    {
        cell.line.hidden = YES;
    }
    else
    {
        cell.line.hidden = NO;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HWPriviledgeTableViewCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (delegate && [delegate respondsToSelector:@selector(didSelectPriviledgeDetail:activeTime:)])
    {
        HWPriviledgeModel *shareItem = [self.baseListArr pObjectAtIndex:indexPath.row];
        [delegate didSelectPriviledgeDetail:shareItem activeTime:priviledgeActivityTime];
    }
}

- (void)didClickGetPriviledge:(HWPriviledgeModel *)priviledge
{
    if (delegate && [delegate respondsToSelector:@selector(didSelectDirectGetPriviledge:)])
    {
        [delegate didSelectDirectGetPriviledge:priviledge];
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
