//
//  HWServiceListDetailServicorCell.m
//  Community
//
//  Created by hw500027 on 15/6/18.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWServiceListDetailServicorCell.h"

@interface HWServiceListDetailServicorCell()
{
    UIImageView *_headImgV;
    UILabel *_infoLabel;
    UIButton *_phoneBtn;
    NSString *_phoneNum;
}
@end

@implementation HWServiceListDetailServicorCell

+ (NSString *)reuseID
{
    return @"HWServiceListDetailServicorCell";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _headImgV = [UIImageView newAutoLayoutView];
        [self.contentView addSubview:_headImgV];
        [_headImgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:15];
        [_headImgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];
        [_headImgV autoSetDimensionsToSize:CGSizeMake(35, 35)];
        _headImgV.layer.masksToBounds = YES;
        _headImgV.layer.cornerRadius = 35 / 2.0f;
        
        _infoLabel = [UILabel newAutoLayoutView];
        [self.contentView addSubview:_infoLabel];
        _infoLabel.font = FONT(14);
        [_infoLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_headImgV withOffset:15];
        [_infoLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:- 45];
        [_infoLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];

        _phoneBtn = [UIButton newAutoLayoutView];
        [self.contentView addSubview:_phoneBtn];
        [_phoneBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:- 15];
        [_phoneBtn autoSetDimensionsToSize:CGSizeMake(30, 30)];
        [_phoneBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];
        [_phoneBtn setImage:[UIImage imageNamed:@"housePhone"] forState:UIControlStateNormal];
        [_phoneBtn addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)callPhone
{
    if (_cellDelegate && [_cellDelegate respondsToSelector:@selector(didClickCallPhoneBtn:)])
    {
        [_cellDelegate didClickCallPhoneBtn:_phoneNum];
    }
}

- (void)fillDataWithModel:(HWServiceListDetailModel *)model
{
    _headImgV.backgroundColor = [UIColor orangeColor];
    _infoLabel.text = [NSString stringWithFormat:@"%@ %@",[model.servePersonVo stringObjectForKey:@"name"],[model.servePersonVo stringObjectForKey:@"phone"]];
    _phoneNum = [model.servePersonVo stringObjectForKey:@"phone"];
    
    __weak UIImageView *blockImgV = _headImgV;
    [_headImgV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:[model.servePersonVo stringObjectForKey:@"icon"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType)
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
}

@end
