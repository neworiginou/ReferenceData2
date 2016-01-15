//
//  HWRecommendChannelCell.m
//  Community
//
//  Created by hw500028 on 15/1/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//  功能描述:推荐列表的cell
//      姓名         日期               修改内容
//     杨庆龙     2015-01-15           创建文件
//     杨庆龙     15-01-16             为cell填充内容

#import "HWRecommendChannelCell.h"
#define kCellH        (self.frame.size.height)
#define kBtnH         (kCellH - 10)


@implementation HWRecommendChannelCell
@synthesize model = _model;

+ (HWRecommendChannelCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"cell";
    HWRecommendChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[HWRecommendChannelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.buttomLine = [Utility drawLineWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.contentView addSubview:self.buttomLine];
    }
    return self;
}

- (UIImageView *)headImgV
{
    if (_headImgV == nil)
    {
        _headImgV = [UIImageView newAutoLayoutView];
        [self.contentView addSubview:_headImgV];
        [_headImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15.0f];
        [_headImgV autoSetDimension:ALDimensionHeight toSize:kBtnH relation:NSLayoutRelationEqual];
        [_headImgV autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:_headImgV];
        [_headImgV autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        _headImgV.layer.cornerRadius = kBtnH / 2.0f;
        _headImgV.clipsToBounds = YES;
        _headImgV.backgroundColor = [UIColor clearColor];
    }
    return  _headImgV;
}

//邻居说
- (UILabel *)contentLabel
{
    if (_contentLabel == nil)
    {
        _contentLabel = [UILabel newAutoLayoutView];
        [self.contentView addSubview:_contentLabel];
        //[_contentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.headImgV withOffset:15.0f];
        [_contentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:30.0f + [self.headImgV systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].width];
        [_contentLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView withOffset:-10];
        _contentLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        _contentLabel.textColor = THEME_COLOR_SMOKE;
        _contentLabel.backgroundColor = [UIColor clearColor];
    }
    return _contentLabel;
}

//参加人数
- (UILabel *)partInLabel
{
    if (_partInLabel == nil)
    {
        _partInLabel = [UILabel newAutoLayoutView];
        [self.contentView addSubview:_partInLabel];
        [_createrNameLabel autoAlignAxis:ALAxisBaseline toSameAxisOfView:_partInLabel];
        [_partInLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_contentLabel];
        [_partInLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView withOffset:11];
        [_partInLabel autoSetDimension:ALDimensionWidth toSize:88];
        _partInLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL12];
        _partInLabel.textColor = THEME_COLOR_TEXT;
        _partInLabel.backgroundColor = [UIColor clearColor];
    }
    return _partInLabel;
}

- (UILabel *)createrNameLabel
{
    if (_createrNameLabel == nil)
    {
        _createrNameLabel = [UILabel newAutoLayoutView];
        [self.contentView addSubview:_createrNameLabel];
        [_createrNameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15.0f];
        _createrNameLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL12];
        _createrNameLabel.textColor = THEME_COLOR_GRAY_MIDDLE;
        _createrNameLabel.textAlignment = NSTextAlignmentRight;
        _createrNameLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _createrNameLabel;
}

- (void)setModel:(HWChannelModel *)model
{
    _model = model;
    if (_model)
    {
        [self update];
    }
}

- (void)update
{
    _headImgV.hidden = NO;
    self.contentLabel.text = _model.channelName;
    self.createrNameLabel.text = [_model.createrName isEqualToString:@""] ? @"" : [NSString stringWithFormat:@"创建人:%@", _model.createrName];
    self.partInLabel.text = [_model.partInCount isEqualToString:@""] ? @"" : [NSString stringWithFormat:@"已有%@人参与", _model.partInCount];
    [_createrNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_partInLabel];

    self.buttomLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self.buttomLine autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView];
    [self.buttomLine autoSetDimension:ALDimensionHeight toSize:0.5];
    [self.buttomLine autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView];
    [self.buttomLine autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentLabel];
    if ([_model.channelName isEqualToString:@"邻居说"])
    {
        self.headImgV.image = [UIImage imageNamed:@"neighbour"];
    }
    else if ([_model.channelName isEqualToString:@"同城说"])
    {
        self.headImgV.image = [UIImage imageNamed:@"city"];
    }
    else
    {
        [self setupImage];
    }
}

- (void)setupImage
{
    NSURL *url = [NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:_model.channelIcon]];
    
    __weak UIImageView *weakImgV = self.headImgV;
    NSString *string = [_model.channelName substringWithRange:NSMakeRange(0, 1)];
    UIImage *textImg = [Utility imageWithColor:self.model.channelColor andSize:CGSizeMake(kBtnH, kBtnH) withString:string];
    NSLog(@" error url ==== %@ string \n ===== %@",url,self.model.channelName);

    [self.headImgV setImageWithURL:url placeholderImage:textImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (error != nil)
        {
            [weakImgV setImage:textImg];
        }
        else
        {
            [weakImgV setImage:image];
        }
    }];
    
}

@end
