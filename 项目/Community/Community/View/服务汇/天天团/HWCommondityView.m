//
//  HWCommondityView.m
//  Community
//
//  Created by ryder on 7/29/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//
//  功能描述：
//      天天团列表页面的单个商品页
//  修改记录：
//      姓名         日期              修改内容
//     程耀均     2015-07-30           创建文件


#import "HWCommondityView.h"
#import "AppDelegate.h"

@interface HWCommondityView ()

@property (nonatomic, strong) DView *mainView;
@property (nonatomic, strong) DButton *payBtn;
@property (nonatomic, strong) UILabel *remainTimeLabel;
@property (nonatomic, strong) DImageV *remainTimeIcon;
@property (nonatomic, strong) NSString *remainTimeStr;
@property (nonatomic, assign) long long remainTimeLong;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HWCommondityView

- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
}

- (void)invalidaTimer
{
    [_timer invalidate];
    _timer = nil;
}

- (instancetype)initWithFrame:(CGRect)frame model:(HWCommondityModel *)model
{
    self = [super initWithFrame:frame];
    if (self) {
        _model = model;
        
        [self timerStart];
        [self loadDataUI];
    }
    return self;
}

- (void)loadDataUI
{
    [_mainView removeFromSuperview];
    _mainView = nil;
    _mainView = [[DView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _mainView.backgroundColor = THEME_COLOR_White;
    
    DImageV *contentImgV = [DImageV imagV:nil frameX:0 y:0 w:kScreenWidth h:CONTENT_HEIGHT - 70];
    contentImgV.contentMode = UIViewContentModeScaleAspectFill;
    contentImgV.clipsToBounds = YES;
    
    NSString *goodImgStr;
    if (IPHONE5)
    {
        goodImgStr = _model.smallImg;
    }
    else
    {
        goodImgStr = _model.orderBigImg;
    }
    
    __weak UIImageView *weakImgV = contentImgV;
    [contentImgV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:goodImgStr]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        if (error != nil)
        {
            weakImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
        else
        {
            weakImgV.image = image;
        }
    }];
    [_mainView addSubview:contentImgV];
    
    CGFloat descriptH = [Utility calculateStringHeight:_model.goodsRemark font:FONT(TF16) constrainedSize:CGSizeMake(kScreenWidth - 2 * 10, 100000)].height;
    
    CGFloat goodNameH = [Utility calculateStringHeight:_model.goodsName font:FONT(TF16) constrainedSize:CGSizeMake(kScreenWidth - 2 * 10, 100000)].height;
    
    DView *goodInfoBackView = [DView viewFrameX:0 y:CONTENT_HEIGHT- 70 - 9 - descriptH - goodNameH - 9 - 5 w:kScreenWidth h:9 + descriptH + goodNameH + 9 + 5];
    goodInfoBackView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
    [_mainView addSubview:goodInfoBackView];
    
    DLable *gooNameLab = [DLable LabTxt:_model.goodsName txtFont:TF16 txtColor:THEME_COLOR_White frameX:10 y:7 w:kScreenWidth - 2 * 10 h:goodNameH];
    [goodInfoBackView addSubview:gooNameLab];
    
    DLable *descriptionLab = [DLable LabTxt:_model.goodsRemark txtFont:TF16 txtColor:THEME_COLOR_White frameX:10 y:CGRectGetMaxY(gooNameLab.frame) + 5 w:kScreenWidth - 2 * 10 h:descriptH];
    [goodInfoBackView addSubview:descriptionLab];
    
    DImageV *authImg = [DImageV imagV:@"仅限认证用户" frameX:kScreenWidth - 70 y:0 w:70 h:70];
    [_mainView addSubview:authImg];
    authImg.hidden = !_model.isAuthBuy.boolValue;
    
    DImageV *soldedImgV = [DImageV imagV:@"已售" frameX:15 y:CGRectGetMaxY(contentImgV.frame) + 16 w:16 h:15];
    [_mainView addSubview:soldedImgV];
    
    CGFloat width = 0;
    if ([_model.showSurplus isEqualToString:@"1"])
    {
        NSString *leftStr = _model.surplusStock.length > 0 ? _model.surplusStock : @"0";
        leftStr = [NSString stringWithFormat:@"剩余库存%@份", leftStr];
        width = [Utility calculateStringWidth:leftStr font:FONT(TF13) constrainedSize:CGSizeMake(10000, 15)].width;
        DLable *soldedLab = [DLable LabTxt:leftStr txtFont:TF13 txtColor:THEME_COLOR_TEXT frameX:CGRectGetMaxX(soldedImgV.frame) + 6 y:CGRectGetMinY(soldedImgV.frame) + 1.5f w:width h:15];
        [_mainView addSubview:soldedLab];
    }
    else
    {
        NSString *soldedStr = _model.buyGoodsCount.length > 0 ? _model.buyGoodsCount : @"0";
        soldedStr = [NSString stringWithFormat:@"已售%@份", soldedStr];
        width = [Utility calculateStringWidth:soldedStr font:FONT(TF13) constrainedSize:CGSizeMake(10000, 15)].width;
        DLable *soldedLab = [DLable LabTxt:soldedStr txtFont:TF13 txtColor:THEME_COLOR_TEXT frameX:CGRectGetMaxX(soldedImgV.frame) + 6 y:CGRectGetMinY(soldedImgV.frame) + 1.5f w:width h:15];
        [_mainView addSubview:soldedLab];
    }
    
    _remainTimeIcon = [DImageV imagV:@"剩余倒计时" frameX:15 y:CGRectGetMaxY(soldedImgV.frame) + 11 w:13.5 h:15];
    [_mainView addSubview:_remainTimeIcon];
    
    DLable *remainLab = [DLable LabTxt:_remainTimeStr txtFont:TF13 txtColor:THEME_COLOR_ORANGE frameX:CGRectGetMaxX(_remainTimeIcon.frame) + 6 y:CGRectGetMinY(_remainTimeIcon.frame) + 1 w:kScreenWidth h:15];
    [_mainView addSubview:remainLab];
    _remainTimeLabel = remainLab;
    
    if (!([_model.showDistanceStartTime isEqualToString:@"1"] || [_model.showDistanceEndTime isEqualToString:@"1"]))
    {
        _remainTimeLabel.hidden = YES;
        _remainTimeIcon.hidden = YES;
    }
    else
    {
        _remainTimeLabel.hidden = NO;
        _remainTimeIcon.hidden = NO;
    }
    
    _payBtn = [DButton btnTxt:@"" txtFont:TF17 frameX:kScreenWidth - 8 - 95 y:CGRectGetMaxY(contentImgV.frame) + 13 w:95.0f h:45.0f target:self action:@selector(showGoodsDetail)];
    [self setPayBtnStatus:[_model.status integerValue]];
    [_payBtn setRadius:8];
    [_mainView addSubview:_payBtn];
    
    NSString *sellPriceStr = _model.sellPrice.length > 0 ? _model.sellPrice : @"0";
    sellPriceStr = [NSString stringWithFormat:@"￥%@", sellPriceStr];
    width = [Utility calculateStringWidth:sellPriceStr font:FONT(TF22) constrainedSize:CGSizeMake(10000, 30)].width;
    DLable *sellPriceLab = [DLable LabTxt:sellPriceStr txtFont:TF22 txtColor:THEME_COLOR_RED frameX:CGRectGetMinX(_payBtn.frame) - 15 - width y:CGRectGetMaxY(contentImgV.frame)+ 8 w:width h:30];
    sellPriceLab.backgroundColor = [UIColor clearColor];
    [_mainView addSubview:sellPriceLab];
    
    NSString *marketPriceStr = _model.marketPrice.length > 0 ? [NSString stringWithFormat:@"￥%@", _model.marketPrice] : @"";
    width = [Utility calculateStringWidth:marketPriceStr font:FONT(TF15) constrainedSize:CGSizeMake(10000, 30)].width;
    DLable *marketLab = [DLable LabTxt:marketPriceStr
                               txtFont:TF15
                              txtColor:THEME_COLOR_TEXT
                                frameX:CGRectGetMinX(_payBtn.frame) - 15 - width
                                     y:CGRectGetMaxY(sellPriceLab.frame) + 4
                                     w:width
                                     h:16];
    marketLab.backgroundColor = [UIColor clearColor];
    [_mainView addSubview:marketLab];
    
    CALayer *redLine = [DView layerFrameX:CGRectGetMinX(marketLab.frame) + 2 y:CGRectGetMaxY(marketLab.frame) - 8 w:width h:0.5f];
    redLine.backgroundColor = THEME_COLOR_RED.CGColor;
    [_mainView.layer addSublayer:redLine];
    
    [Utility bottomLine:_mainView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGoodsDetail)];
    [_mainView addGestureRecognizer:tap];
    
    [self addSubview:_mainView];
}

