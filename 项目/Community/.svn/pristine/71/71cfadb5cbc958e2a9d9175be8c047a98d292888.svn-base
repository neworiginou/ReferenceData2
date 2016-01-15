//
//  HWServiceListCell.m
//  Community
//
//  Created by hw500027 on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWServiceListCell.h"

@interface HWServiceListCell()
{
    UILabel *_serviceNameLabel;
    UILabel *_serviceTimeLabel;
    UILabel *_serviceStatus;
    UIButton *_serviceListBtn;
    
    HWServiceListModel *_model;
}
@end

@implementation HWServiceListCell

+ (NSString *)reuseID
{
    return @"HWServiceListCell";
}

+ (CGFloat)cellHeight
{
    return 70;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _serviceNameLabel = [UILabel newAutoLayoutView];
        [self.contentView addSubview:_serviceNameLabel];
        [_serviceNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:15];
        [_serviceNameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:15];
        _serviceNameLabel.font = FONT(15);
        
        _serviceTimeLabel = [UILabel newAutoLayoutView];
        [self.contentView addSubview:_serviceTimeLabel];
        [_serviceTimeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_serviceNameLabel withOffset:0];
        [_serviceTimeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_serviceNameLabel withOffset:9];
        _serviceTimeLabel.font = FONT(14);
        _serviceTimeLabel.textColor = THEME_COLOR_TEXT;
        
        _serviceStatus = [UILabel newAutoLayoutView];
        [self.contentView addSubview:_serviceStatus];
        [_serviceStatus autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:- 15];
        [_serviceStatus autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];
        _serviceStatus.font = FONT(13);
        
        CGSize btnSize = CGSizeMake(130 / 2, 42 / 2);
        _serviceListBtn = [UIButton newAutoLayoutView];
        [self.contentView addSubview:_serviceListBtn];
//        [self configCustomButton:_serviceListBtn btnTitle:@"服务完成" btnSize:btnSize];
        [_serviceListBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:- 10];
        [_serviceListBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView withOffset:- 15];
        [_serviceListBtn autoSetDimensionsToSize:btnSize];
        _serviceListBtn.hidden = YES;
        
    }
    return self;
}

- (void)fillDataWithModel:(HWServiceListModel *)model
{
    _model = model;
    
    _serviceNameLabel.text = model.serviceName;
    
    if ([model.status isEqual: @"5"])
    {
        _serviceTimeLabel.text = [NSString stringWithFormat:@"支付时间：%@",model.payTime];
    }
    else
    {
        _serviceTimeLabel.text = [NSString stringWithFormat:@"上门时间：%@ %@",model.serviceTime,model.serviceTimeSection];
    }
    
    if ([model.status isEqual:@"0"] || [model.status isEqual:@"2"] || [model.status isEqual:@"1"])
    {
        _serviceStatus.text = @"等待接单";
    }
    else if ([model.status isEqual:@"3"])
    {
        _serviceStatus.text = @"已接单";
    }
    else if ([model.status isEqual:@"4"])
    {
        _serviceStatus.text = @"等待支付";
    }
    else if ([model.status isEqual:@"5"])
    {
        _serviceStatus.text = @"服务完成";
    }
    else if ([model.status isEqual:@"6"])
    {
        _serviceStatus.text = @"已取消";
    }
    else
    {
        _serviceStatus.text = @"已评价";
    }
    
    if ([_serviceStatus.text isEqual: @"等待接单"])
    {
        _serviceStatus.textColor = THEBUTTON_RED_NORMAL;
        [_serviceStatus autoRemoveConstraintsAffectingView];
        [_serviceStatus autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:- 15];
        [_serviceStatus autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];
        _serviceListBtn.hidden = YES;
    }
    else if ([_serviceStatus.text isEqual: @"已接单"])
    {
        _serviceStatus.textColor = THEME_COLOR_ORANGE;
        [_serviceStatus autoRemoveConstraintsAffectingView];
        [_serviceStatus autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:- 15];
        [_serviceStatus autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];
        _serviceListBtn.hidden = YES;
    }
    else if ([_serviceStatus.text isEqual: @"等待支付"])
    {
        _serviceStatus.textColor = THEME_COLOR_ORANGE;
        [_serviceStatus autoRemoveConstraintsAffectingView];
        [_serviceStatus autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:- 15];
        [_serviceStatus autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:15];
        _serviceListBtn.hidden = NO;
        [self configCustomButton:_serviceListBtn btnTitle:@"支付" btnSize:[_serviceListBtn systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]];
        [_serviceListBtn removeTarget:self action:@selector(toDiscuss) forControlEvents:UIControlEventTouchUpInside];
        [_serviceListBtn addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
    }
    else if ([_serviceStatus.text isEqual: @"服务完成"])
    {
        _serviceStatus.textColor = THEME_COLOR_TEXT;
        [_serviceStatus autoRemoveConstraintsAffectingView];
        [_serviceStatus autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:- 15];
        [_serviceStatus autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:15];
        _serviceListBtn.hidden = NO;
        [self configCustomButton:_serviceListBtn btnTitle:@"评价" btnSize:[_serviceListBtn systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]];
        [_serviceListBtn removeTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
        [_serviceListBtn addTarget:self action:@selector(toDiscuss) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        _serviceStatus.textColor = THEME_COLOR_TEXT;
        [_serviceStatus autoRemoveConstraintsAffectingView];
        [_serviceStatus autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:- 15];
        [_serviceStatus autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];
        _serviceListBtn.hidden = YES;
    }
}

- (void)toPay
{
    NSLog(@"去支付");
    if (self.delegate && [self.delegate respondsToSelector:@selector(toPayBtnClick:)])
    {
        [self.delegate toPayBtnClick:_model];
    }
}

- (void)toDiscuss
{
    NSLog(@"去评价");
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(evaluateBtnClick:)])
    {
        [self.delegate evaluateBtnClick:_model.orderId];
    }
}

- (void)configCustomButton:(UIButton *)btn btnTitle:(NSString *)btnTitle btnSize:(CGSize)btnSize
{
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 3;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = UIColorFromRGB(0xee9800).CGColor;
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromRGB(0xee9800)forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [btn setBackgroundImage:[Utility imageWithColor:UIColorFromRGB(0xffd200) andSize:btnSize] forState:UIControlStateNormal];
    [btn setBackgroundImage:[Utility imageWithColor:UIColorFromRGB(0xebc200) andSize:btnSize] forState:UIControlStateHighlighted];
}

@end
