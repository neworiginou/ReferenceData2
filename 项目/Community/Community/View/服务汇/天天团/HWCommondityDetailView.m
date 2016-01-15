//
//  HWCommondityDetailView.m
//  Community
//
//  Created by ryder on 7/30/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//
//  功能描述：
//      天天团商品详情页面
//  修改记录：
//      姓名         日期              修改内容
//     程耀均     2015-07-30           创建文件

#import "HWCommondityDetailView.h"
#import "HWCommondityDetailFirestCell.h"
#import "HWCommondityDetailScdCell.h"
#import "HWCommondityDetailThirdCell.h"
#import "HWSubmitOrderView.h"
#import "HWApplicationDetailViewController.h"

@interface HWCommondityDetailView ()<HWCommondityDetailFirestCellDelegate, HWCommondityDetailThirdCellDelegate, HWCommondityDetailScdCellDelegate>
{
    NSString *_goodsId;
    DButton *_payBtn;
    CGFloat _webViewHeight;
}

@end

@implementation HWCommondityDetailView

- (instancetype)initWithFrame:(CGRect)frame goodsId:(NSString *)goodsId;
{
    if (self = [super initWithFrame:frame])
    {
        _webViewHeight = 0;
        _goodsId = goodsId;
        [self queryListData];
    }
    return self;
}

- (void)queryListData
{
    /*url：http://172.16.10.110:8080/hw-sq-app-web/grpBuyGoods/getGrpBuyGoodDetail.do
     输入参数说明：
     key：考拉社区登录成功用户被授权的key(必填)
     goodsId：被查看的商品id(必填)
     
     输出结果：
     
     {
     status: "1",
     data:
     { goodsId: 10349274824, goodsName: "红苹果", startTime: 1437840000000, endTime: 1438240641000, marketPrice: 20.44, sellPrice: 50, costPrice: null, postage: 5, freePostageType: 0, freePostageNum: 3, freePostageAmount: 20, bigImg: null, smallImg: "xxx1", orderImg: null, showDistanceEndTime: 1, showDistanceStartTime: 1, stock: null, surplusStock: null, reduceStockType: null, brand: "西部商贸有限公司", brandUrl: "www.baidu.com", showSurplus: null, limitCount: 10, goodsRemark: "xxx5", goodsInfo: "xxx4", buyGoodsCount: 1, currentTime: 1438254270534, isAuthBuy: null, status: "3", creater: null, createTime: null, modifier: null, modifyTime: null, version: null, disabled: null, surplusStock:30 }
     ,
     detail: "请求数据成功!",
     key: "3e801f50-10d8-44d7-9ce7-83e57fe582f1"
     }*/
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dictionary setPObject:_goodsId forKey:@"goodsId"];
    
    [manager POST:kTianTianTuanQueryCommondityDetails parameters:dictionary queue:nil success:^(id responese) {
        
        NSLog(@"商品详情:%@", responese);
        isLastPage = YES;
        NSDictionary *dataDict = [responese dictionaryObjectForKey:@"data"];
        
        _detailModel = [[HWCommondityDetailModel alloc] initWithdictionary:dataDict];
        
        [self loadDataAndUI];
        [self doneLoadingTableViewData];
        self.baseTable.showEndFooterView = NO;
        
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"error :%@", error);
        [self doneLoadingTableViewData];
        
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
    }];
}

- (void)loadDataAndUI
{
    [self loadTableViewHeaderView];
    [self loadShare];
    
    if (_webViewHeight == 0)
    {
        [self.baseTable reloadData];
    }
}

- (void)loadShare
{
    if (self.rDelegate && [self.rDelegate respondsToSelector:@selector(showShareBtn:)])
    {
        [self.rDelegate showShareBtn:YES];
    }
    
    //请求分享img 分享使用
    self.shareImg = [DImageV imagV:@"" frameX:0 y:0 w:0 h:0];
    __weak UIImageView *weakImgV = self.shareImg;
    [self.shareImg setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:_detailModel.orderImg]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (error == nil)
        {
            weakImgV.image = image;
        }
        else
        {
            weakImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
    }];
}

