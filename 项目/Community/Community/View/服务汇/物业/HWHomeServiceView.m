//
//  HWHomeServiceView.m
//  Community
//
//  Created by niedi on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWHomeServiceView.h"
#import "HWHomeServiceInfoModel.h"
#import "HWHomeServiceCell.h"

@interface HWHomeServiceView ()
{
    NSString *_serviceId;
    HWHomeServiceInfoModel *_model;
}
@end

@implementation HWHomeServiceView

- (instancetype)initWithFrame:(CGRect)frame serviceId:(NSString *)serviceId
{
    if (self = [super initWithFrame:frame])
    {
        _serviceId = serviceId;
        self.baseTable.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - 45.0f);
        
        [self queryListData];
    }
    return self;
}

- (void)queryListData
{
    /*接口：hw-sq-app-web/comeDoorService/showComeServiceInfo.do 服务查询页
     入参：key：用户key
     serviceId：服务id
     输出参数：
     {
     "status": "1",
     "data": {
     "id": 1,
     "proprietorId": null,
     "serviceConfigId": 1,
     "serviceDescribe": "上门家电清洗，随叫随到，电话:18717969610",服务描述
     "serviceBrief": "上门家电清洗",服务简介
     "propertyAttachmentDTOList": [附加项
     { "id": 1, "name": "附加商品列表",附加商品名称 "price": 100,价格 "unit": "个",单位 }
     
     ],
     "propertyServicePriceDTOList": [
     { "id": 1, "name": "上门服务",服务名称 "price": 100,价格 "priceUnit": "瓶"单位 }
     
     ]
     },
     "detail": "请求数据成功!",
     "key": "3a956781-6179-47af-8af3-d28d4554b87d"
     }*/
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:_serviceId forKey:@"serviceId"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KHomeServiceInfo parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"responese ========================= %@",responese);
         isLastPage = YES;
         
         NSDictionary *dict = [responese dictionaryObjectForKey:@"data"];
         
         _model = [[HWHomeServiceInfoModel alloc] initWithDict:dict];
         [self.baseListArr addObject:_model];
         
         [self loadUI];
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
    
    CGFloat headerHi = [Utility calculateStringHeight:_model.serviceBrief font:[UIFont fontWithName:FONTNAME size:TF15] constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, kScreenWidth - 2 * 15)].height;
    DLable *headerLab = [DLable LabTxt:_model.serviceBrief txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:15 y:10 w:kScreenWidth - 2 * 15 h:headerHi];
    [tableHeaderV addSubview:headerLab];
    
    DImageV *line = [DImageV imagV:@"" frameX:0 y:9.5f + CGRectGetMaxY(headerLab.frame) w:kScreenWidth h:0.5f];
    line.backgroundColor = THEME_COLOR_LINE;
    [tableHeaderV addSubview:line];
    
    tableHeaderV.height = CGRectGetMaxY(line.frame);
    self.baseTable.tableHeaderView = tableHeaderV;
    
    
    DView *tableFooterV = [DView viewFrameX:0 y:0 w:kScreenWidth h:10.0f];
    tableFooterV.backgroundColor = [UIColor whiteColor];
    
    CGFloat footerHi = [Utility calculateStringHeight:_model.serviceDescribe font:[UIFont fontWithName:FONTNAME size:TF15] constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
    DLable *footerLab = [DLable LabTxt:_model.serviceDescribe txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:15 y:10 w:kScreenWidth - 2 * 15 h:footerHi];
    [tableFooterV addSubview:footerLab];
    
    DImageV *footerLine = [DImageV imagV:@"" frameX:0 y:14.5f + CGRectGetMaxY(footerLab.frame) w:kScreenWidth h:0.5f];
    footerLine.backgroundColor = THEME_COLOR_LINE;
    [tableFooterV addSubview:footerLine];
    
    tableFooterV.height = CGRectGetMaxY(footerLine.frame);
    self.baseTable.tableFooterView = tableFooterV;
    
    DButton *commitRepairBtn = [DButton btnTxt:@"预约下单" txtFont:TF18 frameX:0 y:CONTENT_HEIGHT - 45.0f w:kScreenWidth h:45.0f target:self action:@selector(commitRepairBtnClick)];
    [commitRepairBtn setStyle:DBtnStyleMain];
    [self addSubview:commitRepairBtn];
}

