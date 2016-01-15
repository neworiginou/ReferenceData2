//
//  HWGetPrizeCell.h
//  Community
//
//  Created by caijingpeng.haowu on 14-12-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWContentImageView.h"
#import "HWWinnerModel.h"
#import "HWShowOrderModel.h"
#import "HWAddressModel.h"
#import "HWDetailOrderModel.h"

typedef enum
{
    NoPrizeStatus = 0,   //未领取状态
    GetPrizeStatus,     // 已领取 未晒单状态
    ShowPrizeStatus     // 晒单状态
    
} PrizeStatus;

@protocol HWGetPrizeCellDelegate <NSObject>

- (void)didClickGetButton;
- (void)didCLickShowButton;
- (void)showToWuDiXianChannel;

@end

@interface HWGetPrizeCell : UITableViewCell

@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UIView *getPrizeView;     //领取 view
@property (nonatomic, strong) UILabel *infoLab;         //提示领取商品
@property (nonatomic, strong) UIButton *prizeButton;    //领取按钮

@property (nonatomic, strong) UIView *orderView;
@property (nonatomic, strong) UILabel *orderInfoLab;
@property (nonatomic, strong) UILabel *orderStatusLab;
@property (nonatomic, strong) UILabel *dateLab;

@property (nonatomic, strong) UILabel *addressLab;
@property (nonatomic, strong) UIView *seperateLine;

@property (nonatomic, strong) UILabel *showTitLab;      // 晒单有奖
@property (nonatomic, strong) UIButton *showButton;     // 晒单按钮
@property (nonatomic, strong) HWContentImageView *showImgV;    // 晒单图片
@property (nonatomic, strong) UILabel *showCtntLab;     // 晒单内容
@property (nonatomic, strong) UILabel *showDateLab;     // 晒单日期
@property (nonatomic, strong) UIView *downLine;

@property (nonatomic, assign) PrizeStatus itemPrizeStatus;

@property (nonatomic, assign) id<HWGetPrizeCellDelegate> delegate;

- (void)setWinner:(HWWinnerModel *)winnerModel showOrder:(HWShowOrderModel *)showModel address:(HWAddressModel *)addressModel order:(HWDetailOrderModel *)orderModel;

+ (float)getWinner:(HWWinnerModel *)winnerModel showOrder:(HWShowOrderModel *)showModel address:(HWAddressModel *)addressModel order:(HWDetailOrderModel *)orderModel prizeStatus:(PrizeStatus)status;

@end
