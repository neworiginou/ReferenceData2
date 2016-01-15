//
//  HWInviteCustomRecordView.m
//  Community
//
//  Created by niedi on 15/6/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWInviteCustomRecordView.h"
#import "HWInviteCustomRecordCell.h"
#import "HWInviteCustomRecordDetailVC.h"

@interface HWInviteCustomRecordView ()
{
    
}
@end

@implementation HWInviteCustomRecordView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self loadUI];
        [self queryListData];
    }
    return self;
}

- (void)queryListData
{
    /*URL:/hw-sq-app-web/visitor/hisVisitor.do
     入参：
     key
     page 分页
     size
     type 类型 0普通访客 - 1长期访客
     出参：
     /访客手机/
     private String visitorMobile ;
     /访问小区/
     private String villageName ;
     /开始日期/
     private String visitorDate ;
     /有效天数/
     private String dateCount;
     /二维码/
     private String zxing;
     /访客名字/
     private String visitorName;
     /访客关系/
     private String relationship;
     /预约来访 – 0没有到访 1有到访/
     private String isVisit;
     /是否过期 — 0显示绿色 1显示灰色/
     private String isPast;
     /是否无效 ---- 0有效邀请 1无效邀请/
     private String isValid;
     /访客表id/
     private Long tvId;
     /按钮状态 ---------0显示 1显示/
     private String buttonStatus;
     /大于6个长期访客 ------ 0显示 1不显示/
     private String SixConunt;*/
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:@(self.currentPage) forKey:@"page"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    [param setPObject:@"0" forKey:@"type"];
    [param setPObject:[HWUserLogin currentUserLogin].villageId forKey:@"villageId"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KInviteCustomHistory parameters:param queue:nil success:^(id responese)
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
             HWInviteCustomRecordModel *model = [[HWInviteCustomRecordModel alloc] initWithDict:[arr pObjectAtIndex:i]];
             [self.baseListArr addObject:model];
         }
         
         if (self.baseListArr.count > 0)
         {
             [self hideEmptyView];
         }
         else
         {
             [self showEmptyView:@"暂无访客记录"];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellID";
    HWInviteCustomRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[HWInviteCustomRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    HWInviteCustomRecordModel *model = [self.baseListArr pObjectAtIndex:indexPath.row];
    [cell fillDataWithModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWInviteCustomRecordModel *model = [self.baseListArr pObjectAtIndex:indexPath.row];
    return [HWInviteCustomRecordCell getCellHeight:model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HWInviteCustomRecordDetailVC *detailVC = [[HWInviteCustomRecordDetailVC alloc] init];
    HWInviteCustomRecordModel *model = [self.baseListArr pObjectAtIndex:indexPath.row];
    detailVC.model = model;
    [self pushViewContrller:detailVC];
}

- (void)pushViewContrller:(HWBaseViewController *)VC
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushViewController:)])
    {
        [self.delegate pushViewController:VC];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deleteCustomCellIndexPath:indexPath];
}

- (void)deleteCustomCellIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未过期的记录删除后，通行证将会失效，确定删除？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1)
        {
            [self deleRowQuery:indexPath];
        }
    }];
}

- (void)deleRowQuery:(NSIndexPath *)indexPath
{
    /*URL:/hw-sq-app-web/visitor/deleteVisitor.do
     入参：
     key
     visitorId 访客信息id
     出参：*/
    
    HWInviteCustomRecordModel *model = [self.baseListArr pObjectAtIndex:indexPath.row];
    
    [Utility showMBProgress:self message:LOADING_TEXT];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:model.tvId forKey:@"visitorId"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KInviteCustomDelete parameters:param queue:nil success:^(id responese)
     {
         [Utility hideMBProgress:self];
         
         [self.baseListArr removeObjectAtIndex:indexPath.row];
         [self.baseTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
         
         [self doneLoadingTableViewData];
     }
          failure:^(NSString *code, NSString *error)
     {
         [Utility hideMBProgress:self];
         [Utility showToastWithMessage:error inView:self];
         [self doneLoadingTableViewData];
     }];
}

@end
