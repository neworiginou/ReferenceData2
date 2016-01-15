//
//  HWGoodsListCell.h
//  Community
//
//  Created by lizhongqiang on 15/4/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"
#import "HWGoodsListModel.h"


@protocol HWGoodsListCellDelegate <NSObject>

- (void)setClockWithModel:(HWGoodsListModel *)listModel;

@end


@interface HWGoodsListCell : HWBaseTableViewCell

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *remainMs;


@property (nonatomic, strong) UILabel *name;                    //商品名
@property (nonatomic, strong) UIButton *tipBtn;                 //提醒按钮
@property (nonatomic, strong) UILabel *clockLabel;              //开始倒计时
@property (nonatomic, strong) UIImageView *bgImage;             //背景大图
@property (nonatomic, strong) UIView *alphaView;                //透明背景
@property (nonatomic, strong) UIImageView *timeImage;           //闹钟图
@property (nonatomic, strong) UIImageView *timeList;            //已开始倒计时
@property (nonatomic, strong) UILabel *priceLabel;              //市场价
@property (nonatomic, strong) UIImageView *priceImage;          //市场价背景
@property (nonatomic, strong) UILabel *shicahngjia;             //市场价文字
@property (nonatomic, strong) UILabel *RMB;                     //￥
@property (nonatomic, strong) UIView *bgView;                   //背景
@property (nonatomic, strong) UIImageView *grayView;            //半透明灰色
@property (nonatomic, strong) UIImageView *clockTimeImg;        //活动未开始闹钟
@property (nonatomic, strong) UILabel *countDownLabel;          //结束倒计时(活动已开始)
@property (nonatomic, strong) UIImageView *countDownImage;      //闹钟图
@property (nonatomic, strong) HWGoodsListModel *goodsListModel;
@property (nonatomic, weak) id<HWGoodsListCellDelegate>delegate;
- (void)setCellWithModel:(HWGoodsListModel *)model;


@end
