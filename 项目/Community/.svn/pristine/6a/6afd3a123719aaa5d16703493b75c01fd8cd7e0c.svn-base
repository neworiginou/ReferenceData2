//
//  HWMyPriviledgeVC.m
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "HWMyPriviledgeVC.h"
#import "HWPriviledgeDetailVC.h"
#import "HWMyPriviledgeTableViewCell.h"
#import "HWMyPriviledgeDetailVC.h"
#import "HWMyPriviledgeModel.h"
#import "HWCoreDataManager.h"
@interface HWMyPriviledgeVC ()

@end

@implementation HWMyPriviledgeVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.isNeedHeadRefresh = YES;
    self.navigationItem.titleView = [Utility navTitleView:@"我的优惠券"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.dataList = (NSMutableArray *)[HWCoreDataManager searchAllPriviledgeListItem];
    [self queryListData];

    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    baseTableView.tableHeaderView = view;

}

- (void)queryListData
{
    [Utility hideMBProgress:self.view];
    [Utility showMBProgress:self.view message:@"请求数据"];
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.key forKey:@"key"];
    [dict setPObject:user.userId forKey:@"userId"];
    [dict setPObject:[NSString stringWithFormat:@"%d",_currentPage] forKey:@"page"];
    [dict setPObject:[NSString stringWithFormat:@"%d",kPageCount] forKey:@"size"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [self hideNewEmpty];
    [manager POST:kMinePriviledgeList parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
        
        NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
        NSArray *contents = [dataDic arrayObjectForKey:@"content"];
        NSMutableArray *array = [NSMutableArray array];
        
        for (int i = 0; i < contents.count; i++)
        {
            HWMyPriviledgeModel *shareItem = [[HWMyPriviledgeModel alloc]initWithDic:[contents objectAtIndex:i]];
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
        
        if (_currentPage == 0)
        {
            dataList = [NSMutableArray arrayWithArray:array];
            //保存数据库
            if (self.dataList != 0)
            {
                [HWCoreDataManager removeAllPriviledgeListItem];
                [HWCoreDataManager addPriviledgeListItem:self.dataList];
            }
        }
        else
        {
            [self.dataList addObjectsFromArray:array];
        }
        [baseTableView reloadData];
        
        if(self.dataList.count == 0)
        {
            [self showNewEmpty:@"暂无优惠券"];
        }else{
            [self hideNewEmpty];
        }
        
        [self doneLoadingTableViewData];
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        [self doneLoadingTableViewData];
        NSLog(@"houselist error hwhttprequest:%@",error);
        if (self.dataList.count == 0)
        {
            [self showNewEmpty:@"暂无优惠券"];
        }else{
            [self hideNewEmpty];
        }
        
    }];

}
//-(void)createTestData
//{
//    HWMyPriviledgeModel *myPriviledgeModel = [[HWMyPriviledgeModel alloc]init];
//    myPriviledgeModel.priviledgeImageUrl = @"";
//    myPriviledgeModel.priviledgeStatus = @"已过期";
//    myPriviledgeModel.priviledgeNumStr = @"KL682389173H";
//    
//    
//    HWMyPriviledgeModel *myPriviledgeOneModel = [[HWMyPriviledgeModel alloc]init];
//    myPriviledgeOneModel.priviledgeImageUrl = @"";
//    myPriviledgeOneModel.priviledgeStatus = @"";
//    myPriviledgeOneModel.priviledgeNumStr = @"KL782389173H";
//    
//    HWMyPriviledgeModel *myPriviledgeTwoModel = [[HWMyPriviledgeModel alloc]init];
//    myPriviledgeTwoModel.priviledgeImageUrl = @"";
//    myPriviledgeTwoModel.priviledgeStatus = @"";
//    myPriviledgeTwoModel.priviledgeNumStr = @"KL882389173H";
//    
//    HWMyPriviledgeModel *myPriviledgeThreeModel = [[HWMyPriviledgeModel alloc]init];
//    myPriviledgeThreeModel.priviledgeImageUrl = @"";
//    myPriviledgeThreeModel.priviledgeStatus = @"";
//    myPriviledgeThreeModel.priviledgeNumStr = @"KL982389173H";
//    
//    
//    
//    HWMyPriviledgeModel *myPriviledgeFourModel = [[HWMyPriviledgeModel alloc]init];
//    myPriviledgeFourModel.priviledgeImageUrl = @"";
//    myPriviledgeFourModel.priviledgeStatus = @"已过期";
//    myPriviledgeFourModel.priviledgeNumStr = @"KL482389173H";
//    
//    
//    
//    [_listData addObject:myPriviledgeModel];
//    [_listData addObject:myPriviledgeOneModel];
//    [_listData addObject:myPriviledgeTwoModel];
//    [_listData addObject:myPriviledgeThreeModel];
//    [_listData addObject:myPriviledgeFourModel];
//}

#pragma - mark TableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PriviledgeIdentifier";
    HWMyPriviledgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[HWMyPriviledgeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = BACKGROUND_COLOR;
    int row = (int)indexPath.row;
    HWMyPriviledgeModel *myPriviledgeModel = [dataList objectAtIndex:row];
    [cell setMyPriviledge:myPriviledgeModel];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MobClick event:@"click_youhuiquan"];
    [MobClick event:@"click_youhuiquanxiangqing"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HWMyPriviledgeDetailVC *priviledgeDetailVC = [[HWMyPriviledgeDetailVC alloc]init];
     HWMyPriviledgeModel *myPriviledgeModel = [dataList objectAtIndex:indexPath.row];
    priviledgeDetailVC.priviledgeId = myPriviledgeModel.priviledgeIdStr;
    priviledgeDetailVC.priviledgeNum = myPriviledgeModel.priviledgeNumStr;
    [self.navigationController pushViewController:priviledgeDetailVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 191.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataList count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
@end
