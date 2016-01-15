//
//  HWTianTianTuanDetailView.m
//  Community
//
//  Created by niedi on 15/7/31.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWTianTianTuanDetailView.h"
#import "HWTianTianTuanDetailModel.h"
#import "HWTianTianTuanDetailCell.h"
#import "AppDelegate.h"

@interface HWTianTianTuanDetailView ()
{
    NSString *_orderId;
    
    HWTianTianTuanDetailModel *_model;
    NSString *_phoneNumStr;
    
    long long _remainTimeCount;
    NSTimer *_timer;
    
    DButton *payBtn;
    DLable *remainTimeLab;
    DImageV *remainTimeImg;
}
@end

@implementation HWTianTianTuanDetailView

- (void)dealloc
{
    [_timer setFireDate:[NSDate distantFuture]];
    [_timer invalidate];
    _timer = nil;
}

- (void)invalidaTimer
{
    [_timer setFireDate:[NSDate distantFuture]];
    [_timer invalidate];
    _timer = nil;
}

- (instancetype)initWithFrame:(CGRect)frame orderId:(NSString *)orderId
{
    if (self = [super initWithFrame:frame])
    {
        _orderId = orderId;
        _remainTimeCount = 0;
        
        [self queryListData];
    }
    return self;
}

- (void)queryListData
{
    [self queryDataForDetailData];
    [self queryDataForPhoneNum];
    [self queryDataForRemainTime];
}

