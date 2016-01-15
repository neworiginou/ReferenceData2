//
//  HWGetPrizeCell.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWGetPrizeCell.h"

#define CELL_HEIGHT     45.0f

@implementation HWGetPrizeCell

@synthesize timeLab;
@synthesize detailLab;
@synthesize priceLab;

@synthesize getPrizeView;
@synthesize infoLab;
@synthesize prizeButton;

@synthesize orderView;
@synthesize orderInfoLab;
@synthesize orderStatusLab;
@synthesize dateLab;
@synthesize addressLab;
@synthesize seperateLine;

@synthesize showTitLab;
@synthesize showButton;
@synthesize showImgV;
@synthesize showCtntLab;
@synthesize showDateLab;
@synthesize downLine;

@synthesize itemPrizeStatus;
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        priceLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70.0f, CELL_HEIGHT)];
        priceLab.backgroundColor = [UIColor clearColor];
        priceLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        priceLab.textColor = THEME_COLOR_MONEY;
        priceLab.adjustsFontSizeToFitWidth = YES;
        //        priceLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:priceLab];
        
        detailLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(priceLab.frame) + 5, 0, kScreenWidth - 85 - CGRectGetMaxX(priceLab.frame) - 5, CELL_HEIGHT)];
        detailLab.backgroundColor = [UIColor clearColor];
        detailLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        detailLab.textColor = THEME_COLOR_SMOKE;
        [self.contentView addSubview:detailLab];
        
        timeLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 80, 0, 75, CELL_HEIGHT)];
        timeLab.backgroundColor = [UIColor clearColor];
        timeLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        timeLab.textColor = THEME_COLOR_TEXT;
        timeLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:timeLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CELL_HEIGHT - 0.5f, kScreenWidth, 0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:line];
        
        // ************  未领取状态  *********
        
        getPrizeView = [[UIView alloc] initWithFrame:CGRectMake(0, CELL_HEIGHT, kScreenWidth, CELL_HEIGHT)];
        getPrizeView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:getPrizeView];
        
        infoLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 10 - 75 - 10, CELL_HEIGHT)];
        infoLab.backgroundColor = [UIColor clearColor];
        infoLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        infoLab.textColor = THEME_COLOR_SMOKE;
        infoLab.text = @"领取商品并确认收货地址";
        [getPrizeView addSubview:infoLab];
        
        prizeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        prizeButton.frame = CGRectMake(kScreenWidth - 10 - 75, (CELL_HEIGHT - 30) / 2.0f, 75, 30);
        [prizeButton setButtonOrangeStyle];
        [prizeButton setTitle:@"领取" forState:UIControlStateNormal];
        prizeButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        [prizeButton addTarget:self action:@selector(toClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [getPrizeView addSubview:prizeButton];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, CELL_HEIGHT - 0.5f, kScreenWidth, 0.5f)];
        line1.backgroundColor = THEME_COLOR_LINE;
        [getPrizeView addSubview:line1];
        
        // **********  领取过商品  ********
        
        orderView = [[UIView alloc] initWithFrame:CGRectMake(0, CELL_HEIGHT, kScreenWidth, CELL_HEIGHT)];
        orderView.backgroundColor = BACKGROUND_COLOR;
        [self.contentView addSubview:orderView];
        
        orderInfoLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30 - 90 - 30, 35)];
        orderInfoLab.backgroundColor = [UIColor clearColor];
        orderInfoLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL - 2];
        orderInfoLab.textColor = THEME_COLOR_TEXT;
        [orderView addSubview:orderInfoLab];

        orderStatusLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 120, 0, 45.0f, 35.0f)];
        orderStatusLab.backgroundColor = [UIColor clearColor];
        orderStatusLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL - 2];
        orderStatusLab.textColor = THEME_COLOR_SMOKE;
        [orderView addSubview:orderStatusLab];
        
        dateLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 80, 0, 75, 35)];
        dateLab.backgroundColor = [UIColor clearColor];
        dateLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL - 2];
        dateLab.adjustsFontSizeToFitWidth = YES;
        dateLab.textColor = THEME_COLOR_TEXT;
        [orderView addSubview:dateLab];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(orderInfoLab.frame) - 0.5f, kScreenWidth - 30, 0.5f)];
        line2.backgroundColor = THEME_COLOR_LINE;
        [orderView addSubview:line2];
        
        addressLab = [[UILabel alloc] initWithFrame:CGRectZero];
        addressLab.backgroundColor = [UIColor clearColor];
        addressLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        addressLab.textColor = THEME_COLOR_SMOKE;
        addressLab.numberOfLines = 0;
        addressLab.lineBreakMode = NSLineBreakByWordWrapping;
        [orderView addSubview:addressLab];
        
        seperateLine = [[UIView alloc] initWithFrame:CGRectZero];
        seperateLine.backgroundColor = THEME_COLOR_LINE;
        [orderView addSubview:seperateLine];
        
        showTitLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 45.0f)];
        showTitLab.backgroundColor = [UIColor clearColor];
        showTitLab.textColor = THEME_COLOR_SMOKE;
        showTitLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        showTitLab.text = @"晒单有奖";
        [orderView addSubview:showTitLab];
        
        showButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [showButton setTitle:@"晒单" forState:UIControlStateNormal];
        [showButton addTarget:self action:@selector(toClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [orderView addSubview:showButton];
        
        showImgV = [[HWContentImageView alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 150)];
        showImgV.contentMode = UIViewContentModeScaleAspectFit;
        showImgV.backgroundColor = [UIColor clearColor];
        showImgV.userInteractionEnabled = YES;
        [orderView addSubview:showImgV];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showToWuDiXianChannel)];
        [showImgV addGestureRecognizer:tap];
        
        showDateLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 30)];
        showDateLab.backgroundColor = [UIColor clearColor];
        showDateLab.textColor = THEME_COLOR_TEXT;
        showDateLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL - 2];
        [orderView addSubview:showDateLab];
        
        downLine = [[UIView alloc] initWithFrame:CGRectZero];
        downLine.backgroundColor = THEME_COLOR_LINE;
        [orderView addSubview:downLine];
        
    }
    return self;
}

