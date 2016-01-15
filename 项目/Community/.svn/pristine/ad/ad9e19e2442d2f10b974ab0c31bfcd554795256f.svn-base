//
//  HWTianTianTuanListView.m
//  Community
//
//  Created by niedi on 15/7/31.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWTianTianTuanListView.h"
#import "HWTianTianTuanListCell.h"

@interface HWTianTianTuanListView ()<HWTianTianTuanListCellDelegate>
{
    
}
@end

@implementation HWTianTianTuanListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self queryListData];
    }
    return self;
}

- (void)requeryData
{
    self.currentPage = 0;
    [self queryListData];
}

- (void)queryListData
{
    /*接口名称：天天团订单列表
     接口地址：grpBuyOrder/orderList.do
     入参：key,page,size
     出参：{
     "status": "1",
     "data": {
     "content": [
     { "id": 5,订单id "orderCode": null, "payOrderId": null, "goodsId": null,商品id "address": null, "sendInfo": null, "orderStatus": 0,订单状态 (订单状态0未支付，1已支付未发货，2订单已退款，3已发货，4订单已关闭) "remark": null, "orderAmount": 100.0000,订单金额 "goodsCount": 2, "payType": null, "payMoney": null,支付金额 "payTime": null, "mobile": null, "name": null, "isExport": null, "expressName": null, "expressNumber": null, "sendGoodsTime": null, "createTime": null, "returnMoneyTime": null, "brand": null, "sellPrice": 50.0000, "goodsName": "红苹果", "postage": null, "orderImg": "xxx3", "userId": 1030431030435 }
     
     ],
     "size": 10,
     "number": 0,
     "sort": null,
     "numberOfElements": 1,
     "totalElements": 1,
     "lastPage": true,
     "firstPage": true,
     "totalPages": 1
     },
     "detail": "请求数据成功!",
     "key": "788f4790-b3af-48ff-8e42-f60e30a5714e"
     }*/
    
    [Utility hideMBProgress:self];
    [Utility showMBProgress:self message:LOADING_TEXT];
    
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    [parame setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [parame setPObject:@(kPageCount) forKey:@"size"];
    [parame setPObject:@(self.currentPage) forKey:@"page"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KTianTianTuanOrderList parameters:parame queue:nil success:^(id responese)
     {
         [Utility hideMBProgress:self];
         NSLog(@"%@", responese);
         
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
             HWTianTianTuanListModel *model = [[HWTianTianTuanListModel alloc] initWithDict:dic];
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

#pragma mark - HWTianTianTuanListCellDelegate
- (void)cellPayBtnClick:(HWTianTianTuanListModel *)model
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushToPayConfirmVC:)])
    {
        [self.delegate pushToPayConfirmVC:model.modelId];
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.baseListArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellId";
    HWTianTianTuanListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[HWTianTianTuanListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    HWTianTianTuanListModel *model = [self.baseListArr pObjectAtIndex:indexPath.section];
    [cell fillDataWithModel:model];
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DView *tableSectionHeader = [DView viewFrameX:0 y:0 w:kScreenWidth h:10.0f];
    return tableSectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HWTianTianTuanListModel *model = [self.baseListArr pObjectAtIndex:indexPath.section];
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushToOrderDetail:)])
    {
        [self.delegate pushToOrderDetail:model.modelId];
    }
}

@end
