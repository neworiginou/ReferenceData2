//
//  HWHistoryRefreshTableView.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWHistoryRefreshTableView.h"


@implementation HWHistoryRefreshTableView
@synthesize delegate;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self queryListData];
    }
    return self;
}

- (void)queryListData
{
//    [Utility showMBProgress:self message:@"加载中..."];
    
    HWUserLogin *user = [HWUserLogin currentUserLogin];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setPObject:user.key forKey:@"key"];
    [dict setPObject:@"1" forKey:@"source"];
    [dict setPObject:@(self.currentPage) forKey:@"page"];
    [dict setPObject:@(kPageCount) forKey:@"size"];
    
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager cutManager];
    
    [manage POST:kActivityHistory parameters:dict queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self];
        
        NSLog(@"%@", responseObject);
        
        NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
        NSArray *contents = [dataDic arrayObjectForKey:@"content"];
        NSMutableArray *array = [NSMutableArray array];
        
        for (int i = 0; i < contents.count; i++)
        {
            HWActivityHistoryModel *historyItem = [[HWActivityHistoryModel alloc] initWithHistoryInfo:[contents objectAtIndex:i]];
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
            [self showEmptyView:@"暂无历史活动"];
        }
        else
        {
            [self hideEmptyView];
        }
        
    }failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self];
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
    HWActivityHistoryModel *model = self.baseListArr[indexPath.row];
    return [HWTreatureHistoryCell getCellHeight:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWTreatureHistoryCell *cell = (HWTreatureHistoryCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[HWTreatureHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setHistoryInfo:self.baseListArr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (delegate && [delegate respondsToSelector:@selector(didSelectHistoryTableItem:)])
    {
        [delegate didSelectHistoryTableItem:self.baseListArr[indexPath.row]];
    }
}



@end
