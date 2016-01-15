//
//  HWJoinedRefreshView.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWJoinedRefreshView.h"

@implementation HWJoinedRefreshView

@synthesize delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self queryListData];
    }
    return self;
}

- (void)queryListData
{
    
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager cutManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:user.key forKey:@"key"];
    [param setPObject:@"1" forKey:@"source"];
    [param setPObject:@(self.currentPage) forKey:@"page"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    
    [manage POST:kJoinedList parameters:param queue:nil success:^(id responseObject) {
        
        NSLog(@"%@", responseObject);
        
        NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
        NSArray *contents = [dataDic arrayObjectForKey:@"content"];
        NSMutableArray *array = [NSMutableArray array];
        
        for (int i = 0; i < contents.count; i++)
        {
            HWJoinedActivityModel *historyItem = [[HWJoinedActivityModel alloc] initWithJoinedActivity:[contents objectAtIndex:i]];
            [array addObject:historyItem];
        }
        
        if(array.count < kPageCount)
        {
            isLastPage = YES;
        }
        else
        {
            isLastPage = NO;
        }
        
        if (self.currentPage == 0)
        {
            self.baseListArr = [NSMutableArray arrayWithArray:array];
            //保存数据库
            //            if (self.historyList != 0)
            //            {
            //                [HWCoreDataManager removeAllShareItem];
            //                [HWCoreDataManager addShareItem:self.dataList];
            //            }
        }
        else
        {
            [self.baseListArr addObjectsFromArray:array];
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
        
    }failure:^(NSString *code, NSString *error) {
        
        [Utility showToastWithMessage:error inView:self];
    }];
    
}

#pragma mark - tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HWTreasureJoinedCell getCellHeight:nil];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWTreasureJoinedCell *cell = (HWTreasureJoinedCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[HWTreasureJoinedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell setJoinedInfo:[self.baseListArr objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [MobClick event:@"click_my history details"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (delegate && [delegate respondsToSelector:@selector(didSelectJoinedTableItem:)])
    {
        [delegate didSelectJoinedTableItem:self.baseListArr[indexPath.row]];
    }
    
}

@end
