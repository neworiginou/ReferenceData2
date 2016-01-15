//
//  HWFocusLayer.m
//  camera
//
//  Created by caijingpeng.haowu on 14-9-3.
//  Copyright (c) 2014年 caijingpeng.haowu. All rights reserved.
//

#import "HWFocusLayer.h"

@implementation HWFocusLayer

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _bigCircle = [CALayer layer];
    _bigCircle.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _bigCircle.backgroundColor = [UIColor clearColor].CGColor;
    _bigCircle.cornerRadius = frame.size.height/2.0f;
    _bigCircle.borderWidth = 1.0f;
    _bigCircle.borderColor = [UIColor colorWithWhite:1.0f alpha:0.8f].CGColor;
    [self addSublayer:_bigCircle];
    
    float smallWidth = frame.size.width / 1.8f;
    float smallHeight = frame.size.height / 1.8f;
    
    _smallCircle = [CALayer layer];
    _smallCircle.frame = CGRectMake((frame.size.width - smallWidth)/2.0f, (frame.size.height - smallHeight)/2.0f, smallWidth, smallHeight);
    _smallCircle.backgroundColor = [UIColor clearColor].CGColor;
    _smallCircle.cornerRadius = smallHeight/2.0f;
    _smallCircle.borderWidth = 4.0f;
    _smallCircle.borderColor = [UIColor colorWithWhite:1.0f alpha:0.8f].CGColor;
    [self addSublayer:_smallCircle];
    
    [self performSelector:@selector(hideLayer) withObject:nil afterDelay:0.8f];
}

- (void)startAnimate
{
    if (![_bigCircle animationForKey:@"key.scale"])
    {
        CABasicAnimation *scaleAnimate = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimate.duration = 0.4f;
        scaleAnimate.repeatCount = 2;
        scaleAnimate.autoreverses = YES;
        scaleAnimate.fromValue = [NSNumber numberWithFloat:1.0f];
        scaleAnimate.toValue = [NSNumber numberWithFloat:1.1f];
        scaleAnimate.delegate = nil;
        scaleAnimate.fillMode = kCAFillModeForwards;
        scaleAnimate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [_bigCircle addAnimation:scaleAnimate forKey:@"key.scale"];
        
    }
    
    if (![_smallCircle animationForKey:@"key.opacity"])
    {
        CABasicAnimation *fadeAnimate = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeAnimate.duration = 0.4f;
        fadeAnimate.repeatCount = 2;
        fadeAnimate.autoreverses = YES;
        fadeAnimate.fromValue = [NSNumber numberWithFloat:1.0f];
        fadeAnimate.toValue = [NSNumber numberWithFloat:0.6f];
        fadeAnimate.delegate = nil;
        fadeAnimate.fillMode = kCAFillModeForwards;
        fadeAnimate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [_smallCircle addAnimation:fadeAnimate forKey:@"key.opacity"];
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideLayer) object:nil];
    [self performSelector:@selector(hideLayer) withObject:nil afterDelay:0.8f];
}

- (void)hideLayer
{
    CABasicAnimation *scaleAnimate = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimate.duration = 0.4f;
    scaleAnimate.repeatCount = 1;
    scaleAnimate.autoreverses = NO;
    scaleAnimate.fromValue = [NSNumber numberWithFloat:1.0f];
    scaleAnimate.toValue = [NSNumber numberWithFloat:0.0f];
    scaleAnimate.delegate = self;
    scaleAnimate.removedOnCompletion = NO;
    scaleAnimate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimate.fillMode = kCAFillModeForwards;
    [self addAnimation:scaleAnimate forKey:@"key.hide"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self removeFromSuperlayer];
}


@end











