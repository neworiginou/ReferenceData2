//
//  HWMyBargainOrderTableViewCell.h
//  Community
//
//  Created by D on 14/12/9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWMyBargainOrderModel.h"

@interface HWMyBargainOrderTableViewCell : UITableViewCell


@property (nonatomic, strong) UIView * backImg;
@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UILabel * stateLab;
@property (nonatomic, strong) UILabel * unPayLab;
@property (nonatomic, strong) UIButton * payBtn;
@property (nonatomic, strong) UIImageView * img;
@property (nonatomic, strong) UILabel * infoLab;
@property (nonatomic, strong) UILabel * priceTLab;
@property (nonatomic, strong) UILabel * priceLab;
@property (nonatomic, strong) UILabel * numTLab;
@property (nonatomic, strong) UILabel * numLab;
@property (nonatomic, strong) UILabel * lineLab;
@property (nonatomic, strong) UILabel * buttomNumTLab;
@property (nonatomic, strong) UILabel * buttomNumLab;
@property (nonatomic, strong) UILabel * totalPayTLab;
@property (nonatomic, strong) UILabel * totalPayLab;
@property (nonatomic, strong) UILabel * ThirdLineLab;
@property (nonatomic, strong) UILabel * orderNumLab;
@property (nonatomic, strong) UIImageView * lineIm;
@property (nonatomic, strong) HWMyBargainOrderModel *bargainOrderModel;


@property (nonatomic, readwrite) CGFloat subHeight;
@property (nonatomic, copy)void(^comeInPay)(HWMyBargainOrderModel *orderModel);

- (void)showForModel:(HWMyBargainOrderModel *)model;


@end