- (void)setWinner:(HWWinnerModel *)winnerModel showOrder:(HWShowOrderModel *)showModel address:(HWAddressModel *)addressModel order:(HWDetailOrderModel *)orderModel
{
    NSString *addressStr = orderModel.address;
    NSString *showString = showModel.showContent;
    
//    priceLab.text = @"￥10.64";
    detailLab.text = @"最低唯一价";
//    timeLab.text = @"12:21:12";
    
    priceLab.text = [NSString stringWithFormat:@"￥%.2f",winnerModel.cutPrice.floatValue];
    timeLab.text = [Utility getHourTimeWithTimestamp:winnerModel.createTime];
    
    if (self.itemPrizeStatus == NoPrizeStatus)
    {
        orderView.hidden = YES;
        getPrizeView.hidden = NO;
    }
    else if (self.itemPrizeStatus == GetPrizeStatus)
    {
        orderView.hidden = NO;
        getPrizeView.hidden = YES;
//        orderInfoLab.text = @"订单号：123412341234123412";
        orderStatusLab.text = @"已领取";
//        dateLab.text = @"10-19";
        
        orderInfoLab.text = [NSString stringWithFormat:@"订单号：%@", orderModel.orderId];
        dateLab.text = [[orderModel.createTimeStr componentsSeparatedByString:@" "] pObjectAtIndex:0];
        
        CGSize addressSize = [Utility calculateStringHeight:addressStr font:addressLab.font constrainedSize:CGSizeMake(kScreenWidth - 30, 1000)];
        addressLab.frame = CGRectMake(15, CGRectGetMaxY(orderInfoLab.frame) + 10, kScreenWidth - 30, addressSize.height);
        addressLab.text = addressStr;
        seperateLine.frame = CGRectMake(15, CGRectGetMaxY(addressLab.frame) + 10 - 0.5f, kScreenWidth - 30, 0.5f);
        
        showTitLab.hidden = NO;
        showButton.hidden = NO;
        showImgV.hidden = YES;
        showDateLab.hidden = YES;
        seperateLine.hidden = NO;
        
        showTitLab.frame = CGRectMake(15, CGRectGetMaxY(seperateLine.frame), 80, 45.0f);
        showButton.frame = CGRectMake(kScreenWidth - 10 - 75, showTitLab.center.y - 15.0f, 75, 30);
        [showButton setButtonOrangeStyle];
        showButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        
        downLine.frame = CGRectMake(0, addressSize.height + 35.0f + 20.0f + 45.0f - 0.5f, kScreenWidth, 0.5f);
        
        orderView.frame = CGRectMake(0, CELL_HEIGHT, kScreenWidth, CGRectGetMaxY(downLine.frame));
    }
    else if (self.itemPrizeStatus == ShowPrizeStatus)
    {
        orderView.hidden = NO;
        getPrizeView.hidden = YES;
//        orderInfoLab.text = @"订单号：123412341234123412";
        orderStatusLab.text = @"已领取";
//        dateLab.text = @"10-19";
//        showDateLab.text = @"晒单日期：2014-2-2";
        
        orderInfoLab.text = [NSString stringWithFormat:@"订单号：%@", orderModel.orderId];
        dateLab.text = [[orderModel.createTimeStr componentsSeparatedByString:@" "] pObjectAtIndex:0];
        showDateLab.text = [NSString stringWithFormat:@"晒单日期：%@", [Utility getTimeWithTimestamp:showModel.createTime]];
        
        CGSize addressSize = [Utility calculateStringHeight:addressStr font:addressLab.font constrainedSize:CGSizeMake(kScreenWidth - 30, 1000)];
        addressLab.frame = CGRectMake(15, CGRectGetMaxY(orderInfoLab.frame) + 10, kScreenWidth - 30, addressSize.height);
        addressLab.text = addressStr;
        
        showTitLab.hidden = YES;
        showButton.hidden = YES;
        showImgV.hidden = NO;
        showDateLab.hidden = NO;
        seperateLine.hidden = YES;
        
        CGRect frame = showImgV.frame;
        frame.origin.y = CGRectGetMaxY(addressLab.frame) + 10;
        showImgV.frame = frame;
        
        showImgV.contentString = showString;
        
        CGRect frame1 = showDateLab.frame;
        frame1.origin.y = CGRectGetMaxY(showImgV.frame);
        showDateLab.frame = frame1;
        
        __weak UIImageView *weakimgV = showImgV;
        NSLog(@"%@",[Utility imageDownloadUrl:showModel.mongodbKey]);
        [showImgV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:showModel.mongodbKey]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
            if (error != nil)
            {
                weakimgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
            }
            else
            {
                weakimgV.image = image;
            }
        }];
        
        downLine.frame = CGRectMake(0, addressSize.height + 35.0f + 20.0f + 30.0f + 150.0f - 0.5f, kScreenWidth, 0.5f);
        orderView.frame = CGRectMake(0, CELL_HEIGHT, kScreenWidth, CGRectGetMaxY(downLine.frame));
    }
    
    
}

