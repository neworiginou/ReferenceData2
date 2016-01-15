//
//  HWCutPriceCell.h
//  Community
//
//  Created by lizhongqiang on 15/4/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"
#import "HWCutPriceModel.h"

@interface HWCutPriceCell : HWBaseTableViewCell

@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *detail;
@property (nonatomic, strong) UIImageView *onlyPriceImg;
@property (nonatomic, strong) UIImageView *onlyPriceDot;

- (void)setCellWithModel:(HWCutPriceModel *)model;

@end
