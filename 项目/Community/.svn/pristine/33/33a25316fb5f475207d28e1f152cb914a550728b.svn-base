//
//  HWPublicRepairTotalView.m
//  Community
//
//  Created by niedi on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWPublicRepairTotalView.h"
#import "HWPublicRepairCell.h"
#import "HWAlertComplainView.h"

@interface HWPublicRepairTotalView ()<HWPublicRepairCellDelegate, HWAlertComplainViewDelegate>
{
    NSString *_cardEavluateId;
    
    BOOL isReEvlaute;
}
@end

@implementation HWPublicRepairTotalView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
//        [self loadUI];
        isReEvlaute = NO;
        [self queryListData];
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
    /*接口：hw-sq-app-web/repair/queryAllRepairByVillageId.do 查询某小区报修列表
     入参：key：用户key
     page：页码
     size：每页数量
     输出参数：
     {
     "status": "1",
     "data": {
     "content": [
     { "nickName": 昵称, "status": 状态,当前状态(0待处理,1处理中,2处理完毕) "result": 评论结果,结果(0,不满意,1满意) "createTimeStr": 创建时间, "spendTimeStr": 耗时, "images": 图片, }
     
     "size": 10,
     "number": 0,
     "totalElements": 4,
     "lastPage": true,
     "firstPage": true,
     "sort": null,
     "totalPages": 1,
     "numberOfElements": 2
     ]
     "detail": "请求数据成功!",
     "key": "a79dbe5c-bf01-4c47-b4ac-ed9ca9c6b1d0"
     }*/
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:@(self.currentPage) forKey:@"page"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KPublishRepairListTotal parameters:param queue:nil success:^(id responese)
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
             HWPublicRepairModel *model = [[HWPublicRepairModel alloc] initWithDict:[arr pObjectAtIndex:i]];
             [self.baseListArr addObject:model];
         }
         
         if (self.baseListArr.count > 0)
         {
             [self hideEmptyView];
         }
         else
         {
             [self showEmptyView:@"暂无报修记录"];
         }
         
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
     } failure:^(NSString *code, NSString *error) {
         [self doneLoadingTableViewData];
         [Utility showToastWithMessage:error inView:self];
     }];
    
    /*{
     comment = "<null>";
     content = "\U4ec0\U4e48\U53fc\U95ee\U9898\U90fd\U6709";
     contentImages = "134sadf;sdfg";
     createTime = 1434111870000;
     createTimeStr = "5\U5929\U524d";
     creater = "<null>";
     disabled = "<null>";
     id = 32;
     images =                 (
     "file/downloadByKey.do?mKey=134sadf;sdfg"
     );
     modifyTime = 1434370795000;
     nickName = "<null>";
     result = "<null>";
     spendTimeStr = "<null>";
     status = 0;
     userId = 1234;
     villageId = 10;
     workorderId = "<null>";
     },*/
}

- (void)loadUI
{
    DView *tableHeaderV = [DView viewFrameX:0 y:0 w:kScreenWidth h:10.0f];
    DImageV *line = [DImageV imagV:@"" frameX:0 y:9.5f w:kScreenWidth h:0.5f];
    line.backgroundColor = THEME_COLOR_LINE;
    [tableHeaderV addSubview:line];
    
    self.baseTable.tableHeaderView = tableHeaderV;
    
}

#pragma mark - HWPublicRepairCellDelegate
- (void)evaluateBtnClick:(NSString *)modelId
{
    _cardEavluateId = modelId;
    HWAlertComplainView *alert = [[HWAlertComplainView alloc] init];
    alert.delegate = self;
    [alert show];
}

- (void)unSatisfyReEvaluateClick:(NSString *)modelId
{
    _cardEavluateId = modelId;
    isReEvlaute = YES;
    HWAlertComplainView *alert = [[HWAlertComplainView alloc] init];
    alert.delegate = self;
    [alert show];
}

#pragma mark - HWAlertComplainViewDelegate
- (void)evaluateBtnClickResult:(BOOL)isSatisfy
{
    /*接口：hw-sq-app-web/repair/evaluateRepair.do 报修评论接口
     入参：key：用户key，id：报修主键id，result：评价结果(0,不满意,1满意)
     出参：
     { 'status': '1', 'data': '', 'detail': '请求数据成功!', 'key': '3e801f50-10d8-44d7-9ce7-83e57fe582f1' } */
    
    if (isReEvlaute)
    {
        if (!isSatisfy)
        {
            isReEvlaute = NO;
            return;
        }
    }
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:_cardEavluateId forKey:@"id"];
    if (isSatisfy)
    {
        [param setPObject:@"1" forKey:@"result"];
    }
    else
    {
        [param setPObject:@"0" forKey:@"result"];
    }
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KPublishRepairEvaluate parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"responese ========================= %@",responese);
         [Utility showToastWithMessage:@"评价成功" inView:self];
         [self reQueryListData];
         
     } failure:^(NSString *code, NSString *error) {
         [self doneLoadingTableViewData];
         [Utility showToastWithMessage:error inView:self];
     }];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.baseListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
    /*if (section == 0)
     {
     return 0;
     }
     else
     {
     return 10.0f;
     }*/
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [DView viewFrameX:0 y:0 w:kScreenWidth h:10];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellId";
    HWPublicRepairCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[HWPublicRepairCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
        cell.superV = self;
    }
    HWPublicRepairModel *model = [self.baseListArr pObjectAtIndex:indexPath.section];
    [cell fillDataWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWPublicRepairModel *model = [self.baseListArr pObjectAtIndex:indexPath.section];
    return [HWPublicRepairCell getHeight:model];
}



@end
