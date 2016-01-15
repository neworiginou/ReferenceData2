//
//  HWAnimateBaseCell.m
//  Community
//
//  Created by caijingpeng.haowu on 14-10-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWAnimateBaseCell.h"

@implementation HWAnimateBaseCell

- (void)startAnimate
{
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    scaleAnim.fromValue = [NSNumber numberWithFloat:60.0f];
    scaleAnim.toValue = [NSNumber numberWithFloat:0.0f];
    scaleAnim.duration = 0.6f;
    scaleAnim.autoreverses = NO;
    scaleAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    scaleAnim.repeatCount = CGFLOAT_MAX;
    [self.contentView.layer addAnimation:scaleAnim forKey:@"scale"];
}

- (void)moveDownAnimate
{
    CABasicAnimation *downAnim = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    downAnim.fromValue = [NSNumber numberWithFloat:0.0f];
    downAnim.toValue = [NSNumber numberWithFloat:40.0f];
    downAnim.duration = 0.6f;
    downAnim.autoreverses = NO;
    downAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.contentView.layer addAnimation:downAnim forKey:@"down"];
}

@end
