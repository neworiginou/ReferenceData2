//
//  RemaiderTableViewCell.m
//  Community
//
//  Created by hw500028 on 14/12/9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "RemaiderTableViewCell.h"
#import "UIViewExt.h"
@implementation RemaiderTableViewCell
@synthesize moneyLabel;
- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


#pragma mark -- Views

- (void)initViews
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 44)];
    label.text = @"待支付金额";
    [self.contentView addSubview:label];

    moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 0, 100, 44)];
//    moneyLabel.text = [NSString stringWithFormat:@"￥%@",payMoney];
    moneyLabel.font = [UIFont fontWithName:FONTNAME size:15.0f];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.textColor = THEME_COLOR_MONEY;
    [self.contentView addSubview:moneyLabel];
    
}

@end