- (void)loadTableViewHeaderView
{
    CGFloat tableViewH = 200 * kScreenRate;
    DView *tableHeadView = [[DView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, tableViewH)];
    tableHeadView.backgroundColor = THEME_COLOR_White;
    
    DImageV *topImgV = [DImageV imagV:nil frameX:0 y:0 w:kScreenWidth h:tableViewH];
    topImgV.contentMode = UIViewContentModeScaleAspectFill;
    topImgV.clipsToBounds = YES;
    __weak UIImageView *weakImgV = topImgV;
    [topImgV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:_detailModel.bigImg]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        if (error != nil)
        {
            weakImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
        else
        {
            weakImgV.image = image;
        }
    }];
    [tableHeadView addSubview:topImgV];
    
    CGFloat descriptH = [Utility calculateStringHeight:_detailModel.goodsRemark font:FONT(TF16) constrainedSize:CGSizeMake(kScreenWidth - 2 * 10, 100000)].height;
    
    CGFloat goodNameH = [Utility calculateStringHeight:_detailModel.goodsName font:FONT(TF16) constrainedSize:CGSizeMake(kScreenWidth - 2 * 10, 100000)].height;
    
    DView *goodInfoBackView = [DView viewFrameX:0 y:tableViewH - 9 - descriptH - goodNameH - 9 - 5 w:kScreenWidth h:9 + descriptH + goodNameH + 9 + 5];
    goodInfoBackView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
    [tableHeadView addSubview:goodInfoBackView];
    
    DLable *gooNameLab = [DLable LabTxt:_detailModel.goodsName txtFont:TF16 txtColor:THEME_COLOR_White frameX:10 y:7 w:kScreenWidth - 2 * 10 h:goodNameH];
    [goodInfoBackView addSubview:gooNameLab];
    
    DLable *descriptionLab = [DLable LabTxt:_detailModel.goodsRemark txtFont:TF16 txtColor:THEME_COLOR_White frameX:10 y:CGRectGetMaxY(gooNameLab.frame) + 5 w:kScreenWidth - 2 * 10 h:descriptH];
    [goodInfoBackView addSubview:descriptionLab];
    
    self.baseTable.tableHeaderView = tableHeadView;
}

- (void)purchase:(UIButton *)button
{
    if ([_detailModel.status integerValue] == HWCommondityStatusSelling)
    {
        if ([_detailModel.isAuthBuy isEqualToString:@"1"])
        {
            if ([HWUserLogin verifyBindMobileWithPopVC:self.superVC showAlert:YES])
            {
                if ([HWUserLogin verifyIsLoginWithPresentVC:self.superVC toViewController:nil])
                {
                    if ([HWUserLogin verifyIsAuthenticationWithPopVC:self.superVC showAlert:YES])
                    {
                        HWSubmitOrderView *submitOrderView = [[HWSubmitOrderView alloc] initWithModel:_detailModel];
                        submitOrderView.delegate = self;
                        submitOrderView.superVC = self.superVC;
                        [self addSubview:submitOrderView];
                    }
                }
            }
        }
        else
        {
            if ([HWUserLogin verifyBindMobileWithPopVC:self.superVC showAlert:YES])
            {
                if ([HWUserLogin verifyIsLoginWithPresentVC:self.superVC toViewController:nil])
                {
                    HWSubmitOrderView *submitOrderView = [[HWSubmitOrderView alloc] initWithModel:_detailModel];
                    submitOrderView.delegate = self;
                    submitOrderView.superVC = self.superVC;
                    [self addSubview:submitOrderView];
                }
            }
        }
    }
}

