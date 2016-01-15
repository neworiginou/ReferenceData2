//
//  HWServiceListView.m
//  Community
//
//  Created by hw500027 on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：个人-我的订单-服务订单 view
//
//  修改记录：
//      姓名         日期               修改内容
//     陆晓波     2015-06-15            创建文件
//

#import "HWServiceListView.h"
#import "HWServiceListCell.h"
#import "HWPayConfirmVC.h"

@interface HWServiceListView ()<HWServiceListCellDelegate>

@end

@implementation HWServiceListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self queryListData];
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        [Utility bottomLine:headView];
        self.baseTable.tableHeaderView = headView;
        [self.baseTable registerClass:[HWServiceListCell self] forCellReuseIdentifier:[HWServiceListCell reuseID]];
    }
    return self;
}

- (void)reQueryListData
{
    self.currentPage = 0;
    [self queryListData];
}

- (void)queryListData
{
    [Utility hideMBProgress:self];
    [Utility showMBProgress:self message:@"请求数据"];
    
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    [parame setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [parame setPObject:[HWUserLogin currentUserLogin].villageId forKey:@"villageId"];
    [parame setPObject:@(kPageCount) forKey:@"size"];
    [parame setPObject:@(self.currentPage) forKey:@"page"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kServiceList parameters:parame queue:nil success:^(id responese)
    {
        [Utility hideMBProgress:self];
        NSArray *dataArray = [[responese dictionaryObjectForKey:@"data"] arrayObjectForKey:@"content"];
        if (dataArray.count < kPageCount)
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
        for (NSDictionary *dic in dataArray)
        {
            HWServiceListModel *model = [[HWServiceListModel alloc]initWithDic:dic];
            //过滤已取消状态
            if (![model.status isEqual:@"6"])
            {
               [self.baseListArr addObject:model];
            }
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
        
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"code==%@  error==%@",code,error);
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

#pragma mark - HWServiceListCellDelegate
- (void)evaluateBtnClick:(NSString *)currentOrderId
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushToEvaluateVC:)])
    {
        [self.delegate pushToEvaluateVC:currentOrderId];
    }
}

- (void)toPayBtnClick:(HWServiceListModel *)model
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectListView:)])
    {
        HWPayConfirmVC *vc = [[HWPayConfirmVC alloc] init];
        vc.type = HWPayConfirmTypeHomeServiceForList;
        vc.model = model;
        [self.delegate didSelectListView:vc];
    }
}

#pragma mark --tableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HWServiceListCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectListView:)])
    {
        //已取消的订单已经过滤
        HWServiceListDetailViewController *vc = [[HWServiceListDetailViewController alloc] init];
        vc.pushType = pushHomeServiceDetailTypeList;
         vc.orderID = [[self.baseListArr pObjectAtIndex:indexPath.row]orderId];
        [_delegate didSelectListView:vc];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWServiceListCell *cell = [tableView dequeueReusableCellWithIdentifier:[HWServiceListCell reuseID]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillDataWithModel:[self.baseListArr pObjectAtIndex:indexPath.row]];
    cell.delegate = self;
    [Utility bottomLine:cell.contentView];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[self.baseListArr pObjectAtIndex:indexPath.row]status] isEqual:@"5"] || [[[self.baseListArr pObjectAtIndex:indexPath.row]status] isEqual:@"7"])
    {
        return UITableViewCellEditingStyleDelete;
    }
    else
    {
        return UITableViewCellEditingStyleNone;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[self.baseListArr pObjectAtIndex:indexPath.row]status] isEqual:@"5"] || [[[self.baseListArr pObjectAtIndex:indexPath.row]status] isEqual:@"7"])
    {
        [Utility hideMBProgress:self];
        [Utility showMBProgress:self message:@"请求数据"];
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
        [param setPObject:[[self.baseListArr pObjectAtIndex:indexPath.row]orderId] forKey:@""];
        
        HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
        [manager POST:kDelServeOrder parameters:param queue:nil success:^(id responese)
        {
            [Utility hideMBProgress:self];
            [self queryListData];
        } failure:^(NSString *code, NSString *error)
        {
            [Utility hideMBProgress:self];
            [Utility showToastWithMessage:error inView:self];
        }];
    }
}

@end
