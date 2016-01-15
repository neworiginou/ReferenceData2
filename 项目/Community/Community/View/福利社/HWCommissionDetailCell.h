//
//  HWCommissionDetailCell.h
//  Community
//
//  Created by niedi on 15/1/17.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"
#import "HWCommissionDetailModel.h"

@interface HWCommissionDetailCell : HWBaseTableViewCell

@property (nonatomic, strong) UIImageView * koalaCoinImg;               //头视图
@property (nonatomic, strong) UILabel *commissionTimeLab;               //时间
@property (nonatomic, strong) UILabel *commissionTypeLab;               //类型 消费或激活
@property (nonatomic, strong) UILabel *commissionMoneyLab;              //金额
@property (nonatomic, strong) UILabel *commissionDetailLab;             //佣金比例
@property (nonatomic, strong) UILabel *topLineLab;                      //上边界线
@property (nonatomic, strong) UILabel *buttomLab;                       //下边界线


- (void)setCommissionDetailContent:(HWCommissionDetailSubModel *)model;
+ (float)getCellHeight;

@end
