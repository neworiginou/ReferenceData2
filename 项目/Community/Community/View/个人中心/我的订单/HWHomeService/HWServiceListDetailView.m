//
//  HWServiceListDetailView.m
//  Community
//
//  Created by hw500027 on 15/6/18.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWServiceListDetailView.h"
#import "HWServiceListDetailTitleCell.h"
#import "HWServiceListDetailNormalInfoCell.h"
#import "HWServiceListDetailStatusCell.h"
#import "HWServiceListDetailServicorCell.h"
#import "HWServiceListDetailModel.h"
#import "HWPayConfirmVC.h"

@interface HWServiceListDetailView() <HWServiceListDetailServicorCellDelegate>
{
    NSInteger _type;
    NSString *_orderID;
    NSMutableArray *_dataArray;
    NSMutableArray *_servePersonVoArray;
    NSMutableArray *_listStatusArray;
    UIWebView *_callPhoneWebView;
    BOOL _hasComment;
}
@end

@implementation HWServiceListDetailView

- (instancetype)initWithFrame:(CGRect)frame withOrderID:(NSString *)orderID
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _orderID = orderID;
        
        _listStatusArray = [[NSMutableArray alloc] init];
        [self queryListData];
        [self.baseTable registerClass:[HWServiceListDetailTitleCell self] forCellReuseIdentifier:[HWServiceListDetailTitleCell reuseID]];
        [self.baseTable registerClass:[HWServiceListDetailNormalInfoCell self] forCellReuseIdentifier:[HWServiceListDetailNormalInfoCell reuseID]];
        [self.baseTable registerClass:[UITableViewCell self] forCellReuseIdentifier:@"infoCell"];
        [self.baseTable registerClass:[HWServiceListDetailStatusCell self] forCellReuseIdentifier:[HWServiceListDetailStatusCell reuseID]];
        [self.baseTable registerClass:[HWServiceListDetailServicorCell self] forCellReuseIdentifier:[HWServiceListDetailServicorCell reuseID]];
        
    }
    return self;
}

- (void)queryListData
{
    isLastPage = YES;
    [Utility hideMBProgress:self];
    [Utility showMBProgress:self message:@"请求数据"];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setPObject:_orderID forKey:@"orderId"];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kServiceListDetail parameters:param queue:nil success:^(id responese)
    {
        if (self.currentPage == 0)
        {
            [_listStatusArray removeAllObjects];
            [self.baseListArr removeAllObjects];
        }
        
        [Utility hideMBProgress:self];        
        HWServiceListDetailModel *model = [[HWServiceListDetailModel alloc] initWithDic:[responese dictionaryObjectForKey:@"data"]];
        [self.baseListArr addObject:model];
        
        _type = [model.status integerValue];//(0未处理、1已拒单、2等待接单、3已接单、4等待支付 5处理完毕、已取消）
        
        if (_type == 0 || _type == 1 || _type == 2)
        {
            if (_delegate && [_delegate respondsToSelector:@selector(showRightBarButtonItem:)])
            {
                [_delegate showRightBarButtonItem:YES];
            }
        }
        else
        {
            if (_delegate && [_delegate respondsToSelector:@selector(showRightBarButtonItem:)])
            {
                [_delegate showRightBarButtonItem:NO];
            }
        }
        
        for (NSDictionary *dic in model.statusList)
        {
            [_listStatusArray addObject:dic];
        }
        [self.baseTable reloadData];
        [self doneLoadingTableViewData];
        
        //底部按钮
        [self addBottomBtn];
    } failure:^(NSString *code, NSString *error)
    {
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
        [self doneLoadingTableViewData];
    }];
}

//去评价
- (void)toComment
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickBtnToCommentVC:)])
    {
        HWServiceEvaluateVC *vc = [[HWServiceEvaluateVC alloc] init];
        vc.hasComment = _hasComment;
        vc.currentOrderId = [[self.baseListArr pObjectAtIndex:0] orderId];
        if (self.pushType == pushHomeServiceDetailTypeList)
        {
            vc.pushType = pushEvaluateTypeDetail;
            [_delegate didClickBtnToCommentVC:vc];
        }
        else if (self.pushType == pushHomeServiceDetailTypeWY)
        {
            if (_hasComment == YES)
            {
                vc.pushType = pushEvaluateTypeWYPayCheckEvlaute;
            }
            else
            {
                vc.pushType = pushEvaluateTypeDetail;
            }
            [_delegate didClickBtnToCommentVC:vc];
        }
    }
}

//去支付
- (void)toPay
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickBtnToCommentVC:)])
    {
        HWPayConfirmVC *vc = [[HWPayConfirmVC alloc] init];
        vc.model = [self.baseListArr pObjectAtIndex:0];
        
        if (self.pushType == pushHomeServiceDetailTypeList)
        {
            vc.type = HWPayConfirmTypeHomeServiceForDetail;
        }
        else if (self.pushType == pushHomeServiceDetailTypeWY)
        {
            vc.type = HWPayConfirmTypeHomeServiceForWy;
        }
        [_delegate didClickBtnToCommentVC:vc];
    }
}