- (void)queryDataForRemainTime
{
    /*接口名称：天天团订单自动取消倒计时
     接口地址：grpBuyOrder/orderCountDownTime.do
     入参：key,orderId
     出参：
     {"status":"1","data":549876451,"detail":"请求数据成功!","key":"788f4790-b3af-48ff-8e42-f60e30a5714e"} */
    
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    [parame setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [parame setPObject:_orderId forKey:@"orderId"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KTianTianTuanCancleTime parameters:parame queue:nil success:^(id responese)
     {
         [Utility hideMBProgress:self];
         NSLog(@"%@", responese);
         
         _remainTimeCount = [[responese stringObjectForKey:@"data"] longLongValue] / 1000;
         if (_remainTimeCount > 1)
         {
             if (_model)
             {
                 [self loadData];
             }
             [self startTimerFire];
         }
         
     } failure:^(NSString *code, NSString *error) {
         NSLog(@"code==%@  error==%@",code,error);
         
         [Utility hideMBProgress:self];
         [Utility showToastWithMessage:error inView:self];
     }];
}

- (void)queryDataForDetailData
{
    /*接口名称：天天团订单详情
     接口地址：grpBuyOrder/orderDetail.do
     入参：key,orderId
     出参：{
     "status": "1",
     "data":
     { "id": 5,订单id "orderCode": null,订单编号 "payOrderId": 1302021545,支付流水号 "goodsId": null,商品编号 "address": "上海最牛逼",收货地址 "sendInfo": null, "orderStatus": 0,订单状态 "remark": null, "orderAmount": 100.0000,订单金额 "goodsCount": 2,商品数量 "payType": null, "payMoney": 105.0000,支付金额 "payTime": null,支付时间 "mobile": "18645050000",电话 "name": "二踢脚",收货人姓名 "isExport": null, "expressName": null, "expressNumber": null, "sendGoodsTime": null, "createTime": 1438220895000,下单时间 "returnMoneyTime": null,退货时间 "brand": "西部商贸有限公司",供应商 "sellPrice": 50.0000,单价 "goodsName": "红苹果",商品名称 "postage": 5.0000,邮费 "orderImg": "xxx3",订单图片 "userId": 1030431030435 用户id }
     
     ,
     "detail": "请求数据成功!",
     "key": "788f4790-b3af-48ff-8e42-f60e30a5714e"
     }*/
    
    [Utility hideMBProgress:self];
    [Utility showMBProgress:self message:LOADING_TEXT];
    
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    [parame setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [parame setPObject:_orderId forKey:@"orderId"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KTianTianTuanDetail parameters:parame queue:nil success:^(id responese)
     {
         [Utility hideMBProgress:self];
         NSLog(@"%@", responese);
         isLastPage = YES;
         
         NSDictionary *dataDict = [responese dictionaryObjectForKey:@"data"];
         
         _model = [[HWTianTianTuanDetailModel alloc] initWithDict:dataDict];
         
         [self loadData];
         
         [self doneLoadingTableViewData];
         
     } failure:^(NSString *code, NSString *error) {
         NSLog(@"code==%@  error==%@",code,error);
         
         [Utility hideMBProgress:self];
         [Utility showToastWithMessage:error inView:self];
         [self doneLoadingTableViewData];
     }];
}

- (void)queryDataForPhoneNum
{
    //请求电话
    /*//172.16.10.13/hw-sq-app-web/common/findCommonDictByDictId.do?dictId=2&key=c5da2880-bbd1-495a-91ca-981cb49c79b7*/
    
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    [parame setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [parame setPObject:@"2" forKey:@"dictId"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KTianTianTuanPhoneNum parameters:parame queue:nil success:^(id responese)
     {
         [Utility hideMBProgress:self];
         NSLog(@"%@", responese);
         
         NSDictionary *dataDict = [responese dictionaryObjectForKey:@"data"];
         
         _phoneNumStr = [dataDict stringObjectForKey:@"dictCodeText"];
         
         if (_phoneNumStr.length > 0)
         {
             [self loadTableViewFootView];
         }
         
     } failure:^(NSString *code, NSString *error) {
         NSLog(@"code==%@  error==%@",code,error);
         
         [Utility hideMBProgress:self];
         [Utility showToastWithMessage:error inView:self];
     }];
}

- (void)loadData
{
    if ([_model.orderStatus isEqualToString:@"0"])//0未支付，1已支付未发货，2订单已退款，3已发货，4订单已关闭
    {
        [self showCancleBtn:YES];
        self.baseTable.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - 45.0f);
    }
    else
    {
        [self showCancleBtn:NO];
        self.baseTable.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT);
    }
    
    if ([_model.isChange isEqualToString:@"1"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tiantianTuanRefreshList" object:nil];
    }
    
    [self loadUI];
    
    [self.baseTable reloadData];
}

- (void)startTimerFire
{
    [_timer invalidate];
    _timer = nil;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                              target:self
                                            selector:@selector(timerAction)
                                            userInfo:nil
                                             repeats:YES];
    //MYP add 防止tableview滚动时对timer的干扰
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction
{
    _remainTimeCount--;
    if(_remainTimeCount <= 0)
    {
        [_timer invalidate];
        _timer = nil;
        
        if ([_model.orderStatus isEqualToString:@"0"])//0未支付，1已支付未发货，2订单已退款，3已发货，4订单已关闭
        {
            AppDelegate *del = (AppDelegate *)SHARED_APP_DELEGATE;
            [Utility showToastWithMessage:@"订单超时，已被关闭" inView:del.window];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(timerEndPopToListVC)])
            {
                [self.delegate timerEndPopToListVC];
            }
        }
        
        remainTimeLab.text = [NSString stringWithFormat:@"00:00"];
    }
    else
    {
        NSInteger minutes = _remainTimeCount / 60;
        NSInteger seconds = _remainTimeCount % 60;
        
        NSString *secondString = [NSString stringWithFormat:@"%zd",seconds];
        if (seconds < 10)
        {
            secondString = [NSString stringWithFormat:@"0%zd",seconds];
        }
        
        NSString *minutesString = [NSString stringWithFormat:@"%zd",minutes];
        if (minutes < 10)
        {
            minutesString = [NSString stringWithFormat:@"0%zd",minutes];
        }
        NSString *remainTimeStr = [NSString stringWithFormat:@"%@:%@", minutesString,secondString];
        remainTimeLab.text = remainTimeStr;
    }
}

- (void)showCancleBtn:(BOOL)isShow
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(showCancleOrderBtn:)])
    {
        [self.delegate showCancleOrderBtn:isShow];
    }
}

