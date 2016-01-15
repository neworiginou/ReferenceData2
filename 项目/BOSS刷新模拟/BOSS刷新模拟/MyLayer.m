//
//  MyLayer.m
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/9.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "MyLayer.h"
#define kDistance 3.1
#define kDuration 0.21
@interface MyLayer ()
@property (nonatomic, strong)CAKeyframeAnimation *customAnimation;
@end
@implementation MyLayer
- (CAKeyframeAnimation *)customAnimation{
    if(_customAnimation == nil){
        _customAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        _customAnimation.duration = kDuration;
        _customAnimation.autoreverses = YES;
        _customAnimation.repeatCount = NSIntegerMax;
    }
    return _customAnimation;
}
- (void)animationStart{
    [self addAnimation:self.customAnimation forKey:@"animation"];
}
- (void)setType:(Type)type{
    CGPoint point0 = CGPointZero;
    CGPoint point1 = CGPointZero;
    switch (type) {
        case Top:
        {
            point0 = CGPointMake(self.position.x, self.position.y-kDistance);
            point1 = CGPointMake(self.position.x, self.position.y+kDistance);
        }
            break;
        case Bottom:
        {
            point0 = CGPointMake(self.position.x, self.position.y+kDistance);
            point1 = CGPointMake(self.position.x, self.position.y-kDistance);
        }
            break;
        case Left:
        {
            point0 = CGPointMake(self.position.x-kDistance, self.position.y);
            point1 = CGPointMake(self.position.x+kDistance, self.position.y);
        }
            break;
        case Right:
        {
            point0 = CGPointMake(self.position.x+kDistance, self.position.y);
            point1 = CGPointMake(self.position.x-kDistance, self.position.y);
        }
            break;
    }
    self.customAnimation.values = @[[NSValue valueWithCGPoint:point0],[NSValue valueWithCGPoint:point1]];//@[[NSValue valueWithCGPoint:point0],@(0),[NSValue valueWithCGPoint:point1],@(0)];[NSValue valueWithCGPoint:self.position]
    //self.customAnimation.keyTimes = @[@(kDuration/4),@(kDuration/4),@(kDuration/4)];
    
}
- (void)animationEnd{
    //[self removeAnimationForKey:@"animation"];
}
@end
