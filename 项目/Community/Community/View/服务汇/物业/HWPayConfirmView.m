//
//  HWPayConfirmView.m
//  Community
//
//  Created by niedi on 15/6/24.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWPayConfirmView.h"
#import "HWPayConfirmModel.h"
#import "HWHomeServiceCell.h"
#import "HWServiceListPayDetailModel.h"
#import "HWServiceListDetailModel.h"
#import "HWServiceListModel.h"
#import "HWServiceListPaySuccessViewController.h"
#import "HWServiceListDetailViewController.h"

#import <ALBBOpenAccountUI/ALBBOpenAccountUIService.h>
#import <ALBBOpenTrade/ALBBOpenTradeService.h>
#import <TAESDK/TAESDK.h>
#import "AppDelegate.h"

@interface HWPayConfirmView ()
{
    HWPayConfirmType _type;
    HWPayConfirmModel *_model;
    
    HWServiceListDetailModel *_serviceListDetailModel;
    HWServiceListModel *_serviceListModel;
    NSString *_totalCharge;
    NSString *_orderId;
    
    id<ALBBOpenTradeService> _tradeService;
    NSString *_payOrderId;
    NSString *_token;
}
@end

@implementation HWPayConfirmView

- (instancetype)initWithFrame:(CGRect)frame model:(id)model type:(HWPayConfirmType)type
{
    if (self = [super initWithFrame:frame])
    {
        _type = type;
        _tradeService =[[TaeSDK sharedInstance] getService:@protocol(ALBBOpenTradeService)];
        
        self.baseTable.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - 45.0f);
        if (_type == HWPayConfirmTypeWeYeForWyPush)
        {
            _model = model;
            [self.baseTable reloadData];
        }
        else
        {
            if ([model isKindOfClass:[HWServiceListDetailModel class]])
            {
                _serviceListDetailModel = model;
            }
            else
            {
                _serviceListModel = model;
            }
            [self queryListData];
        }
        
        [self loadUI];
    }
    return self;
}

- (void)queryListData
{
    if (_type == HWPayConfirmTypeWeYeForWyPush)
    {
        isLastPage = YES;
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.2];
    }
    else
    {
        NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
        [parame setObject:_serviceListDetailModel == nil ? _serviceListModel.orderId : _serviceListDetailModel.orderId forKey:@"orderId"];
        
        [parame setObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
        
        HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
        [manager POST:kQueryConsumerDetails parameters:parame queue:nil success:^(id responese)
        {
            NSLog(@"responese ========================= %@",responese);
            if (self.currentPage == 0)
            {
                [self.baseListArr removeAllObjects];
            }
            NSDictionary *dict = [responese dictionaryObjectForKey:@"data"];
            _payOrderId = [dict stringObjectForKey:@"bcOrderId"];
            _token = [dict stringObjectForKey:@"token"];
            _totalCharge = [dict stringObjectForKey:@"charge"];
            _orderId = [dict stringObjectForKey:@"orderId"];
            NSArray *arr = [dict arrayObjectForKey:@"itemsList"];
            isLastPage = YES;
            
            for (NSDictionary *dict in arr)
            {
                HWServiceListPayDetailModel *model = [[HWServiceListPayDetailModel alloc] initWithDic:dict];
                [self.baseListArr addObject:model];
            }
            
            [self.baseTable reloadData];
            [self doneLoadingTableViewData];
        } failure:^(NSString *code, NSString *error)
        {
            [Utility hideMBProgress:self];
            [self doneLoadingTableViewData];
            [Utility showToastWithMessage:error inView:self];
        }];
    }
}

- (void)payForWuYeQuery
{
    /*URL:/hw-sq-app-web/wyJF/createOrder.do
     入参：
     key
     villageId 小区id
     WyId 物业交费表id
     eDate 结束日期
     allPay 全部缴费费用
     出参：
     
     /百川订单id/
     private Long orderId;
     /百川验证token/
     private String token;*/
    
    HWWuYeFeeModel *model = _model.wyModel;
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:[HWUserLogin currentUserLogin].villageId forKey:@"villageId"];
    [param setPObject:model.wyFeeId forKey:@"WyId"];
    [param setPObject:_model.sDateStr forKey:@"sDate"];
    [param setPObject:_model.toDateStr forKey:@"eDate"];
    [param setPObject:_model.allPayStr forKey:@"allPay"];
    [param setPObject:model.houseId forKey:@"houseId"];
    [param setPObject:model.WyHouseId forKey:@"WyHouseId"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KWuYeFeeCreatOrder parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"responese 物业缴费========================= %@",responese);
         
         NSDictionary *dict = [responese dictionaryObjectForKey:@"data"];
         _token = [dict stringObjectForKey:@"token"];
         _payOrderId = [dict stringObjectForKey:@"orderId"];
         
         [self loadPayAction];
         
     } failure:^(NSString *code, NSString *error) {
         [Utility showToastWithMessage:error inView:self];
     }];
}

