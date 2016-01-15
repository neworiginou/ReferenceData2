//
//  HWWuYeAddHouseView.m
//  Community
//
//  Created by niedi on 15/6/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYeAddHouseView.h"
#import "HWWuYeAddHouseCell.h"
#import "HWWuYeAddHouseModel.h"

@implementation HWWuYeAddHouseView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
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
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KWuYeAddHouseCheckInfo parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"responese ========================= %@",responese);
         isLastPage = YES;
         
         if (self.currentPage == 0)
         {
             [self.baseListArr removeAllObjects];
         }
         
         NSArray *arr = [[responese dictionaryObjectForKey:@"data"] arrayObjectForKey:@"content"];
         
         for (int i = 0; i < arr.count; i ++)
         {
             HWWuYeAddHouseModel *model = [[HWWuYeAddHouseModel alloc] initWithDict:[arr pObjectAtIndex:i]];
             [self.baseListArr addObject:model];
         }
         
         [self.baseTable reloadData];
         
         if (self.baseListArr.count > 0)
         {
             [self hideEmptyView];
         }
         else
         {
             [self showEmptyView:@"本小区暂未添加住房"];
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
    NSString *leftStr = [NSString stringWithFormat:@"%@%@号楼", [HWUserLogin currentUserLogin].villageName, tmpModel.buildingNo];
    [cell fillDataWithLeftStr:leftStr];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWWuYeAddHouseModel *tmpModel = [self.baseListArr pObjectAtIndex:indexPath.row];
    NSString *leftStr = [NSString stringWithFormat:@"%@%@号楼", [HWUserLogin currentUserLogin].villageName, tmpModel.buildingNo];
    return [HWWuYeAddHouseCell getCellHeight:leftStr];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HWWuYeAddHouseModel *tmpModel = [self.baseListArr pObjectAtIndex:indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickCellWithModel:)])
    {
        [self.delegate didClickCellWithModel:tmpModel];
    }
}

@end
