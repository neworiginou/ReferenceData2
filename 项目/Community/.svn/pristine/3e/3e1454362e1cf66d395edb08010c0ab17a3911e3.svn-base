//
//  HWWuYePayRecordDetailView.m
//  Community
//
//  Created by niedi on 15/6/26.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYePayRecordDetailView.h"
#import "HWWuYePayRecordDetailCell.h"

@interface HWWuYePayRecordDetailView ()
{
    HWWuYePayRecordModel *_model;
}
@end

@implementation HWWuYePayRecordDetailView

- (instancetype)initWithFrame:(CGRect)frame model:(HWWuYePayRecordModel *)model
{
    if (self = [super initWithFrame:frame])
    {
        _model = model;
        [self loadUI];
    }
    return self;
}

- (void)queryListData
{
    isLastPage = YES;
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.2];
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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    NSString *cellId = @"cellId";
    HWWuYePayRecordDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
    {
        cell = [[HWWuYePayRecordDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if (row == 0)
    {
        [cell fillDataWithLeftStr:@"交易类型" rightStr:@"物业费"];
    }
    else if (row == 1)
    {
        NSString *title = [NSString stringWithFormat:@"%@至%@", [Utility getTimeWithTimestamp:_model.sTime], [Utility getTimeWithTimestamp:_model.eTime]];
        [cell fillDataWithLeftStr:@"缴费周期" rightStr:title];
    }
    else if (row == 2)
    {
        NSString *titleStr;
        if (_model.unit_no.length != 0)
        {
            titleStr = [NSString stringWithFormat:@"%@%@号楼%@单元%@室", _model.villageName, _model.building_no, _model.unit_no, _model.room_no];
        }
        else
        {
            titleStr = [NSString stringWithFormat:@"%@%@号楼%@室", _model.villageName, _model.building_no, _model.room_no];
        }

        [cell fillDataWithLeftStr:@"住房信息" rightStr:titleStr];
    }
    else if (row == 3)
    {
        [cell fillDataWithLeftStr:@"缴费金额" rightStr:[NSString stringWithFormat:@"%@元", _model.charge]];
    }
    else if (row == 4)
    {
        [cell fillDataWithLeftStr:@"收款账户" rightStr:_model.WyName];
    }
    else if (row == 5)
    {
        [cell fillDataWithLeftStr:@"缴费时间" rightStr:[Utility getMinTimeWithTimestamp:_model.payCreateTime]];
    }
    else if (row == 6)
    {
        [cell fillDataWithLeftStr:@"交易号" rightStr:_model.recordId];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HWWuYePayRecordDetailCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