- (void)loadUI
{
    DView *tableHeadV = [DView viewFrameX:0 y:0 w:kScreenWidth h:10];
    tableHeadV.backgroundColor = [UIColor clearColor];
    self.baseTable.tableHeaderView = tableHeadV;
    
    DView *tableFootV = [DView viewFrameX:0 y:0 w:kScreenWidth h:70.0f];
    tableFootV.backgroundColor = [UIColor whiteColor];
    self.baseTable.tableFooterView = tableFootV;
    
    DImageV *topLine = [DImageV imagV:@"" frameX:15 y:0 w:kScreenWidth - 2 * 15 h:0.5f];
    [tableFootV addSubview:topLine];
    
    DImageV *img = [DImageV imagV:@"gou" frameX:25 y:20 w:25 h:25];
    [tableFootV addSubview:img];
    
    DLable *zfLab = [DLable LabTxt:@"支付宝" txtFont:TF16 txtColor:THEME_COLOR_SMOKE frameX:CGRectGetMaxX(img.frame) + 15 y:CGRectGetMinY(img.frame) w:200 h:25];
    [tableFootV addSubview:zfLab];
    
    DImageV *buttomLine = [DImageV imagV:@"" frameX:0 y:69.5f w:kScreenWidth h:0.5f];
    buttomLine.backgroundColor = THEME_COLOR_LINE;
    [tableFootV addSubview:buttomLine];
    
    DButton *payBtn = [DButton btnTxt:@"去支付" txtFont:TF18 frameX:0 y:CONTENT_HEIGHT - 45.0f w:kScreenWidth h:45.0f target:self action:@selector(toPay)];
    [payBtn setStyle:DBtnStyleMain];
    [self addSubview:payBtn];
}

- (void)toPay
{
    NSLog(@"去支付");
    if (_type == HWPayConfirmTypeWeYeForWyPush)
    {
        [self payForWuYeQuery];
    }
    else
    {
        [self loadPayAction];
    }
}

