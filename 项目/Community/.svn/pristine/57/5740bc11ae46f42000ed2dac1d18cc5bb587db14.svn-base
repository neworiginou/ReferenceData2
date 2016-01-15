//
//  HWMyBargainOrderViewController.m
//  Community
//
//  Created by D on 14/12/9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWMyBargainOrderViewController.h"
#import "SurePayController.h"
#import "OrderAddressController.h"
@implementation HWMyBargainOrderViewController

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"无底线订单"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    [self setHeaderView];
    
    self.isNeedHeadRefresh = YES;
    [self queryListData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refershOrder) name:RELOAD_ORDER object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refershOrder) name:PAY_SUCCESS object:nil];
    
}
-(void)refershOrder
{
    [self queryListData];
}
//数据请求
- (void)queryListData
{
    [Utility hideMBProgress:self.view];
    [Utility showMBProgress:self.view message:@"请求数据"];
    
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager cutManager];
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:user.key forKey:@"key"];
    [dict setPObject:@"1" forKey:@"source"];
    [dict setPObject:[NSString stringWithFormat:@"%d",_currentPage] forKey:@"page"];
    [dict setPObject:[NSString stringWithFormat:@"%d",kPageCount] forKey:@"size"];
    
    //appUrlVersion=1&source=1&key=43bb4024-fa39-49d0-8138-6c05f17d3307&page=0&digest=NjY5ODIxNTg1NTMwNzk2RTMzMTdEMzJEMDJENUJDNUU%3D&size=10
    [manage POST:kBargainOrder parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
        
        NSMutableArray * array = [NSMutableArray array];
        NSArray *contentsArr = [[responseObject dictionaryObjectForKey:@"data"] arrayObjectForKey:@"content"];
        for (NSDictionary *dic in contentsArr) {
            HWMyBargainOrderModel *model = [[HWMyBargainOrderModel alloc]initWithBargainOrderDic:dic];
            [array addObject:model];
        }
        if (array.count < kPageCount)
        {
            isLastPage = YES;
        }
        else
        {
            isLastPage = NO;
        }
        
        if (_currentPage == 0)
        {
            dataList = [[NSMutableArray alloc]initWithArray:array];
        } else {
            [dataList addObjectsFromArray:array];
        }
        
        [baseTableView reloadData];
        
        if(dataList.count == 0)
        {
            [self showEmpty:@"暂无订单"];
        }else{
            [self hideEmpty];
        }
        
        [self doneLoadingTableViewData];
        
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [self doneLoadingTableViewData];
        
        NSLog(@"hwmybargainorder:%@",error);
        if (self.dataList.count == 0)
        {
            [self showEmpty:@"暂无订单"];
        }else{
            [self hideEmpty];
        }
    }];
}

- (void)setHeaderView {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = BACKGROUND_COLOR;
    baseTableView.tableHeaderView = view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    HWMyBargainOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
     HWMyBargainOrderModel *model = self.dataList[indexPath.row];
    if (cell == nil) {
        cell = [[HWMyBargainOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.bargainOrderModel = model;
    [cell setComeInPay:^(HWMyBargainOrderModel *bargainModel) {
        [MobClick event:@"click_kanjiadingdanfukuan"];
        SurePayController *surePayVC = [[SurePayController alloc] init];
        surePayVC.orderTypeStr = @"1";
        NSDictionary *dict = bargainModel.addressDto;
        if(![dict isKindOfClass:[NSNull class]])
        {
            surePayVC.methodType = haveAddressMethod;
            HWAddressModel *model = [[HWAddressModel alloc]initWithAddress:dict];
            surePayVC.addressModel = model;
            
        }
        else
        {
            surePayVC.methodType = noAddressMethod;
        }
        surePayVC.objectStr = @"订单支付";
        surePayVC.subObjectStr = @"订单支付";
        if([[HWUserLogin currentUserLogin].totalMoney floatValue] > [model.payMoney floatValue])
        {
            surePayVC.isSelectedWalletFlag = @"0";//0代表余额支付
        }
        else
        {
            surePayVC.isSelectedWalletFlag = @"1";//1代表支付宝支付
        }
//        HWAddressModel *addressModel = [[HWAddressModel alloc]init];
//        addressModel.addressId = model.cutAddressIdStr;
//        addressModel.cutUserId = model.cutUserIdStr;
//        addressModel.address = model.addressStr;
//        addressModel.name = model.userNameStr;
//        addressModel.mobile = model.phoneStr;
        surePayVC.orderId = model.orderIdStr;
        surePayVC.payMoney = model.payMoney;
//        surePayVC.addressModel = addressModel;
        [self.navigationController pushViewController:surePayVC animated:YES];
    }];
    [cell showForModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HWMyBargainOrderModel *model = self.dataList[indexPath.row];
    CGFloat h = [Utility calculateStringHeight:model.productName font:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL] constrainedSize:CGSizeMake(kScreenWidth - (15 + 65 + 10) - 15, CGFLOAT_MAX)].height;;
    return 165 + h;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    OrderAddressController *orderCtrl = [[OrderAddressController alloc]init];
//    [self.navigationController pushViewController:orderCtrl animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
