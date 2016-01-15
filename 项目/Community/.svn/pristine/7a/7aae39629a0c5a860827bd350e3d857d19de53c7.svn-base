//
//  HWWuYeAddHouse1View.m
//  Community
//
//  Created by niedi on 15/6/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYeAddHouse1View.h"
#import "HWWuYeAddHouseCell.h"

@interface HWWuYeAddHouse1View ()
{
    HWWuYeAddHouseModel *_model;
    NSString *_buildingNo;
}
@end

@implementation HWWuYeAddHouse1View

- (instancetype)initWithFrame:(CGRect)frame model:(HWWuYeAddHouseModel *)model
{
    if (self = [super initWithFrame:frame])
    {
        _model = model;
        _buildingNo = _model.buildingNo;
        [self queryListData];
    }
    return self;
}

- (void)queryListData
{
    /*URL：hw-sq-app-web/userCertification/queryBuildingInfo.do
     villageId 小区id
     buildingNo 楼栋号(选填，查询第二级单元、门牌信息时必填)
     返回List：
     villageId 小区id
     buildingNo 楼栋号
     unitNo 单元号
     roomNo 门牌（房间号）*/
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:[HWUserLogin currentUserLogin].villageId forKey:@"villageId"];
    [param setPObject:_model.buildingNo forKey:@"buildingNo"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KWuYeAddHouseCheckInfo parameters:param queue:nil success:^(id responese)
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
             HWWuYeAddHouseModel *model = [[HWWuYeAddHouseModel alloc] initWithDict:[arr pObjectAtIndex:i]];
             [self.baseListArr addObject:model];
         }
         
         if (self.baseListArr.count > 0)
         {
             [self hideEmptyView];
         }
         else
         {
             [self showEmptyView:@"空数据"];
         }
         
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
     } failure:^(NSString *code, NSString *error) {
         [self doneLoadingTableViewData];
         [Utility showToastWithMessage:error inView:self];
     }];
}

- (void)addHouseQuery
{
    /*URL:/hw-sq-app-web/wyJF/addHouse.do
     入参：
     key
     villageId
     buildingNo
     unitNo
     roomNo
     出参：*/
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:_model.villageId forKey:@"villageId"];
    [param setPObject:_buildingNo forKey:@"buildingNo"];
    [param setPObject:_model.unitNo forKey:@"unitNo"];
    [param setPObject:_model.roomNo forKey:@"roomNo"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KWuYeAddHouse parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"responese ========================= %@",responese);
         
         if (self.delegate && [self.delegate respondsToSelector:@selector(doneAddHouse)])
         {
             [self.delegate doneAddHouse];
         }
         
         [self doneLoadingTableViewData];
     } failure:^(NSString *code, NSString *error) {
         [self doneLoadingTableViewData];
         [Utility showToastWithMessage:error inView:self];
     }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellID";
    HWWuYeAddHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[HWWuYeAddHouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    HWWuYeAddHouseModel *tmpModel = [self.baseListArr pObjectAtIndex:indexPath.row];
    NSString *leftStr;
    if (tmpModel.unitNo.length != 0)
    {
        leftStr = [NSString stringWithFormat:@"%@单元%@室", tmpModel.unitNo, tmpModel.roomNo];
    }
    else
    {
        leftStr = [NSString stringWithFormat:@"%@室", tmpModel.roomNo];
    }
    [cell fillDataWithLeftStr:leftStr];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWWuYeAddHouseModel *tmpModel = [self.baseListArr pObjectAtIndex:indexPath.row];
    NSString *leftStr;
    if (tmpModel.unitNo.length != 0)
    {
        leftStr = [NSString stringWithFormat:@"%@单元%@室", tmpModel.unitNo, tmpModel.roomNo];
    }
    else
    {
        leftStr = [NSString stringWithFormat:@"%@室", tmpModel.roomNo];
    }
    return [HWWuYeAddHouseCell getCellHeight:leftStr];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _model = [self.baseListArr pObjectAtIndex:indexPath.row];
    if (_isAddaddress == YES)
    {
        _model.buildingNo = _buildingNo;
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectAddressList:)])
        {
            [_delegate didSelectAddressList:_model];
        }
    }
    else
    {
        [self addHouseQuery];
    }
}

@end