+ (float)getWinner:(HWWinnerModel *)winnerModel showOrder:(HWShowOrderModel *)showModel address:(HWAddressModel *)addressModel order:(HWDetailOrderModel *)orderModel prizeStatus:(PrizeStatus)status
{
    NSString *addressStr = orderModel.address;
    
    if (status == NoPrizeStatus)
    {
        return 45.0f + 45.0f;
    }
    else if (status == GetPrizeStatus)
    {
        CGSize addressSize = [Utility calculateStringHeight:addressStr font:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG] constrainedSize:CGSizeMake(kScreenWidth - 30, 1000)];
        return (addressSize.height + CELL_HEIGHT + 35.0f + 20.0f + 45.0f);
    }
    else if (status == ShowPrizeStatus)
    {
        CGSize addressSize = [Utility calculateStringHeight:addressStr font:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG] constrainedSize:CGSizeMake(kScreenWidth - 30, 1000)];
        return (addressSize.height + CELL_HEIGHT + 35.0f + 20.0f + 30.0f + 150.0f);
    }
    
    return 0;
}

- (void)toClickButton:(UIButton *)sender
{
    if (sender == showButton)
    {
        [MobClick event:@"click_show my goods"];
        if (delegate && [delegate respondsToSelector:@selector(didCLickShowButton)])
        {
            [delegate didCLickShowButton];
        }
    }
    else if (sender == prizeButton)
    {
        [MobClick event:@"click_sure for pay"];
        
        if (delegate && [delegate respondsToSelector:@selector(didClickGetButton)])
        {
            [delegate didClickGetButton];
        }
    }
}

- (void)showToWuDiXianChannel
{
    //1.3.0版添加 由于图片和邻里圈比例不一致暂时取消跳转功能
//    if (self.delegate && [self.delegate respondsToSelector:@selector(showToWuDiXianChannel)])
//    {
//        [self.delegate showToWuDiXianChannel];
//    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
