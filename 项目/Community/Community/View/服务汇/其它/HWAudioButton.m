//
//  HWAudioButton.m
//  UnitTest
//
//  Created by caijingpeng.haowu on 14-9-17.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWAudioButton.h"

@implementation HWAudioButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 50)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(7.5f, 80 - 2, 7.5f, 24 + 2)];
    
    animateImgV = [[UIImageView alloc] initWithFrame:CGRectMake(65, 5.0f, 15, 15)];
    animateImgV.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"loading0"], [UIImage imageNamed:@"loading1"], [UIImage imageNamed:@"loading2"], [UIImage imageNamed:@"loading3"], nil];
    animateImgV.backgroundColor = [UIColor clearColor];
    animateImgV.animationDuration = 1.0f;
    animateImgV.hidden = YES;
    [self addSubview:animateImgV];
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.center = animateImgV.center;
    [self addSubview:activityView];
}

- (void)setPlayMode:(PlayMode)mode
{
    if (mode == DownloadingPlayMode)
    {
        animateImgV.hidden = YES;
        [self setImage:[Utility imageWithColor:[UIColor clearColor] andSize:CGSizeMake(10, 10)] forState:UIControlStateNormal];
        [activityView startAnimating];
        
    }
    else if (mode == PlayingPlayMode)
    {
        animateImgV.hidden = NO;
        [self setImage:[Utility imageWithColor:[UIColor clearColor] andSize:CGSizeMake(10, 10)] forState:UIControlStateNormal];
        [animateImgV startAnimating];
        [activityView stopAnimating];
    }
    else if (mode == StopPlayMode)
    {
        [self setImage:[UIImage imageNamed:@"property_play"] forState:UIControlStateNormal];
         [animateImgV stopAnimating];
        animateImgV.hidden = YES;
        [activityView stopAnimating];
    }
    else if (mode == PausePlayMode)
    {
        [self setImage:[UIImage imageNamed:@"property_stop"] forState:UIControlStateNormal];
        [animateImgV stopAnimating];
        animateImgV.hidden = YES;
        [activityView stopAnimating];
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