- (void)payBtnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushToPayConfirmVC:)])
    {
        [self.delegate pushToPayConfirmVC:_model.orderId];
    }
}

- (void)jumpToGoodsDetail
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushToTianTianTuanGoodsDetail:)])
    {
        [self.delegate pushToTianTianTuanGoodsDetail:_model.goodsId];
    }
}

- (void)loadUI
{
    self.baseTable.tableHeaderView = nil;
    DView *tableHeaderView = [DView viewFrameX:0 y:0 w:kScreenWidth h:460];
    
    DView *backView = [DView viewFrameX:0 y:10 w:kScreenWidth h:450];
    backView.backgroundColor = [UIColor whiteColor];
    [tableHeaderView addSubview:backView];
    
    DLable *titleLab = [DLable LabTxt:@"" txtFont:TF16 txtColor:THEME_COLOR_MONEY frameX:15 y:0 w:kScreenWidth - 2 * 15 h:45.0f];
    [backView addSubview:titleLab];
    
    if ([_model.orderStatus isEqualToString:@"0"]) //0未支付，1已支付未发货，2订单已退款，3已发货，4订单已关闭
    {
        titleLab.text = @"待付款";
        titleLab.textColor = THEME_COLOR_RED;
    }
    else if ([_model.orderStatus isEqualToString:@"1"])
    {
        titleLab.text = @"待发货";
        titleLab.textColor = THEBUTTON_YELLOW_NORMAL;
    }
    else if ([_model.orderStatus isEqualToString:@"2"])
    {
        titleLab.text = @"已退款";
        titleLab.textColor = THEME_COLOR_ORANGE;
    }
    else if ([_model.orderStatus isEqualToString:@"3"])
    {
        titleLab.text = @"已发货";
        titleLab.textColor = THEME_COLOR_GREEN;
    }
    else if ([_model.orderStatus isEqualToString:@"4"])
    {
        titleLab.text = @"已关闭";
        titleLab.textColor = THEME_COLOR_BLUE;
    }
    
    NSString *remainTimeStr = @"           ";//占位
    CGFloat width = [Utility calculateStringWidth:remainTimeStr font:FONT(13) constrainedSize:CGSizeMake(10000, 15)].width;
    remainTimeLab = [DLable LabTxt:remainTimeStr txtFont:TF13 txtColor:THEME_COLOR_TEXT frameX:kScreenWidth - 10 - width y:0 w:width h:45.0f];
    [backView addSubview:remainTimeLab];
    
    remainTimeImg = [DImageV imagV:@"tiantianTuanTime" frameX:CGRectGetMinX(remainTimeLab.frame) - 19.5 y:13 w:15.5 h:17];
    [backView addSubview:remainTimeImg];
    
    if ([_model.orderStatus isEqualToString:@"0"])
    {
        if (_remainTimeCount <= 0)
        {
            remainTimeLab.hidden = YES;
            remainTimeImg.hidden = YES;
        }
        else
        {
            remainTimeLab.hidden = NO;
            remainTimeImg.hidden = NO;
        }
    }
    else
    {
        remainTimeLab.hidden = YES;
        remainTimeImg.hidden = YES;
    }
    
    CALayer *topOneLine = [DView layerFrameX:0 y:45.0f w:kScreenWidth h:0.5f];
    [backView.layer addSublayer:topOneLine];
    
    DLable *addressLab;
    CGFloat height;
    if (_model.name.length > 0 || _model.mobile.length > 0 || _model.address.length > 0)
    {
        NSString *reciverStr = [NSString stringWithFormat:@"收货人: %@   %@", _model.name, _model.mobile];
        DLable *reciverLab = [DLable LabTxt:reciverStr txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:CGRectGetMaxY(topOneLine.frame) + 18.0f w:kScreenWidth - 2 * 15 h:18.0f];
        [backView addSubview:reciverLab];
        
        NSString *addressStr = [NSString stringWithFormat:@"收货地址: %@", _model.address];
        height = [Utility calculateStringHeight:addressStr font:FONT(TF15) constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
        addressLab = [DLable LabTxt:addressStr txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:CGRectGetMaxY(reciverLab.frame) + 10 w:kScreenWidth - 2 * 15 h:height + 18];
        [backView addSubview:addressLab];
    }
    else
    {
        addressLab = [DLable LabTxt:nil txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:CGRectGetMaxY(topOneLine.frame) -  10 w:kScreenWidth - 2 * 15 h:0];
        [backView addSubview:addressLab];
    }
    
    CALayer *topTwoLine = [DView layerFrameX:0 y:CGRectGetMaxY(addressLab.frame) + 10 w:kScreenWidth h:0.5f];
    [backView.layer addSublayer:topTwoLine];
    
    DView *goodsJmpBackView = [DView viewFrameX:0 y:CGRectGetMaxY(topTwoLine.frame) w:kScreenWidth h:90.0f];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToGoodsDetail)];
    [goodsJmpBackView addGestureRecognizer:tap];
    [backView addSubview:goodsJmpBackView];
    
    DImageV *goodsImgV = [DImageV imagV:nil frameX:15 y:15 w:60 h:55];
    __weak UIImageView *weakImgV = goodsImgV;
    [goodsImgV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:_model.orderImg]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (error == nil)
        {
            weakImgV.image = image;
        }
        else
        {
            weakImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
    }];
    [goodsJmpBackView addSubview:goodsImgV];
    
    DLable *goodsNameLab = [DLable LabTxt:_model.goodsName txtFont:TF16 txtColor:THEME_COLOR_SMOKE frameX:CGRectGetMaxX(goodsImgV.frame) + 10 y:CGRectGetMinY(goodsImgV.frame) w:kScreenWidth - (CGRectGetMaxX(goodsImgV.frame) + 10) - 110 h:55.0f];
    [goodsJmpBackView addSubview:goodsNameLab];
    
    NSString *goodsPriceStr = [NSString stringWithFormat:@"￥%@", _model.sellPrice];
    height = [Utility calculateStringHeight:goodsPriceStr font:FONT(15) constrainedSize:CGSizeMake(75.0f, 10000)].height;
    DLable *goodsPriceLab = [DLable LabTxt:goodsPriceStr txtFont:TF15 txtColor:THEME_COLOR_ORANGE frameX:kScreenWidth - 110 y:45.0f - height w:75.0f h:height];
    goodsPriceLab.textAlignment = NSTextAlignmentRight;
    [goodsJmpBackView addSubview:goodsPriceLab];
    
    NSString *goodsNumStr = [NSString stringWithFormat:@"x%@", _model.goodsCount];
    height = [Utility calculateStringHeight:goodsNumStr font:FONT(15) constrainedSize:CGSizeMake(75.0f, 10000)].height;
    DLable *goodsNumLab = [DLable LabTxt:goodsNumStr txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:kScreenWidth - 110 y:CGRectGetMaxY(goodsPriceLab.frame) w:75.0f h:height];
    goodsNumLab.textAlignment = NSTextAlignmentRight;
    goodsNumLab.contentMode = UIViewContentModeTop;
    [goodsJmpBackView addSubview:goodsNumLab];
    
    DImageV *rightJmpImgV = [DImageV imagV:@"arrow" frameX:kScreenWidth - 15 - 9 y:37 w:9 h:16];
    [goodsJmpBackView addSubview:rightJmpImgV];
    
    CALayer *topThreeLine = [DView layerFrameX:0 y:CGRectGetMaxY(topTwoLine.frame) + 90.0f w:kScreenWidth h:0.5f];
    [backView.layer addSublayer:topThreeLine];
    
    DLable *totalMoneyTitleLab = [DLable LabTxt:@"商品总价" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:CGRectGetMaxY(topThreeLine.frame) + 15 w:200 h:18.0f];
    [backView addSubview:totalMoneyTitleLab];
    
    NSString *totalMoneyStr = [NSString stringWithFormat:@"￥%.2f", [_model.sellPrice floatValue] * [_model.goodsCount floatValue]];
    DLable *totalMoneyLab = [DLable LabTxt:totalMoneyStr txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:CGRectGetMinY(totalMoneyTitleLab.frame) w:kScreenWidth - 2 * 15 h:18.0f];
    totalMoneyLab.textAlignment = NSTextAlignmentRight;
    [backView addSubview:totalMoneyLab];
    
    DLable *postageTitlelab = [DLable LabTxt:@"邮费" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:CGRectGetMaxY(totalMoneyTitleLab.frame) + 25.0f w:200 h:18.0f];
    [backView addSubview:postageTitlelab];
    
    NSString *postageStr;
    if ([_model.postage isEqualToString:@"0"])
    {
        postageStr = @"免邮";
    }
    else
    {
        postageStr = [NSString stringWithFormat:@"￥%@", _model.postage];
    }
    DLable *postageLab = [DLable LabTxt:postageStr txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:CGRectGetMinY(postageTitlelab.frame) w:kScreenWidth - 2 * 15 h:18.0f];
    postageLab.textAlignment = NSTextAlignmentRight;
    [backView addSubview:postageLab];
    
    DLable *totalPayTitleLab = [DLable LabTxt:@"实付金额" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:CGRectGetMaxY(postageTitlelab.frame) + 25.0f w:200 h:18.0f];
    [backView addSubview:totalPayTitleLab];
    
    NSString *totalPayStr = [NSString stringWithFormat:@"￥%@", _model.orderAmount];
    DLable *totalPayLab = [DLable LabTxt:totalPayStr txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:CGRectGetMinY(totalPayTitleLab.frame) w:kScreenWidth - 2 * 15 h:18.0f];
    totalPayLab.textAlignment = NSTextAlignmentRight;
    [backView addSubview:totalPayLab];
    
    CALayer *topFourLine = [DView layerFrameX:15 y:CGRectGetMaxY(topThreeLine.frame) + 135.0f w:kScreenWidth - 2 * 15 h:0.5f];
    [backView.layer addSublayer:topFourLine];
    
    NSString *brandStr = [NSString stringWithFormat:@"供应商: %@", _model.brand];
    DLable *brandLab = [DLable LabTxt:brandStr txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:CGRectGetMinY(topFourLine.frame) w:kScreenWidth - 2 * 15 h:45.0f];
    [backView addSubview:brandLab];
    
    CALayer *topFiveLine = [DView layerFrameX:15 y:CGRectGetMaxY(topFourLine.frame) + 45.0f w:kScreenWidth - 2 * 15 h:0.5f];
    [backView.layer addSublayer:topFiveLine];
    
    NSString *remarkStr = _model.remark.length > 0 ? _model.remark : @"无";
    remarkStr = [NSString stringWithFormat:@"备注: %@", remarkStr];
    height = [Utility calculateStringHeight:remarkStr font:FONT(15) constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
    DLable *remarkLab = [DLable LabTxt:remarkStr txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:15 y:CGRectGetMaxY(topFiveLine.frame) + 15 w:kScreenWidth - 2 * 15 h:height];
    [backView addSubview:remarkLab];
    
    CGRect frame = backView.frame;
    frame.size.height = CGRectGetMaxY(remarkLab.frame) + 15;
    backView.frame = frame;
    
    frame = tableHeaderView.frame;
    frame.size.height = CGRectGetHeight(backView.frame) + 10;
    tableHeaderView.frame = frame;
    self.baseTable.tableHeaderView = tableHeaderView;
    
    payBtn = [DButton btnTxt:@"付款" txtFont:TF18 frameX:0 y:CONTENT_HEIGHT - 45.0f w:kScreenWidth h:45.0f target:self action:@selector(payBtnClick)];
    [payBtn setStyle:DBtnStyleMain];
    [self addSubview:payBtn];
    if ([_model.orderStatus isEqualToString:@"0"])
    {
        payBtn.hidden = NO;
    }
    else
    {
        payBtn.hidden = YES;
    }
}

