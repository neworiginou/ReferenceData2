//
//  HWConfirmPayCell1.m
//  Community
//
//  Created by hw500029 on 15/8/5.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWConfirmPayCell1.h"

@implementation HWConfirmPayCell1

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
    UILabel *titleLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 80, 48)];
    titleLabel1.backgroundColor = [UIColor clearColor];
    titleLabel1.font = FONT(TF15);
    titleLabel1.textColor = THEME_COLOR_TEXT;
    titleLabel1.text = @"收 货 人:";
    [self.contentView addSubview:titleLabel1];
    
    UILabel *titleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(titleLabel1.frame), CGRectGetMaxY(titleLabel1.frame), CGRectGetWidth(titleLabel1.frame), CGRectGetHeight(titleLabel1.frame))];
    titleLabel2.backgroundColor = [UIColor clearColor];
    titleLabel2.font = FONT(TF15);
    titleLabel2.textColor = THEME_COLOR_TEXT;
    titleLabel2.text = @"收货地址:";
    [self.contentView addSubview:titleLabel2];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel1.frame), CGRectGetMinY(titleLabel1.frame), 105, CGRectGetHeight(titleLabel1.frame))];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.font = FONT(TF15);
    _nameLabel.textColor = THEME_COLOR_SMOKE;
    [self.contentView addSubview:_nameLabel];
    
    _phoneNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), CGRectGetMinY(_nameLabel.frame), 120, CGRectGetHeight(_nameLabel.frame))];
    _phoneNumLabel.backgroundColor = [UIColor clearColor];
    _phoneNumLabel.font = FONT(TF15);
    _phoneNumLabel.textColor = THEME_COLOR_SMOKE;
    [self.contentView addSubview:_phoneNumLabel];
    
    _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMinY(titleLabel2.frame), kScreenWidth - CGRectGetWidth(titleLabel2.frame) - 20,CGRectGetHeight(titleLabel2.frame))];
    _addressLabel.backgroundColor = [UIColor clearColor];
    _addressLabel.font = FONT(TF15);
    _addressLabel.textColor = THEME_COLOR_SMOKE;
    _addressLabel.numberOfLines = 0;
    [self.contentView addSubview:_addressLabel];
    
    //划线
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(10, 48 - 0.5, kScreenWidth - 20, 0.5)];
    line1.backgroundColor = THEME_COLOR_LINE;
    [self.contentView addSubview:line1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(10, 48 * 2 - 0.5, kScreenWidth - 20, 0.5)];
    line2.backgroundColor = THEME_COLOR_LINE;
    [self.contentView addSubview:line2];
}

-(void)fillDataWithInfo:(HWAddressInfo *)info
{
    _nameLabel.text = info.name;
    _phoneNumLabel.text = info.mobile;
    _addressLabel.text = info.address;
}

@end
