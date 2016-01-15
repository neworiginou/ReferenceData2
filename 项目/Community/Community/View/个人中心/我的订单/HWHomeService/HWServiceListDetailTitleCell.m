//
//  HWServiceListDetailTitleCell.m
//  Community
//
//  Created by hw500027 on 15/6/18.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：我的订单 服务订单 订单详情 顶部灰色cell
//  修改记录：
//	姓名   日期　　　　　　 修改内容
//  陆晓波  2015-01-15    文件创建

#import "HWServiceListDetailTitleCell.h"

#define PADDING     15
@interface HWServiceListDetailTitleCell()
{
    UIImageView *_serviceImageV;
    UILabel *_titleLabel;
    UILabel *_listNumLabel;
    UILabel *_toDoorTimeLabel;
    UIImageView *_serviceTypeImageV;
}
@end

@implementation HWServiceListDetailTitleCell

+ (NSString *)reuseID
{
    return @"HWServiceListDetailTitleCell";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = THEME_COLOR_TEXT;
        self.contentView.backgroundColor = THEME_COLOR_TEXT;
        
        _serviceImageV = [UIImageView newAutoLayoutView];
        [self.contentView addSubview:_serviceImageV];
        _serviceImageV.layer.masksToBounds = YES;
        _serviceImageV.layer.cornerRadius = 3;
        _serviceImageV.backgroundColor = THEME_COLOR_LINE;
        [_serviceImageV autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:PADDING];
        [_serviceImageV autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:PADDING];
        [_serviceImageV autoSetDimensionsToSize:CGSizeMake(54, 54)];
        
        _titleLabel = [UILabel newAutoLayoutView];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.textColor = [UIColor whiteColor];
        [_titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_serviceImageV];
        [_titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_serviceImageV withOffset:7];
        
        _listNumLabel = [UILabel newAutoLayoutView];
        [self.contentView addSubview:_listNumLabel];
        _listNumLabel.font = FONT(14);
        _listNumLabel.textColor = [UIColor whiteColor];
        [_listNumLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLabel];
        [_listNumLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_serviceImageV withOffset:7];
        
        _toDoorTimeLabel = [UILabel newAutoLayoutView];
        [self.contentView addSubview:_toDoorTimeLabel];
        _toDoorTimeLabel.font = FONT(14);
        _toDoorTimeLabel.textColor = [UIColor whiteColor];
        [_toDoorTimeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_listNumLabel];
        [_toDoorTimeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_serviceImageV withOffset:7];

        _serviceTypeImageV = [UIImageView newAutoLayoutView];
        [self.contentView addSubview:_serviceTypeImageV];
        [_serviceTypeImageV autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:0];
        [_serviceTypeImageV autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView withOffset:0];
    }
    return self;
}

- (void)fillDataWithType:(NSInteger)type withModel:(HWServiceListDetailModel *)model
{
    _titleLabel.text = model.serviceName;
    _listNumLabel.text = [NSString stringWithFormat:@"订单号：%@",model.orderId];
    _toDoorTimeLabel.text =[NSString stringWithFormat:@"上门时间：%@ %@",model.serviceTime,model.serviceTimeSection];

    __weak UIImageView *blockImgV = _serviceImageV;
    [_serviceImageV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:model.serviceIcon]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType)
    {
        if (error != nil)
        {
            blockImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
        else
        {
            blockImgV.image = image;
            if (cacheType == 0)
            { // request url
                CATransition *transition = [CATransition animation];
                transition.duration = 1.0f;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionFade;
                [blockImgV.layer addAnimation:transition forKey:nil];
            }
        }
        
    }];
    
    
    //等待接单
    if (type == 0 || type == 1 || type == 2)
    {
        _serviceTypeImageV.image = [UIImage imageNamed:@"label_16_07"];
    }
    //已接单
    else if (type == 3 || type == 4)
    {
        _serviceTypeImageV.image = [UIImage imageNamed:@"label_16_09"];
    }
    //已完成
    else
    {
        _serviceTypeImageV.image = [UIImage imageNamed:@"label_16_08"];
    }
}

@end