- (void)timerStart
{
    if ([_model.status isEqualToString:@"0"] || [_model.status isEqualToString:@"1"]) //(0即将开始,1进行中,2已售完，3已下架，4未知状态)
    {
        _remainTimeLabel.hidden = NO;
        _remainTimeIcon.hidden = NO;
        
        long long serverCurrentTime = [_model.currentTime longLongValue];
        if ([_model.status isEqualToString:@"1"])
        {
            if ([_model.showDistanceEndTime isEqualToString:@"1"])
            {
                long long serverEndTime = [_model.endTime longLongValue];
                _remainTimeLong = (serverEndTime - serverCurrentTime) / 1000;
                [self startTimerFire];
                
                _remainTimeStr = [Utility calculateRemainedTimeWithTimeInterval:_remainTimeLong];
                _remainTimeLabel.text = _remainTimeStr;
            }
            else
            {
                _remainTimeLabel.hidden = YES;
                _remainTimeIcon.hidden = YES;
            }
        }
        else
        {
            if ([_model.showDistanceStartTime isEqualToString:@"1"])
            {
                long long serverStartTime = [_model.startTime longLongValue];
                _remainTimeLong = (serverStartTime - serverCurrentTime) / 1000;
                [self startTimerFire];
                
                _remainTimeStr = [Utility calculateRemainedTimeWithTimeInterval:_remainTimeLong];
                _remainTimeLabel.text = _remainTimeStr;
            }
            else
            {
                _remainTimeLabel.hidden = YES;
                _remainTimeIcon.hidden = YES;
            }
        }
    }
    else
    {
        _remainTimeLabel.hidden = YES;
        _remainTimeIcon.hidden = YES;
    }
}

