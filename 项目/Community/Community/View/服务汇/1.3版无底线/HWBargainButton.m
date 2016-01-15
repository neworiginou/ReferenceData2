//
//  HWBargainButton.m
//  Community
//
//  Created by niedi on 15/4/28.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBargainButton.h"

#define BtnWidth 82
#define BtnHight 30

@implementation HWBargainButton

+ (instancetype)buttonWithFrame:(CGRect)frame remainTimes:(int)remainTimes delegate:(id<HWBargainButtonDelegate>)delegate
{
    HWBargainButton *btn = [HWBargainButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setBargainButtonRemainTime:remainTimes];
    btn.delegate = delegate;
    return btn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.frame = CGRectMake(0, 0, BtnWidth, BtnHight);
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = true;
        [self setTitle:@"砍价" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALLTITLE];
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -18.5, 0, 18.5);
//        [self addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _remainNumLab = [[UILabel alloc] initWithFrame:CGRectMake(39, 10, 37, 12)];
        _remainNumLab.backgroundColor = [UIColor clearColor];
        _remainNumLab.text = @"0次";
        _remainNumLab.textColor = THEME_COLOR_CELLCOLOR;
        _remainNumLab.textAlignment = NSTextAlignmentCenter;
        _remainNumLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SUPERSMALL];
        [self addSubview:_remainNumLab];
    }
    return self;
}

- (void)setFrame:(CGRect)aframe
{
    super.frame = CGRectMake(aframe.origin.x, aframe.origin.y, BtnWidth, BtnHight);
}

- (void)setBargainButtonRemainTime:(int)remainTimes
{
    if (remainTimes == -1 || remainTimes == 0)  //-1无限次 0剩余0次
    {
        _remainNumLab.text = @"";
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    else
    {
        if (remainTimes < 10)
        {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -13, 0, 13);
        }
        else if (remainTimes < 100)
        {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 16);
        }
        else
        {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -18.5, 0, 18.5);
        }
        
        _remainNumLab.text = [NSString stringWithFormat:@"(%d次)", remainTimes];
    }
    
    
    if (remainTimes == 0)
    {
        [self setBargainButtonGrayColor];
    }
    else
    {
        [self setBargainButtonMainColor];
    }
}

- (void)setBargainButtonMainColor
{
    [self setBackgroundImage:[Utility imageWithColor:THEME_COLOR_ORANGE andSize:CGSizeMake(BtnWidth, BtnHight)] forState:UIControlStateNormal];
    [self setBackgroundImage:[Utility imageWithColor:THEME_COLOR_ORANGE_HIGHLIGHT andSize:CGSizeMake(BtnWidth, BtnHight)] forState:UIControlStateHighlighted];
    self.userInteractionEnabled = YES;
}

- (void)setBargainButtonGrayColor
{
    [self setBackgroundImage:[Utility imageWithColor:THEME_COLOR_GRAY andSize:CGSizeMake(BtnWidth, BtnHight)] forState:UIControlStateNormal];
    self.userInteractionEnabled = NO;
}

- (void)btnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bargainButtonClick:)])
    {
        [self.delegate bargainButtonClick:self];
    }
}

@end
