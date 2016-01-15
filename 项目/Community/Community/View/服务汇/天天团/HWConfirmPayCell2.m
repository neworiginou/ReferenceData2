//
//  HWConfirmPayCell2.m
//  Community
//
//  Created by hw500029 on 15/8/5.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWConfirmPayCell2.h"

@implementation HWConfirmPayCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self loadUI];
    }
    return self;
}

- (void)loadUI
{
    _cargoNameLabel = [UILabel newAutoLayoutView];
    _cargoNameLabel.backgroundColor = [UIColor clearColor];
    _cargoNameLabel.textColor = THEME_COLOR_SMOKE;
    _cargoNameLabel.font = FONT(TF15);
    [self.contentView addSubview:_cargoNameLabel];
    [_cargoNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:10];
    [_cargoNameLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];
    [_cargoNameLabel autoSetDimension:ALDimensionWidth toSize:kScreenWidth / 2 - 15];
    
    _priceLabel = [UILabel newAutoLayoutView];
    _priceLabel.backgroundColor = [UIColor clearColor];
    _priceLabel.textColor = THEME_COLOR_SMOKE;
    _priceLabel.font = FONT(TF15);
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceLabel];
    [_priceLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:-10];
    [_priceLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];
    [_priceLabel autoSetDimension:ALDimensionWidth toSize:kScreenWidth / 2 - 10 ];
}

- (void)fillDataWithCargoName:(NSString *)name andPrice:(NSString *)price
{
    _cargoNameLabel.text = name;
    
    price = [NSString stringWithFormat:@"应付金额：%@元", price];
    NSMutableAttributedString *str = [Utility setFullStr:price fullStrWithFont:[UIFont fontWithName:FONTNAME size:TF15] fullStrWithColor:THEME_COLOR_SMOKE needChangeStrArray:@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"x", @"."] changeStrWithFont:[UIFont fontWithName:FONTNAME size:TF15] changeStrColor:THEME_COLOR_ORANGE];
    _priceLabel.attributedText = str;
}

@end
