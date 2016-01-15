//
//  HWWuYePayRecordView.m
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYePayRecordView.h"

@implementation HWWuYePayRecordView

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
    /*URL:/hw-sq-app-web/wyJF/JfHis.do
     入参：
     key
     出参：
     /交易Id/
     public Long recordId;
     /交易流水号/
     public String payNum;
     /金额/
     public Double charge;
     /创建交易时间/
     public Date payCreateTime;
     /缴费费用类型/
     public String payType;
     
     /物业名字/
     public String WyName;
     
     /有效期 开始/
     public Date sTime;
     /有效期 结束/
     public Date eTime;
     /楼/
     public String building_no;
     /小区名字/
     public String villageName;
     /单元/
     public String unit_no;
     /房号/
     public String room_no;*/
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];//@"3a956781-6179-47af-8af3-d28d4554b87d"
    [param setPObject:@(self.currentPage) forKey:@"page"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KWuYePayRecord parameters:param queue:nil success:^(id responese)
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
         
         NSMutableArray *tmpArr;
         NSString *lastMonthStr;
         for (int i = 0; i < arr.count; i ++)
         {
             HWWuYePayRecordModel *model = [[HWWuYePayRecordModel alloc] initWithDict:[arr pObjectAtIndex:i]];
             if (lastMonthStr == nil)
             {
                 lastMonthStr = [Utility getMonthTimeWithTimestamp:model.payCreateTime];
                 tmpArr = [NSMutableArray array];
                 [tmpArr addObject:model];
             }
             else
             {
                 NSString *currentMonthStr = [Utility getMonthTimeWithTimestamp:model.payCreateTime];
                 if ([lastMonthStr isEqualToString:currentMonthStr])
                 {
                     [tmpArr addObject:model];
                 }
                 else
                 {
                     [self.baseListArr addObject:tmpArr];
                     tmpArr = [NSMutableArray array];
                     [tmpArr addObject:model];
                 }
             }
         }
         if (tmpArr.count != 0)
         {
             [self.baseListArr addObject:tmpArr];
         }
         
         if (self.baseListArr.count == 0)
         {
             [self showEmptyView:@"您还没有缴费记录哦"];
         }
         else
         {
             [self hideEmptyView];
         }
         
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
    
    UILabel *leftLabel = [UILabel newAutoLayoutView];
    [view addSubview:leftLabel];
    [leftLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    leftLabel.textColor = THEME_COLOR_TEXT;
    leftLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    leftLabel.backgroundColor = [UIColor clearColor];
    
    NSArray *sectionArr = [self.baseListArr pObjectAtIndex:section];
    HWWuYePayRecordModel *model = [sectionArr pObjectAtIndex:0];
    leftLabel.text = [Utility getMonthTimeWithTimestamp:model.payCreateTime];
    
    [Utility bottomLine:view];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.baseListArr pObjectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"cell";
    HWWuYePayRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[HWWuYePayRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSArray *sectionArr = [self.baseListArr pObjectAtIndex:indexPath.section];
    HWWuYePayRecordModel *model = [sectionArr pObjectAtIndex:indexPath.row];
    [cell fillDataWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionArr = [self.baseListArr pObjectAtIndex:indexPath.section];
    HWWuYePayRecordModel *model = [sectionArr pObjectAtIndex:indexPath.row];
    
    return [HWWuYePayRecordCell getCellHeight:model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushToDetailVCWithModel:)])
    {
        NSArray *sectionArr = [self.baseListArr pObjectAtIndex:indexPath.section];
        HWWuYePayRecordModel *model = [sectionArr pObjectAtIndex:indexPath.row];
        [self.delegate pushToDetailVCWithModel:model];
    }
}

@end
