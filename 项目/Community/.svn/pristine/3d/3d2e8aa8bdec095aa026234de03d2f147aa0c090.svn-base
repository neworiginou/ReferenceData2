//
//  HWInviteCustomRecordListView.m
//  Community
//
//  Created by niedi on 15/6/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWInviteCustomRecordListView.h"
#import "HWInviteCustomRecordListCell.h"

@interface HWInviteCustomRecordListView ()
{
    NSString *_tvId;
    NSInteger _count;
}
@end

@implementation HWInviteCustomRecordListView

- (instancetype)initWithFrame:(CGRect)frame tvId:(NSString *)tvId
{
    if (self = [super initWithFrame:frame])
    {
        _tvId = tvId;
        [self loadUI];
        [self queryListData];
    }
    return self;
}

- (void)queryListData
{
    /*URL:/hw-sq-app-web/visitor/findByDetailsList.do
     入参：
     key
     visitorId 访客信息id
     page 分页
     size
     出参：
     /访客id/
     private Long visitorId;
     /访客记录详情/
     private List list;
     /访客记录总数/
     private Integer count;*/
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:_tvId forKey:@"visitorId"];
    [param setPObject:@(self.currentPage) forKey:@"page"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KInviteCustomHistoryList parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"responese ========================= %@",responese);
         if (self.currentPage == 0)
         {
             [self.baseListArr removeAllObjects];
         }
         
         NSString *countStr = [[responese dictionaryObjectForKey:@"data"] stringObjectForKey:@"count"];
         _count = [countStr integerValue];
         
         NSArray *arr = [[responese dictionaryObjectForKey:@"data"] arrayObjectForKey:@"list"];
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
             NSString *str = [arr pObjectAtIndex:i];
             [self.baseListArr addObject:str];
         }
         
         if (self.baseListArr.count > 0)
         {
             [self hideEmptyView];
         }
         else
         {
             [self showEmptyView:@"暂无记录"];
         }
         
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
     } failure:^(NSString *code, NSString *error) {
         [self doneLoadingTableViewData];
         [Utility showToastWithMessage:error inView:self];
     }];
    /*{
     "status": "1",
     "data": {
     "visitorId": 2,
     "list": [
     1434160800000,
     1434168000000
     ],
     "count": 2
     },
     "detail": "请求数据成功!",
     "key": "3a956781-6179-47af-8af3-d28d4554b87d"
     }*/
}

- (void)loadUI
{
    DView *tableHeaderV = [DView viewFrameX:0 y:0 w:kScreenWidth h:10.0f];
    DImageV *line = [DImageV imagV:@"" frameX:0 y:9.5f w:kScreenWidth h:0.5f];
    line.backgroundColor = THEME_COLOR_LINE;
    [tableHeaderV addSubview:line];
    
    self.baseTable.tableHeaderView = tableHeaderV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellID";
    HWInviteCustomRecordListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[HWInviteCustomRecordListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSString *dateStr = [self.baseListArr pObjectAtIndex:indexPath.row];
    [cell fillDataWithDateStr:dateStr timesStr:[NSString stringWithFormat:@"第%ld次访问", _count - indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HWInviteCustomRecordListCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