- (void)addBottomBtn
{
    if (_type == 0 || _type == 1 || _type == 2 || _type == 6)
    {
        return;
    }
    else
    {
        self.baseTable.frame = CGRectMake(self.baseTable.frame.origin.x, self.baseTable.frame.origin.y, self.baseTable.frame.size.width, CONTENT_HEIGHT - 45);
        
        UIButton *btn = [UIButton newAutoLayoutView];
        [self addSubview:btn];
        CGSize btnSize = CGSizeMake(kScreenWidth, 45);
        [btn autoSetDimensionsToSize:btnSize];
        [btn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:0];
        [btn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:0];
        [btn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_NORMAL andSize:btnSize] forState:UIControlStateNormal];
        [btn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_HIGHLIGHT andSize:btnSize] forState:UIControlStateHighlighted];
        
        if (_type == 3)
        {
            [btn setTitle:@"支付" forState:UIControlStateNormal];
            btn.userInteractionEnabled = NO;
            [btn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GRAY_NORMAL andSize:btnSize] forState:UIControlStateNormal];
        }
        else if (_type == 4)
        {
            NSString *price = [[self.baseListArr pObjectAtIndex:0]charge];
            [btn setTitle:[NSString stringWithFormat:@"总价￥%@    支付",price] forState:UIControlStateNormal];
            [btn removeTarget:self action:@selector(toComment) forControlEvents:UIControlEventTouchUpInside];
            [btn addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (_type == 5)
        {
            _hasComment = NO;
            [btn setTitle:@"评价" forState:UIControlStateNormal];
            [btn removeTarget:self action:@selector(toComment) forControlEvents:UIControlEventTouchUpInside];
            [btn addTarget:self action:@selector(toComment) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            _hasComment = YES;
            [btn setTitle:@"已评价" forState:UIControlStateNormal];
            [btn removeTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
            [btn addTarget:self action:@selector(toComment) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

#pragma mark --celldelegate

- (void)didClickCallPhoneBtn:(NSString *)phone
{
    if (_callPhoneWebView == nil)
    {
        _callPhoneWebView = [[UIWebView alloc] init];
        [self addSubview:_callPhoneWebView];
    }
    [_callPhoneWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phone]]]];
}

#pragma mark --tableviewdelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //_type (0未处理、1已拒单、2等待接单、3已接单、4等待支付 5处理完毕、已取消）
    if (_type != 3 && _type != 4)
    {
        if (indexPath.section == 0)
        {
            HWServiceListDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:[HWServiceListDetailTitleCell reuseID]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell fillDataWithType:_type withModel:[self.baseListArr pObjectAtIndex:0]];
            return cell;
        }
        else if (indexPath.section == 1)
        {
            if (indexPath.row == 0)
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.text = @"业主信息";
                
                [Utility topLine:cell];
                
                UIView *bottomLine = [UIView newAutoLayoutView];
                [cell.contentView addSubview:bottomLine];
                [bottomLine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, 0) excludingEdge:ALEdgeTop];
                [bottomLine autoSetDimension:ALDimensionHeight toSize:0.5f];
                bottomLine.backgroundColor = THEME_COLOR_LINE;
                return cell;
            }
            else
            {
                HWServiceListDetailNormalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[HWServiceListDetailNormalInfoCell reuseID]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell fillDataWithModel:[self.baseListArr pObjectAtIndex:0]];
                [Utility bottomLine:cell.contentView];

                return cell;
            }
        }
        else
        {
            if (indexPath.row == 0)
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.text = @"订单状态";
                
                UIView *bottomLine = [UIView newAutoLayoutView];
                [cell.contentView addSubview:bottomLine];
                [bottomLine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, 0) excludingEdge:ALEdgeTop];
                [bottomLine autoSetDimension:ALDimensionHeight toSize:0.5f];
                bottomLine.backgroundColor = THEME_COLOR_LINE;
                return cell;
            }
            else
            {
                HWServiceListDetailStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:[HWServiceListDetailStatusCell reuseID]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell fillDataWithDict:[_listStatusArray pObjectAtIndex:indexPath.row - 1]];
                if (indexPath.row == 1)
                {
                    //第一个列表 改变样式
                    [cell changeSetting];
                }
                else
                {
                    [cell unChangeSetting];
                }
                
                if (indexPath.row == _listStatusArray.count)
                {
                    [cell changeBottomLine];
                }
                else
                {
                    [cell normalBottomLine];
                }
                return cell;
            }
        }
    }
    else
    {
        if (indexPath.section == 0)
        {
            HWServiceListDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:[HWServiceListDetailTitleCell reuseID]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell fillDataWithType:_type withModel:[self.baseListArr pObjectAtIndex:0]];
            return cell;
        }
        else if (indexPath.section == 1)
        {
            if (indexPath.row == 0)
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.text = @"服务人员";
                [Utility topLine:cell];
                UIView *bottomLine = [UIView newAutoLayoutView];
                [cell.contentView addSubview:bottomLine];
                [bottomLine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, 0) excludingEdge:ALEdgeTop];
                [bottomLine autoSetDimension:ALDimensionHeight toSize:0.5f];
                bottomLine.backgroundColor = THEME_COLOR_LINE;
                return cell;
            }
            else
            {
                HWServiceListDetailServicorCell *cell = [tableView dequeueReusableCellWithIdentifier:[HWServiceListDetailServicorCell reuseID]];
                cell.cellDelegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell fillDataWithModel:[self.baseListArr pObjectAtIndex:0]];
                [Utility bottomLine:cell.contentView];
                return cell;
            }
        }
        else if (indexPath.section == 2)
        {
            
            if (indexPath.row == 0)
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.text = @"业主信息";
                [Utility topLine:cell];
                
                UIView *bottomLine = [UIView newAutoLayoutView];
                [cell.contentView addSubview:bottomLine];
                [bottomLine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, 0) excludingEdge:ALEdgeTop];
                [bottomLine autoSetDimension:ALDimensionHeight toSize:0.5f];
                bottomLine.backgroundColor = THEME_COLOR_LINE;
                return cell;
            }
            else
            {
                HWServiceListDetailNormalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[HWServiceListDetailNormalInfoCell reuseID]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell fillDataWithModel:[self.baseListArr pObjectAtIndex:0]];
                [Utility bottomLine:cell.contentView];
                return cell;
            }
        }
        else
        {
            if (indexPath.row == 0)
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.text = @"订单状态";
                
                UIView *bottomLine = [UIView newAutoLayoutView];
                [cell.contentView addSubview:bottomLine];
                [bottomLine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, 0) excludingEdge:ALEdgeTop];
                [bottomLine autoSetDimension:ALDimensionHeight toSize:0.5f];
                bottomLine.backgroundColor = THEME_COLOR_LINE;
                return cell;
            }
            else
            {
                HWServiceListDetailStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:[HWServiceListDetailStatusCell reuseID]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell fillDataWithDict:[_listStatusArray pObjectAtIndex:indexPath.row - 1]];
                if (indexPath.row == 1)
                {
                    //第一个列表 改变样式
                    [cell changeSetting];
                }
                else
                {
                    [cell unChangeSetting];
                }
                if (indexPath.row == _listStatusArray.count)
                {
                    [cell changeBottomLine];
                }
                else
                {
                    [cell normalBottomLine];
                }
                return cell;
            }
        }

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ((_type == 0 || _type == 1 || _type == 2 || _type == 6) && section == 2)
    {
        return 0;
    }
    else if ((_type == 3 || _type == 4) && section == 3)
    {
        return 0;
    }
    else if ((_type == 5 || _type == 7) && section == 2)
    {
        return 0;
    }
    else
    {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type != 3 && _type != 4)
    {
        if (indexPath.section == 0)
        {
            return 170 / 2;
        }
        else if (indexPath.section == 1)
        {
            if (indexPath.row == 0)
            {
                return 40;
            }
            else
            {
                return 65;
            }
        }
        else
        {
            if (indexPath.row == 0)
            {
                return 40;
            }
            else
            {
                HWServiceListDetailStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:[HWServiceListDetailStatusCell reuseID]];
                [cell fillDataWithDict:[_listStatusArray pObjectAtIndex:indexPath.row - 1]];
                if (indexPath.row == 1)
                {
                    //第一个列表 改变样式
                    [cell changeSetting];
                }
                else
                {
                    [cell unChangeSetting];
                }
                CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
                height += 1;
                return height;
            }
        }
    }
    else
    {
        if (indexPath.section == 0)
        {
            return 170 / 2;
        }
        else if (indexPath.section == 1)
        {
            if (indexPath.row == 0)
            {
                return 40;
            }
            else
            {
                return 55;
            }
        }
        else if (indexPath.section == 2)
        {
            if (indexPath.row == 0)
            {
                return 40;
            }
            else
            {
                return 65;
            }
        }
        else
        {
            if (indexPath.row == 0)
            {
                return 40;
            }
            else
            {
                HWServiceListDetailStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:[HWServiceListDetailStatusCell reuseID]];
                [cell fillDataWithDict:[_listStatusArray pObjectAtIndex:indexPath.row - 1]];
                if (indexPath.row == 1)
                {
                    //第一个列表 改变样式
                    [cell changeSetting];
                }
                else
                {
                    [cell unChangeSetting];
                }
                CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
                height += 1;
                return height;
            }
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_type != 3 && _type != 4)
    {
        return 3;
    }
    else
    {
        return 4;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_type != 3 && _type != 4)
    {
        if (section == 0)
        {
            return 1;
        }
        else if (section == 1)
        {
            return 2;
        }
        else
        {
            return _listStatusArray.count + 1;
        }
    }
    else
    {
        if (section == 0)
        {
            return 1;
        }
        else if (section == 3)
        {
            return _listStatusArray.count + 1;
        }
        else
        {
            return 2;
        }
    }
}

@end