- (void)setPayBtnStatus:(HWCommonditySaleStatus)status
{
    switch (status)//(0即将开始,1进行中,2已售完，3已下架，4未知状态)
    {
        case HWCommonditySaleStatusWillStarting:
        {
            [_payBtn setTitle:@"即将开始" forState:UIControlStateNormal];
            [_payBtn setStyle:DBtnStyleMain];
            _payBtn.userInteractionEnabled = NO;
        }
            break;
        case HWCommonditySaleStatusPurchase:
        {
            [_payBtn setTitle:@"立即购买" forState:UIControlStateNormal];
            [_payBtn setStyle:DBtnStyleRed];
        }
            break;
        case HWCommonditySaleStatusSellOut:
        {
            [_payBtn setTitle:@"已售完" forState:UIControlStateNormal];
            [_payBtn setStyle:DBtnStyleDisabled];
        }
            break;
        case HWCommonditySaleStatusOff:
        {
            [_payBtn setTitle:@"已下架" forState:UIControlStateNormal];
            [_payBtn setStyle:DBtnStyleDisabled];
        }
            break;
        default:
        {
            [_payBtn setTitle:@"已关闭" forState:UIControlStateNormal];
            [_payBtn setStyle:DBtnStyleDisabled];
        }
            break;
    }
}

#pragma mark - HWCommondityDetailThirdCellDelegate
- (void)pushToBrandLink:(NSString *)linkUrl
{
    if (linkUrl.length > 0)
    {
        HWApplicationDetailViewController *appDetailVC = [[HWApplicationDetailViewController alloc] init];
        appDetailVC.navigationItem.titleView = [Utility navTitleView:_detailModel.brand];
        appDetailVC.appUrl = linkUrl;
        if (self.rDelegate && [self.rDelegate respondsToSelector:@selector(pushToVC:)])
        {
            [self.rDelegate pushToVC:appDetailVC];
        }
    }
}

#pragma mark - HWCommondityDetailFirestCellDelegate
- (void)timerEndAction
{
    if ([_detailModel.status isEqual:@"0"]) //(0即将开始,1进行中,2已售完，3已下架，4未知状态)
    {
        _detailModel.status = @"1";
        _detailModel.currentTime = _detailModel.startTime;
        [self.baseTable reloadData];
    }
    else
    {
        _detailModel.status = @"3";
        [self.baseTable reloadData];
    }
}

#pragma mark -
#pragma mark HWCommondityDelegate
- (void)didSubmitOrder:(NSInteger)count price:(CGFloat)total orderId:(NSString *)orderId
{
    if ([self.delegate respondsToSelector:@selector(didSubmitOrder:price:orderId:)])
    {
        [self.delegate didSubmitOrder:count price:total orderId:orderId];
    }
}