- (void)commitRepairBtnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bookingOrderBtnClick)])
    {
        [self.delegate bookingOrderBtnClick];
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_model.serviceDescribe.length == 0)
    {
        return 2;
    }
    else
    {
        return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return _model.serviceItemArr.count + 1;
    }
    else if (section == 1)
    {
        return _model.additionalServiceItemArr.count + 1;
    }
    else if (section == 2)
    {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 10.0f;
    }
    else if (section == 1)
    {
        return 10.0f;
    }
    else if (section == 2)
    {
        return 0.0f;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    DImageV *sectionView = [DImageV imagV:@"" frameX:0 y:0 w:kScreenWidth h:10.0f];
    sectionView.backgroundColor = [UIColor clearColor];
    
    DImageV *line = [DImageV imagV:@"" frameX:0 y:9.5f w:kScreenWidth h:0.5f];
    line.backgroundColor = THEME_COLOR_LINE;
    [sectionView addSubview:line];
    
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"cellId";
    HWHomeServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
    {
        cell = [[HWHomeServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0)
    {
        if (row == 0)
        {
            [cell fillDataWithLeftStr:@"主服务项" rightStr:nil];
        }
        else
        {
            NSDictionary *tmpDict = [_model.serviceItemArr pObjectAtIndex:indexPath.row - 1];
            NSString *leftStr = [tmpDict stringObjectForKey:@"leftStr"];
            NSString *rightStr = [tmpDict stringObjectForKey:@"rightStr"];
            [cell fillDataWithLeftStr:leftStr rightStr:rightStr];
            
            if (_model.serviceItemArr.count > 1)
            {
                if (row == _model.serviceItemArr.count)
                {
                    [cell setLeftGap:NO];
                }
                else
                {
                    [cell setLeftGap:YES];
                }
            }
        }
    }
    else if (section == 1)
    {
        if (row == 0)
        {
            [cell fillDataWithLeftStr:@"附加项" rightStr:nil];
        }
        else
        {
            NSDictionary *tmpDict = [_model.additionalServiceItemArr pObjectAtIndex:indexPath.row - 1];
            NSString *leftStr = [tmpDict stringObjectForKey:@"leftStr"];
            NSString *rightStr = [tmpDict stringObjectForKey:@"rightStr"];
            [cell fillDataWithLeftStr:leftStr rightStr:rightStr];
            
            if (_model.additionalServiceItemArr.count > 1)
            {
                if (row == _model.additionalServiceItemArr.count)
                {
                    [cell setLeftGap:NO];
                }
                else
                {
                    [cell setLeftGap:YES];
                }
            }
        }
    }
    else if (section == 2)
    {
        [cell fillDataWithLeftStr:@"服务说明" rightStr:nil];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0)
    {
        if (row == 0)
        {
            return 45.0f;
        }
        else
        {
            NSDictionary *tmpDict = [_model.serviceItemArr pObjectAtIndex:indexPath.row - 1];
            NSString *leftStr = [tmpDict stringObjectForKey:@"leftStr"];
            return [HWHomeServiceCell getCellHeight:leftStr];
        }
    }
    else if (section == 1)
    {
        if (row == 0)
        {
            return 45.0f;
        }
        else
        {
            NSDictionary *tmpDict = [_model.additionalServiceItemArr pObjectAtIndex:indexPath.row - 1];
            NSString *leftStr = [tmpDict stringObjectForKey:@"leftStr"];
            return [HWHomeServiceCell getCellHeight:leftStr];
        }
    }
    else if (section == 2)
    {
        return 45.0f;
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