- (void)loadTableViewFootView
{
    NSString *phoneStr = [NSString stringWithFormat:@"订单问题咨询: %@", _phoneNumStr];
    DLable *tableFootView = [DLable LabTxt:phoneStr txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:0 y:0 w:kScreenWidth - 2 * 15 h:45.0f];
    tableFootView.textAlignment = NSTextAlignmentCenter;
    self.baseTable.tableFooterView = tableFootView;
}

#pragma mark - 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_model.orderStatus isEqualToString:@"1"] || [_model.orderStatus isEqualToString:@"3"])//0未支付，1已支付未发货，2订单已退款，3已发货，4订单已关闭
    {
        return 4;
    }
    else if ([_model.orderStatus isEqualToString:@"2"])
    {
        return 5;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([_model.orderStatus isEqualToString:@"1"] || [_model.orderStatus isEqualToString:@"2"] || [_model.orderStatus isEqualToString:@"3"])
    {
        return 30.0f;
    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DLable *titleLab = [DLable LabTxt:@"    订单详情" txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:0 y:0 w:kScreenWidth h:30.0f];
    return titleLab;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellId";
    HWTianTianTuanDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[HWTianTianTuanDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSInteger row = indexPath.row;
    if (row == 0)
    {
        NSString *orderCodeStr = [NSString stringWithFormat:@"订单编号: %@", _model.orderCode];
        [cell fillDataWithLeftStr:orderCodeStr];
        [cell setLeftGap:YES rigthGap:YES];
        [cell hideButtomLine:NO];
    }
    else if (row == 1)
    {
        NSString *payOrderIdStr = [NSString stringWithFormat:@"支付流水号: %@", _model.payOrderId];
        [cell fillDataWithLeftStr:payOrderIdStr];
        [cell setLeftGap:YES rigthGap:YES];
        [cell hideButtomLine:NO];
    }
    else if (row == 2)
    {
        NSString *createTimeStr = [NSString stringWithFormat:@"下单时间: %@", [Utility getMinTimeWithTimestamp:_model.createTime]];
        [cell fillDataWithLeftStr:createTimeStr];
        [cell setLeftGap:YES rigthGap:YES];
        [cell hideButtomLine:NO];
    }
    else if (row == 3)
    {
        NSString *payTimeStr = [NSString stringWithFormat:@"付款时间: %@", [Utility getMinTimeWithTimestamp:_model.payTime]];
        [cell fillDataWithLeftStr:payTimeStr];
        if ([_model.orderStatus isEqualToString:@"2"])
        {
            [cell setLeftGap:YES rigthGap:YES];
            [cell hideButtomLine:NO];
        }
        else
        {
            [cell hideButtomLine:YES];
        }
    }
    else if (row == 4)
    {
        NSString *payTimeStr = [NSString stringWithFormat:@"退款时间: %@", [Utility getMinTimeWithTimestamp:_model.returnMoneyTime]];
        [cell fillDataWithLeftStr:payTimeStr];
        [cell hideButtomLine:YES];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSString *leftStr = @"";
    if (row == 0)
    {
        leftStr = [NSString stringWithFormat:@"订单编号: %@", _model.orderCode];
    }
    else if (row == 1)
    {
        leftStr = [NSString stringWithFormat:@"支付流水号: %@", _model.payOrderId];
    }
    else if (row == 2)
    {
        leftStr = [NSString stringWithFormat:@"下单时间: %@", [Utility getMinTimeWithTimestamp:_model.createTime]];
    }
    else if (row == 3)
    {
        leftStr = [NSString stringWithFormat:@"付款时间: %@", [Utility getMinTimeWithTimestamp:_model.payTime]];
    }
    else if (row == 4)
    {
        leftStr = [NSString stringWithFormat:@"退款时间: %@", [Utility getMinTimeWithTimestamp:_model.returnMoneyTime]];
    }
    return [HWTianTianTuanDetailCell getCellHeight:leftStr];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