#pragma mark - HWCommondityDetailScdCellDelegate
- (void)didFinishLoadHtmlWithContentHeight:(CGFloat)height
{
    _webViewHeight = height;
    [self.baseTable reloadData];
    self.baseTable.showEndFooterView = YES;
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_detailModel.brandUrl.length > 0)
    {
        return 3;
    }
    else
    {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 65.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DView *sctionView = [DView viewFrameX:0 y:0 w:kScreenWidth h:65.0f];
    sctionView.backgroundColor = THEME_COLOR_White;
    [Utility bottomLine:sctionView];
    
    NSString *sellPriceStr = _detailModel.sellPrice.length > 0 ? _detailModel.sellPrice : @"0";
    sellPriceStr = [NSString stringWithFormat:@"￥%@", sellPriceStr];
    CGFloat width = [Utility calculateStringWidth:sellPriceStr font:FONT(TF28) constrainedSize:CGSizeMake(10000, 30)].width;
    DLable *sellPriceLab = [DLable LabTxt:sellPriceStr txtFont:TF28 txtColor:THEME_COLOR_RED frameX:8 y:9 w:width h:30];
    [sctionView addSubview:sellPriceLab];
    
    NSString *marketPriceStr = _detailModel.marketPrice.length > 0 ? [NSString stringWithFormat:@"￥%@", _detailModel.marketPrice] : @"";
    width = [Utility calculateStringWidth:marketPriceStr font:FONT(TF15) constrainedSize:CGSizeMake(100000, 16)].width;
    DLable *marketLab = [DLable LabTxt:marketPriceStr txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:CGRectGetMaxX(sellPriceLab.frame) + 6 y:CGRectGetMaxY(sellPriceLab.frame) - 16 w:width h:16];
    [sctionView addSubview:marketLab];
    
    CALayer *redLine = [DView layerFrameX:CGRectGetMinX(marketLab.frame) + 2 y:CGRectGetMaxY(marketLab.frame) - 8 w:width h:0.5f];
    redLine.backgroundColor = THEME_COLOR_RED.CGColor;
    [sctionView.layer addSublayer:redLine];
    
    DImageV *postIcon = [DImageV imagV:@"邮费" frameX:15 y:CGRectGetMaxY(sellPriceLab.frame) + 5 w:13 h:11.5f];
    [sctionView addSubview:postIcon];
    
    NSString *postageStr = @"";
    if (_detailModel.postage.length == 0 || [_detailModel.postage isEqualToString:@"0"])
    {
        postageStr = @"免邮";
    }
    else
    {
        if ([_detailModel.freePostageType isEqualToString:@"0"])//免邮类型(0金额， 1分数， 2不免邮)
        {
            postageStr = [NSString stringWithFormat:@"邮费:￥%@ (满%@元包邮)", _detailModel.postage, _detailModel.freePostageAmount];
        }
        else if ([_detailModel.freePostageType isEqualToString:@"1"])
        {
            postageStr = [NSString stringWithFormat:@"邮费:￥%@ (满%@份包邮)", _detailModel.postage, _detailModel.freePostageNum];
        }
        else if ([_detailModel.freePostageType isEqualToString:@"2"])
        {
            postageStr = [NSString stringWithFormat:@"邮费:￥%@", _detailModel.postage];
        }
    }
    
    DLable *postageLab = [DLable LabTxt:postageStr txtFont:TF12 txtColor:THEME_COLOR_TEXT frameX:CGRectGetMaxX(postIcon.frame) + 5 y:CGRectGetMinY(postIcon.frame) w:300 h:13];
    [sctionView addSubview:postageLab];
    
    _payBtn = [DButton btnTxt:@"" txtFont:TF17 frameX:kScreenWidth - 15 - 95 y:15 w:95.0f h:35.0f target:self action:@selector(purchase:)];
    [self setPayBtnStatus:[_detailModel.status integerValue]];
    [_payBtn setRadius:8];
    [sctionView addSubview:_payBtn];
    
    return sctionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = [NSString stringWithFormat:@"cellId%d", indexPath.row];
    
    NSInteger row = indexPath.row;
    
    if (row == 0)
    {
        HWCommondityDetailFirestCell *firstCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!firstCell)
        {
            firstCell = [[HWCommondityDetailFirestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        [firstCell fillDataWithModel:_detailModel];
        firstCell.delegate = self;
        
        return firstCell;
    }
    else if (row == 1)
    {
        HWCommondityDetailScdCell *scdCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!scdCell)
        {
            scdCell = [[HWCommondityDetailScdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            scdCell.delegate = self;
        }
        
        if (_webViewHeight == 0 && _detailModel.goodsInfo.length > 0)
        {
            [scdCell fillDataWithHtmlStr:_detailModel.goodsInfo];
        }
        
        return scdCell;
    }
    else
    {
        HWCommondityDetailThirdCell *thirdCell = [[HWCommondityDetailThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        if (!thirdCell)
        {
            thirdCell = [[HWCommondityDetailThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        [thirdCell fillDataWithModel:_detailModel];
        thirdCell.delegate = self;
        
        return thirdCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    CGFloat height = 0;
    if (row == 0)
    {
        height = 80.0f;
    }
    else if (row == 1)
    {
//        height = [HWCommondityDetailScdCell getCellHeight:_detailModel.goodsInfo];
        height = _webViewHeight;
    }
    else
    {
        height = [HWCommondityDetailThirdCell getCellHeigth:_detailModel];
    }
    return height;
}

@end
