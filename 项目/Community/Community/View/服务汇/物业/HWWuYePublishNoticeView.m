//
//  HWWuYePublishNoticeView.m
//  Community
//
//  Created by niedi on 15/6/11.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYePublishNoticeView.h"
#import "HWWuYePublishNoticeCell.h"

@implementation HWWuYePublishNoticeView

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
    /*点击物业公告进入公告列表
     接口2：hw-sq-app-web/wy/queryTenementList.do
     入参：key=6f5ddc33-b076-422c-bdc0-c099a0d14717
     出参：
     {
     'status': '1',
     'data': {
     'content': [
     { 'topicId': 1034481469, 'content': '和好久没有尤文图斯', 'createTime': 1423727247000 }
     
     ,
     { 'topicId': 1034518485, 'content': '大家请注意。由于过年放假回家，大家关好门窗，煤气，水电。出门多穿衣服。。。\r\n', 'createTime': 1423722475000 }
     
     ],
     'size': 10,
     'number': 0,
     'sort': null,
     'lastPage': true,
     'firstPage': true,
     'numberOfElements': 2,
     'totalPages': 1,
     'totalElements': 2
     },
     'detail': '请求数据成功!',
     'key': '6f5ddc33-b076-422c-bdc0-c099a0d14717'
     }*/
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:@(self.currentPage) forKey:@"page"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KWuYePublishNoticeList parameters:param queue:nil success:^(id responese)
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
             HWWuYePublishNoticeModel *model = [[HWWuYePublishNoticeModel alloc] initWithDict:[arr pObjectAtIndex:i]];
             [self.baseListArr addObject:model];
         }
         
         if (self.baseListArr.count > 0)
         {
             [self hideEmptyView];
         }
         else
         {
             [self showEmptyView:@"暂无公告"];
         }
         
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
     } failure:^(NSString *code, NSString *error) {
         [self doneLoadingTableViewData];
         [Utility showToastWithMessage:error inView:self];
     }];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"celid";
    HWWuYePublishNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
    {
        cell = [[HWWuYePublishNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    [cell fillData:[self.baseListArr pObjectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HWWuYePublishNoticeCell getCellHeight:[self.baseListArr pObjectAtIndex:indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
