//
//  HWPerpotyComplaintView.m
//  Community
//
//  Created by niedi on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWPerpotyComplaintView.h"
#import "HWPublicRepairCell.h"
#import "HWAlertComplainView.h"
#import "HWAlertComplainAgainView.h"
#import "HWPerpotyComplaintCell.h"

@interface HWPerpotyComplaintView ()<HWPublicRepairCellDelegate, HWAlertComplainViewDelegate, HWPerpotyComplaintCellDelegate, HWAlertComplainAgainViewDelegate>
{
    BOOL isCanReComplain;
    NSString *_cardEavluateId;
}
@end

@implementation HWPerpotyComplaintView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        isCanReComplain = YES;
        
        self.baseTable.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - 45.0f) ;
//        [self loadUI];
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
    /*
     接口：hw-sq-app-web/complaint/complaintList.do 投诉列表
     入参：key：用户key
     page：页码
     size：每页数量
     {
     "status": "1",
     "data": {
     "content": [
     {
     "id": 1,投诉id
     "proprietorId": 1,投诉人id
     "content": "1111",投入内容
     "status": 1,当前状态(0待处理,1处理中,2处理完毕)
     "parentId": 0,关联投诉id
     "comment": null,
     "result": null,
     "villageId": 12797,小区id
     "creater": null,创建人id
     "createTime": 1434077784000,
     "modifier": null,
     "disabled": null,
     "createTimeStr": "3小时前",创建时间
     "spendTimeStr": "耗时：23小时0分钟",处理耗时
     "image": null,
     "modifyTime": 1434160625000,
     "images": null,图片key
     "sonList": [子投诉
     { "id": 5, "proprietorId": 3, "content": "5555", "status": 1, "parentId": 1, "comment": null, "result": null, "villageId": 12797, "creater": null, "createTime": 1435373804000, "modifier": null, "disabled": null, "createTimeStr": "2015-06-27", "spendTimeStr": null, "image": null, "modifyTime": null, "images": null, "sonList": [ ] }
     
     ,
     { "id": 3, "proprietorId": 2, "content": "333", "status": 1, "parentId": 1, "comment": null, "result": null, "villageId": 12797, "creater": null, "createTime": 1433300192000, "modifier": null, "disabled": null, "createTimeStr": "9天前", "spendTimeStr": null, "image": null, "modifyTime": null, "images": null, "sonList": [ ] }
     
     ]
     },
     ],
     "size": 10,
     "number": 0,
     "totalElements": 4,
     "lastPage": true,
     "firstPage": true,
     "sort": null,
     "totalPages": 1,
     "numberOfElements": 2
     },
     "detail": "请求数据成功!",
     "key": "788f4790-b3af-48ff-8e42-f60e30a5714e"
     }
     */
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:@(self.currentPage) forKey:@"page"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KPerpotyComplaintList parameters:param queue:nil success:^(id responese)
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
             HWPropertyComplainModel *model = [[HWPropertyComplainModel alloc] initWithDict:[arr pObjectAtIndex:i]];
             [self.baseListArr addObject:model];
         }
         
         if (self.baseListArr.count > 0)
         {
             [self hideEmptyView];
         }
         else
         {
             [self showEmptyView:@"暂无投诉记录"];
         }
         
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
     } failure:^(NSString *code, NSString *error) {
         [self doneLoadingTableViewData];
         [Utility showToastWithMessage:error inView:self];
     }];
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

#pragma mark - HWPerpotyComplaintCellDelegate
- (void)foldBtnClickIndexPath:(NSIndexPath *)indexPath
{
    HWPropertyComplainModel *model = [self.baseListArr pObjectAtIndex:indexPath.section];
    model.isFold = NO;
    [self.baseTable reloadData];
}

- (void)evaluateBtnClick:(NSString *)modelId isCanReComplain:(BOOL)isCan
{
    isCanReComplain = isCan;
    _cardEavluateId = modelId;
    HWAlertComplainView *alert = [[HWAlertComplainView alloc] init];
    alert.delegate = self;
    [alert show];
}

#pragma mark - HWAlertComplainViewDelegate
- (void)evaluateBtnClickResult:(BOOL)isSatisfy
{
    /*接口：hw-sq-app-web/complaint/addComplaintResult.do 投诉评论接口
     入参：key：用户key，id：投诉id，result：结果(0,不满意,1满意)
     出参：
     { 'status': '1', 'data': '', 'detail': '请求数据成功!', 'key': '3e801f50-10d8-44d7-9ce7-83e57fe582f1' }  */
    
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
    [manager POST:KPerpotyComplaintEvaluate parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"responese ========================= %@",responese);
         [Utility showToastWithMessage:@"评价成功" inView:self];
         [self reQueryListData];
         if (!isSatisfy && isCanReComplain)
         {
             HWAlertComplainAgainView *alert = [[HWAlertComplainAgainView alloc] init];
             alert.delegate = self;
             [alert show];
         }
         
         isCanReComplain = YES;
         
     } failure:^(NSString *code, NSString *error) {
         
         [Utility showToastWithMessage:error inView:self];
     }];
}

#pragma mark - HWAlertComplainAgainViewDelegate
- (void)didClickComplainBtn:(NSString *)content
{
    if (content.length == 0)
    {
        [Utility showToastWithMessage:@"投诉内容不能为空" inView:self];
        return;
    }
    
    /*接口：hw-sq-app-web/complaint/complaintAgain.do 再次投诉接口
     入参：key：用户key，id：之前投诉id，content：内容
     出参：
     { 'status': '1', 'data': '', 'detail': '请求数据成功!', 'key': '3e801f50-10d8-44d7-9ce7-83e57fe582f1' } */
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:_cardEavluateId forKey:@"id"];
    [param setPObject:content forKey:@"content"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KPerpotyComplaintAgain parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"responese ========================= %@",responese);
         [Utility showToastWithMessage:@"再次投诉成功" inView:self];
         [self reQueryListData];
         
     } failure:^(NSString *code, NSString *error) {
         
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
    HWPropertyComplainModel *model = [self.baseListArr pObjectAtIndex:indexPath.section];
    if (model.sonList.count == 0)
    {
        NSString *cellID = @"cellId";
        HWPublicRepairCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil)
        {
            cell = [[HWPublicRepairCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.delegate = self;
            cell.superV = self;
        }
        HWPropertyComplainModel *model = [self.baseListArr pObjectAtIndex:indexPath.section];
        [cell fillDataWithModelForComplain:model];
        return cell;
    }
    else
    {
        NSString *cellID = @"cellId1";
        HWPerpotyComplaintCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil)
        {
            cell = [[HWPerpotyComplaintCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.delegate = self;
        }
        HWPropertyComplainModel *model = [self.baseListArr pObjectAtIndex:indexPath.section];
        [cell fillDataWithModel:model indexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWPropertyComplainModel *model = [self.baseListArr pObjectAtIndex:indexPath.section];
    if (model.sonList.count == 0)
    {
        return [HWPublicRepairCell getHeightForComplain:model];
    }
    else
    {
        return [HWPerpotyComplaintCell getHeight:model];
    }
}

@end
