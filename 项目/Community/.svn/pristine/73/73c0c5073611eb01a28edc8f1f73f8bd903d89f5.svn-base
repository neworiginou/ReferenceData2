//
//  HWServiceListDetailStatusCell.m
//  Community
//
//  Created by hw500027 on 15/6/18.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWServiceListDetailStatusCell.h"

@interface HWServiceListDetailStatusCell()
{
    UIView *_lineView;
    UIImageView *_pointImgView;
    UIView *_bottomLineView;
}
@end

@implementation HWServiceListDetailStatusCell

+ (NSString *)reuseID
{
    return @"HWServiceListDetailStatusCell";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _statusInfoLabel = [UILabel newAutoLayoutView];
        [self.contentView addSubview:_statusInfoLabel];
        _statusInfoLabel.numberOfLines = 0;
        [_statusInfoLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:55];
        [_statusInfoLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:20];
        _statusInfoLabel.font = FONT(14);
        _statusInfoLabel.textColor = THEME_COLOR_TEXT;
        [_statusInfoLabel setPreferredMaxLayoutWidth:kScreenWidth - 55 - 15];
        
        _statusTimeLabel = [UILabel newAutoLayoutView];
        [self.contentView addSubview:_statusTimeLabel];
        [_statusTimeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:55];
        [_statusTimeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_statusInfoLabel withOffset:12];
        [_statusTimeLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView withOffset:-12];
        _statusTimeLabel.font = FONT(14);
        _statusTimeLabel.textColor = THEME_COLOR_TEXT;
        
        //竖线
        _lineView = [UIView newAutoLayoutView];
        [self.contentView addSubview:_lineView];
        [_lineView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView];
        [_lineView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView];
        [_lineView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:33];
        [_lineView autoSetDimension:ALDimensionWidth toSize:1];
        _lineView.backgroundColor = THEME_COLOR_LINE;
        
        //圆点
        _pointImgView = [UIImageView newAutoLayoutView];
        [self.contentView addSubview:_pointImgView];
        _pointImgView.image = [UIImage imageNamed:@"icon_16_07"];
        [_pointImgView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_statusInfoLabel withOffset:2];
        [_pointImgView autoAlignAxis:ALAxisVertical toSameAxisOfView:_lineView];
        
        //底部横线
        _bottomLineView = [UIView newAutoLayoutView];
        [self.contentView addSubview:_bottomLineView];
        [_bottomLineView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:55];
        [_bottomLineView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:0];
        [_bottomLineView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView withOffset:0];
        [_bottomLineView autoSetDimension:ALDimensionHeight toSize:0.5f];
        _bottomLineView.backgroundColor = THEME_COLOR_LINE;
    }
    return self;
}

- (void)changeBottomLine
{
    [_bottomLineView autoRemoveConstraintsAffectingView];
    [_bottomLineView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:0];
    [_bottomLineView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:0];
    [_bottomLineView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView withOffset:0];
    [_bottomLineView autoSetDimension:ALDimensionHeight toSize:0.5f];

}

- (void)normalBottomLine
{
    [_bottomLineView autoRemoveConstraintsAffectingView];
    [_bottomLineView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:55];
    [_bottomLineView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:0];
    [_bottomLineView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView withOffset:0];
    [_bottomLineView autoSetDimension:ALDimensionHeight toSize:0.5f];

}

- (void)unChangeSetting
{
    [_lineView autoRemoveConstraintsAffectingView];
    [_lineView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView];
    [_lineView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView];
    [_lineView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:33];
    [_lineView autoSetDimension:ALDimensionWidth toSize:1];
    
    [_pointImgView autoRemoveConstraintsAffectingView];
    _pointImgView.image = [UIImage imageNamed:@"icon_16_07"];
    [_pointImgView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_statusInfoLabel withOffset:2];
    [_pointImgView autoAlignAxis:ALAxisVertical toSameAxisOfView:_lineView];
    
    _statusInfoLabel.textColor = THEME_COLOR_TEXT;
    _statusTimeLabel.textColor = THEME_COLOR_TEXT;
}

- (void)changeSetting
{
    [_lineView autoRemoveConstraintsAffectingView];
    [_lineView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_statusInfoLabel withOffset:5];
    [_lineView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView];
    [_lineView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:33];
    [_lineView autoSetDimension:ALDimensionWidth toSize:1];
    
    [_pointImgView autoRemoveConstraintsAffectingView];
    _pointImgView.image = [UIImage imageNamed:@"icon_16_06"];
    [_pointImgView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_statusInfoLabel withOffset:2];
    [_pointImgView autoAlignAxis:ALAxisVertical toSameAxisOfView:_lineView];
    
    _statusInfoLabel.textColor = THEME_COLOR_ORANGE;
    _statusTimeLabel.textColor = THEME_COLOR_ORANGE;
}


- (void)fillDataWithDict:(NSDictionary *)dict
{
    _statusInfoLabel.textColor = THEME_COLOR_TEXT;
    _statusTimeLabel.textColor = THEME_COLOR_TEXT;
    
    NSString *operation = [dict stringObjectForKey:@"operation"];
    if (operation.length == 0)
    {
        _statusInfoLabel.text = [self translateStatus:[dict stringObjectForKey:@"status"]];
    }
    else
    {
        _statusInfoLabel.text = [dict stringObjectForKey:@"operation"];
    }
    _statusTimeLabel.text = [Utility getMinTimeWithTimestamp:[dict stringObjectForKey:@"statusTime"]];
}

- (NSString *)translateStatus:(NSString *)status
{
    if ([status isEqual:@"0"] || [status isEqual:@"2"])
    {
        return @"等待接单";
    }
    else if ([status isEqual:@"3"])
    {
        return @"已接单";
    }
    else if ([status isEqual:@"4"])
    {
        return @"等待支付";
    }
    else
    {
        return @"已完成";
    }
}

@end
