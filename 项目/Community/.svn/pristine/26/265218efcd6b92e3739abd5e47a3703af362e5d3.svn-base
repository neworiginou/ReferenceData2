//
//  HWBankCell.m
//  HaoWu_4.0
//
//  Created by zhuming on 14-5-31.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBankCell.h"

@implementation HWBankCell

@synthesize iconImageView;
@synthesize bankNameLabel;
@synthesize lineView;
/*
- (instancetype) init {
    id obj = loadObjectFromNib(@"HWBankCell", [HWBankCell class], self);
    if (obj) {
        self = (HWBankCell *)obj;
    } else {
        self = [self init];
    }
    _iconImageView.layer.cornerRadius = 5.0;
    _iconImageView.layer.masksToBounds = YES;
    _BankName_label.font = [UIFont fontWithName:FONTNAME size:14];
    _line_view.frame = CGRectMake(12, 49.5f, 308, 0.5f);
    _line_view.backgroundColor = [Utility customBorderColor];
    return self;
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 30, 30)];
        iconImageView.layer.cornerRadius = 5.0;
        iconImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:iconImageView];
        
        bankNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame) + 15.0f, 10, kScreenWidth - CGRectGetMaxX(iconImageView.frame) - 30.0f, 30.0f)];
        bankNameLabel.backgroundColor = [UIColor clearColor];
        bankNameLabel.font = [UIFont fontWithName:FONTNAME size:15.0f];
        bankNameLabel.textColor = THEME_COLOR_SMOKE;
        [self.contentView addSubview:bankNameLabel];
        
        lineView = [[UIView alloc] initWithFrame:CGRectMake(15.0f, 49.5f, kScreenWidth - 15.0f, 0.5f)];
        lineView.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:lineView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