- (void)startTimerFire
{
    [_timer invalidate];
    _timer = nil;
    
    long long serverCurrentTime = [_model.currentTime longLongValue];
    if ([_model.status isEqualToString:@"1"])
    {
        long long serverEndTime = [_model.endTime longLongValue];
        _remainTimeLong = (serverEndTime - serverCurrentTime) / 1000;
    }
    else
    {
        long long serverStartTime = [_model.startTime longLongValue];
        _remainTimeLong = (serverStartTime - serverCurrentTime) / 1000;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                              target:self
                                            selector:@selector(updateTimer)
                                            userInfo:nil
                                             repeats:YES];
    //MYP add 防止tableview滚动时对timer的干扰
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)updateTimer
{
    if (_remainTimeLong <= 0)
    {
        [_timer invalidate];
        _timer = nil;
        [self timerEndAction];
        return;
    }
    _remainTimeLong--;
    _remainTimeStr = [Utility calculateRemainedTimeWithTimeInterval:_remainTimeLong];
    _remainTimeLabel.text = _remainTimeStr;
    
    CGFloat width = [Utility calculateStringWidth:_remainTimeStr
                                             font:FONT(TF13)
                                  constrainedSize:CGSizeMake(10000, 14)].width;
    _remainTimeLabel.width = width;
}

- (void)timerEndAction  //(0即将开始,1进行中,2已售完，3已下架，4未知状态)
{
    if ([_model.status isEqualToString:@"0"])
    {
        _model.currentTime = _model.startTime;
        _model.status = @"1";
        [self timerStart];
        [self loadDataUI];
    }
    else if ([_model.status isEqualToString:@"1"])
    {
        _model.status = @"3";
        [self loadDataUI];
        _remainTimeLabel.hidden = YES;
        _remainTimeIcon.hidden = YES;
        if (self.rdelegate && [self.rdelegate respondsToSelector:@selector(timerEndAction)])
        {
            [self.rdelegate timerEndAction];
        }
    }
}

- (void)showGoodsDetail
{
    if (self.rdelegate && [self.rdelegate respondsToSelector:@selector(showGoodsDetailWithModel:)])
    {
        [self.rdelegate showGoodsDetailWithModel:self.model];
    }
}

- (void)setPayBtnStatus:(HWCommondityStatus)status
{
    switch (status)//(0即将开始,1进行中,2已售完，3已下架，4未知状态)
    {
        case HWCommondityStatusWillStarting:
        {
            [_payBtn setTitle:@"即将开始" forState:UIControlStateNormal];
            [_payBtn setStyle:DBtnStyleMain];
            _payBtn.userInteractionEnabled = NO;
        }
            break;
        case HWCommondityStatusSelling:
        {
            [_payBtn setTitle:@"立即购买" forState:UIControlStateNormal];
            [_payBtn setStyle:DBtnStyleRed];
        }
            break;
        case HWCommondityStatusSellOut:
        {
            [_payBtn setTitle:@"已售完" forState:UIControlStateNormal];
            [_payBtn setStyle:DBtnStyleDisabled];
        }
            break;
        case HWCommondityStatusOff:
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

@end
