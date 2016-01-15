//
//  HWAssetsView.m
//  camera
//
//  Created by caijingpeng.haowu on 14-9-1.
//  Copyright (c) 2014年 caijingpeng.haowu. All rights reserved.
//

#import "HWAssetsView.h"

@implementation HWAssetsView
@synthesize asset;
@synthesize delegate;
@synthesize index;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        thumbnailImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        thumbnailImgV.backgroundColor = [UIColor clearColor];
        thumbnailImgV.userInteractionEnabled = YES;
        [self addSubview:thumbnailImgV];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
        [thumbnailImgV addGestureRecognizer:tap];
    }
    return self;
}

- (void)setAsset:(ALAsset *)_asset
{
    asset = _asset;
    if (asset == nil)
    {
        thumbnailImgV.hidden = YES;
    }
    else
    {
        thumbnailImgV.hidden = NO;
        thumbnailImgV.image = [UIImage imageWithCGImage:asset.thumbnail];
    }
}

- (void)setSelected
{
    thumbnailImgV.layer.borderColor = [UIColor colorWithRed:0.24f green:0.62f blue:0.92f alpha:1.0f].CGColor;
    thumbnailImgV.layer.borderWidth = 2.0f;
}
- (void)setDeSelected
{
    thumbnailImgV.layer.borderWidth = 0;
}

- (void)doTap:(UIGestureRecognizer *)sender
{
//    [self setSelected];
    if (delegate && [delegate respondsToSelector:@selector(didSelectedAssetsView:)])
    {
        [delegate didSelectedAssetsView:self];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
