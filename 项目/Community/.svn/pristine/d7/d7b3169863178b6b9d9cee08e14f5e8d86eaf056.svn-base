//
//  UICountDownButton.m
//  CallPhoneAlert
//
//  Created by lizhongqiang on 14-8-28.
//  Copyright (c) 2014年 Lizhongqiang. All rights reserved.
//

#import "HWCountDownButton.h"

@implementation HWCountDownButton
@synthesize freezeColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        countTime = 60;
        [self setTitle:[NSString stringWithFormat:@"重新发送(%d)",(int)countTime] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)btnClick:(id)sender
{
    self.userInteractionEnabled = NO;
    countTime = resetTime;
    if(btnTimer == nil)
    {
        btnTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerPlay) userInfo:nil repeats:YES];
    }
    
}
//设置时间
- (void)setTime:(CGFloat)time
{
    countTime = time;
    resetTime = time;
}

- (void)timerPlay
{
    countTime -- ;
    if (countTime > 0)
    {
        if (freezeColor != nil)
        {
            [self setBackgroundImage:[Utility imageWithColor:freezeColor andSize:self.frame.size] forState:UIControlStateNormal];
        }
        [self setTitle:[NSString stringWithFormat:@"重新发送(%d)",(int)countTime] forState:UIControlStateNormal];
    }
    else if (countTime == 0)
    {
        if (freezeColor != nil)
        {
            [self setBackgroundImage:[Utility imageWithColor:UIColorFromRGB(0xffd200) andSize:self.frame.size] forState:UIControlStateNormal];
            [self setBackgroundImage:[Utility imageWithColor:UIColorFromRGB(0xfcbc00) andSize:self.frame.size] forState:UIControlStateHighlighted];
        }
        
        [self setTitle:@"点击重新发送" forState:UIControlStateNormal];
        [btnTimer invalidate];
        self.userInteractionEnabled = YES;
    }
}

- (void)setTimerStart:(BOOL)isStart
{
    if (isStart)
    {
        if (freezeColor != nil)
        {
            [self setBackgroundImage:[Utility imageWithColor:freezeColor andSize:self.frame.size] forState:UIControlStateNormal];
        }
        [self btnClick:nil];
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