- (void)loadPayAction
{
    long moneyAmount;
    if (_type == HWPayConfirmTypeWeYeForWyPush)
    {
         moneyAmount = [_model.allPayStr doubleValue] * 100;
    }
    else
    {
         moneyAmount = [_totalCharge doubleValue] * 100;
    }
    
    id<ALBBOpenAccountService> sr=[[TaeSDK sharedInstance] getService:@protocol(ALBBOpenAccountService)];
    
    [sr loginByAuthToken:_token successCallback:^(ALBBOpenAccountSession *currentSession) {
        
        [_tradeService showPayOrder:(UIViewController *)self.delegate orderId:[NSNumber numberWithLongLong:[_payOrderId longLongValue]]  isvOrderId:nil outPayId:nil amount:[NSNumber numberWithLongLong:moneyAmount] timeout:@"30" callback:^(NSDictionary *resultDic,NSError *error) {
            
            NSLog(@"resultDic:%@\n error:%@", resultDic, error);
            
            if ([[resultDic stringObjectForKey:@"resultStatus"] isEqualToString:@"9000"])
            {
                AppDelegate *delegate = SHARED_APP_DELEGATE;
                [Utility showToastWithMessage:@"支付成功" inView:delegate.window];
                
                if (_type == HWPayConfirmTypeWeYeForWyPush)
                {
                    if (_delegate && [_delegate respondsToSelector:@selector(popToWuYeFeeVC)])
                    {
                        [_delegate popToWuYeFeeVC];
                    }
                }
                else
                {
                    if (_delegate && [_delegate respondsToSelector:@selector(pushViewController:)])
                    {
                        HWServiceListPaySuccessViewController *vc = [[HWServiceListPaySuccessViewController alloc] init];
                        vc.orderId = _orderId;
                        if (_type == HWPayConfirmTypeHomeServiceForDetail)
                        {
                            vc.pushType = pushPaySuccessTypeDetail;
                        }
                        else if (_type == HWPayConfirmTypeHomeServiceForList)
                        {
                            vc.pushType = pushPaySuccessTypeList;
                        }
                        else if (_type == HWPayConfirmTypeHomeServiceForWy)
                        {
                            vc.pushType = pushPaySuccessTypeWY;
                        }
                        [_delegate pushViewController:vc];
                    }
                }
            }
            else
            {
                AppDelegate *delegate = SHARED_APP_DELEGATE;
                [Utility showToastWithMessage:@"支付未完成" inView:delegate.window];
                
                if (_delegate && [_delegate respondsToSelector:@selector(pushViewController:)])
                {
                    HWServiceListDetailViewController *svc = [[HWServiceListDetailViewController alloc] init];
                    svc.orderID = _orderId;
                    if (_type == HWPayConfirmTypeHomeServiceForWy)
                    {
                        svc.pushType = pushHomeServiceDetailTypeWY;
                        [_delegate pushViewController:svc];
                    }
                    else if (_type == HWPayConfirmTypeHomeServiceForDetail)
                    {
                        
                    }
                    else if (_type == HWPayConfirmTypeHomeServiceForList)
                    {
                        
                    }
                }
            }
        }];
        
    } failedCallback:^(NSError *error) {
        
        AppDelegate *delegate = SHARED_APP_DELEGATE;
        [Utility showToastWithMessage:@"支付未完成" inView:delegate.window];
        
        if (_delegate && [_delegate respondsToSelector:@selector(pushViewController:)])
        {
            HWServiceListDetailViewController *svc = [[HWServiceListDetailViewController alloc] init];
            svc.orderID = _orderId;
            if (_type == HWPayConfirmTypeHomeServiceForWy)
            {
                svc.pushType = pushHomeServiceDetailTypeWY;
                [_delegate pushViewController:svc];
            }
            else if (_type == HWPayConfirmTypeHomeServiceForDetail)
            {
                
            }
            else if (_type == HWPayConfirmTypeHomeServiceForList)
            {
                
            }
        }
    }];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_type == HWPayConfirmTypeWeYeForWyPush)
    {
        return 2;
    }
    else
    {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 10;
    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        DImageV *sectionView = [DImageV imagV:@"" frameX:0 y:0 w:kScreenWidth h:10.0f];
        sectionView.backgroundColor = [UIColor clearColor];
        
        DImageV *line = [DImageV imagV:@"" frameX:0 y:9.5f w:kScreenWidth h:0.5f];
        line.backgroundColor = THEME_COLOR_LINE;
        [sectionView addSubview:line];
        
        return sectionView;
    }
    else
    {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_type == HWPayConfirmTypeWeYeForWyPush)
    {
        if (section == 0)
        {
            return 5;
        }
        else
        {
            return 1;
        }
    }
    else
    {
        if (section == 0)
        {
            return self.baseListArr.count + 2;
        }
        else
        {
            return 1;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == HWPayConfirmTypeWeYeForWyPush)
    {
        NSInteger row = indexPath.row;
        NSString *cellId = @"cellId";
        HWHomeServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil)
        {
            cell = [[HWHomeServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        if (indexPath.section == 0)
        {
            if (row == 0)
            {
                [cell fillDataWithLeftStr:_model.title0 rightStr:nil];
            }
            else if (row == 1)
            {
                [cell fillDataWithLeftStr:@"房号" rightStr:_model.title1];
            }
            else if (row == 2)
            {
                [cell fillDataWithLeftStr:@"业主" rightStr:_model.title2];
            }
            else if (row == 3)
            {
                [cell fillDataWithLeftStr:@"物业费" rightStr:_model.title3];
            }
            else if (row == 4)
            {
                [cell fillDataWithLeftStr:@"缴费至" rightStr:_model.title4];
            }
        }
        else if (indexPath.section == 1 && indexPath.row == 0)
        {
            [cell fillDataWithLeftStr:@"选择支付方式" rightStr:nil];
        }
        
        return cell;
    }
    else
    {
        NSString *cellId = @"cellId";
        HWHomeServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil)
        {
            cell = [[HWHomeServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [cell setLeftGap:YES];
        if (indexPath.section == 0)
        {
            if (indexPath.row == 0)
            {
                [cell fillDataWithServiceListLeftStr:@"订单明细" rightStr:nil];
            }
            else if (indexPath.row == self.baseListArr.count + 1 && self.baseListArr.count != 0)
            {
                [cell fillDataWithServiceListLeftStr:@"总价" rightStr:_totalCharge];
                [cell setLeftGap:NO];
            }
            else
            {
                NSString *str = [NSString stringWithFormat:@"%@ x%@",[[self.baseListArr pObjectAtIndex:indexPath.row - 1]name],[[self.baseListArr pObjectAtIndex:indexPath.row - 1]amount]];
                NSString *strPrice = [NSString stringWithFormat:@"%.2f",[[[self.baseListArr pObjectAtIndex:indexPath.row - 1]amount] floatValue] * [[[self.baseListArr pObjectAtIndex:indexPath.row - 1]price] floatValue]];
                [cell fillDataWithServiceListLeftStr:str rightStr:strPrice];
            }
        }
        else if (indexPath.section == 1 && indexPath.row == 0)
        {
            [cell fillDataWithLeftStr:@"选择支付方式" rightStr:nil];
        }
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HWHomeServiceCell getCellHeight:@""];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
