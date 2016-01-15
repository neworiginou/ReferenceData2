//
//  HWServiceListDetailNormalInfoCell.m
//  Community
//
//  Created by hw500027 on 15/6/18.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：我的订单 服务订单 订单详情 一般信息cell
//  修改记录：
//	姓名   日期　　　　　　 修改内容
//  陆晓波  2015-01-15    文件创建

#import "HWServiceListDetailNormalInfoCell.h"

@interface HWServiceListDetailNormalInfoCell()
{
    UILabel *_userInfoLabel;
    UILabel *_addressInfoLabel;
}
@end


@implementation HWServiceListDetailNormalInfoCell

+ (NSString *)reuseID
{
    return @"HWServiceListDetailNormalInfoCell";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _userInfoLabel = [UILabel newAutoLayoutView];
        [self.contentView addSubview:_userInfoLabel];
        [_userInfoLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:15];
        [_userInfoLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:10];
        _userInfoLabel.font = FONT(13);
        _userInfoLabel.textColor = THEME_COLOR_TEXT;
        
        _addressInfoLabel = [UILabel newAutoLayoutView];
        [self.contentView addSubview:_addressInfoLabel];
        [_addressInfoLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:15];
        [_addressInfoLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_userInfoLabel withOffset:12];
        _addressInfoLabel.font = FONT(13);
        _addressInfoLabel.textColor = THEME_COLOR_TEXT;

    }
    return self;
}

- (void)fillDataWithModel:(HWServiceListDetailModel *)model
{
    _userInfoLabel.text = [NSString stringWithFormat:@"%@ %@",[model.ownerVo stringObjectForKey:@"name"],[model.ownerVo stringObjectForKey:@"phone"]];
    _addressInfoLabel.text = [model.ownerVo stringObjectForKey:@"address"];
}

@end
