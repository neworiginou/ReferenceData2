//
//  HWAnimationPageTwo.m
//  引导页动画一
//
//  Created by lizhongqiang on 15/7/21.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "HWAnimationPageTwo.h"
#import "AnimationGroup.h"
#define kScaleWidth ([UIScreen mainScreen].bounds.size.width/375.f)
#define kScaleHeight ([UIScreen mainScreen].bounds.size.height/667.f)
@interface HWAnimationPageTwo ()
@property (nonatomic, strong)UIImageView *bgImageView;
@property (nonatomic, strong)UIImageView *moneyOne;
@property (nonatomic, strong)UIImageView *moneyTwo;
@property (nonatomic, strong)UIImageView *glodImageView;
@property (nonatomic, strong)UIImageView *signImageView;
@property (nonatomic, strong)UIImageView *cricleImageView;
@property (nonatomic, strong)UIImageView *textImageView;
@end
@implementation HWAnimationPageTwo

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _bgImageView = [[UIImageView alloc]init];
        [self addSubview:_bgImageView];
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width - 2*(40)*kScaleWidth;
        _bgImageView.frame = CGRectMake(40*kScaleWidth, 70*kScaleHeight, width, width);
        _bgImageView.image = [UIImage imageNamed:@"guide2_bg"];
        _bgImageView.hidden = YES;
        _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _moneyOne = [[UIImageView alloc]init];
        [self addSubview:_moneyOne];
        _moneyOne.alpha = 0;
        _moneyOne.contentMode = UIViewContentModeScaleAspectFit;
        _moneyOne.image = [UIImage imageNamed:@"guide2_play1"];
        _moneyOne.frame = CGRectMake(_bgImageView.center.x - 143*kScaleWidth, _bgImageView.center.y-81*kScaleHeight, 210*kScaleWidth, 210*kScaleHeight);
        //_moneyOne.backgroundColor = [UIColor redColor];
        
        
        _moneyTwo = [[UIImageView alloc]init];
        _moneyTwo.alpha = 0;
        _moneyTwo.contentMode = UIViewContentModeScaleAspectFit;
        _moneyTwo.frame = CGRectMake(_bgImageView.center.x - (150-20 - 7)*kScaleWidth, _bgImageView.center.y-57*kScaleHeight, _moneyOne.bounds.size.width, _moneyOne.bounds.size.height);
        _moneyTwo.image = [UIImage imageNamed:@"guide2_play2"];
        [self insertSubview:_moneyTwo belowSubview:_moneyOne];
    
        NSLog(@"%f",[UIScreen mainScreen].scale);
        _glodImageView = [[UIImageView alloc]init];
        _glodImageView.alpha = 0;
        
        if([UIScreen mainScreen].bounds.size.width == 320&&[UIScreen mainScreen].bounds.size.height == 480)
        {
            _glodImageView.frame = CGRectMake(52*kScaleWidth, 230*kScaleHeight, 55*kScaleWidth, 55*kScaleHeight);
        }
        else
        {
            _glodImageView.frame = CGRectMake(49*kScaleWidth, 210*kScaleHeight, 55*kScaleWidth, 55*kScaleHeight);
        }
        _glodImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self insertSubview:_glodImageView belowSubview:_moneyOne];
        _glodImageView.image = [UIImage imageNamed:@"guide2_play3"];
        
        _cricleImageView = [[UIImageView alloc]init];
        _cricleImageView.frame = _bgImageView.frame;
        _cricleImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_cricleImageView];
        _cricleImageView.alpha = 0;
        _cricleImageView.image = [UIImage imageNamed:@"guide2_play5"];
        
        _signImageView = [[UIImageView alloc]init];
        [self addSubview:_signImageView];
        _signImageView.alpha = 0;
        _signImageView.contentMode = UIViewContentModeScaleAspectFill;
        _signImageView.image = [UIImage imageNamed:@"guide2_play4"];
        _signImageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 150*kScaleWidth, 62*kScaleHeight, 65*kScaleWidth, 65*kScaleHeight);
        
        
        _textImageView = [[UIImageView alloc]init];
        _textImageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.f, [UIScreen mainScreen].bounds.size.height - 170*kScaleHeight);
        _textImageView.bounds = CGRectMake(0, 0, 310*kScaleWidth, 100*kScaleHeight);
        _textImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_textImageView];
        _textImageView.image = [UIImage imageNamed:@"guide2_text"];
        _textImageView.alpha = 0;
        
    }
    return self;
}
- (void)startAnimation
{
    self.isAnimating = YES;
    
    [self reset];
    
    _bgImageView.transform = CGAffineTransformMakeScale(0, 0);
    
    __weak HWAnimationPageTwo *weakSelf = self;
    
    [UIView animateWithDuration:.4f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _bgImageView.transform = CGAffineTransformIdentity;
        _bgImageView.hidden = NO;
    } completion:^(BOOL finished) {
        [weakSelf startMoneyOneAnimation];
    }];
    
    
    
}
- (void)reset
{
    _bgImageView.hidden = YES;
    [_moneyOne.layer removeAnimationForKey:@"moneyOne"];
    [_moneyTwo.layer removeAnimationForKey:@"moneyTwo"];
    [_glodImageView.layer removeAnimationForKey:@"glodImageView"];
    [_signImageView.layer removeAnimationForKey:@"signImageView"];
    [_cricleImageView.layer removeAnimationForKey:@"cricleImageView"];
    _textImageView.alpha = 0;
}
- (void)startMoneyOneAnimation
{
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.toValue = @(1);
    alphaAnimation.fromValue = @(0);
    alphaAnimation.duration = .3f;
    alphaAnimation.removedOnCompletion = NO;
    alphaAnimation.fillMode = kCAFillModeForwards;
    
    CGMutablePathRef aPath = CGPathCreateMutable();
    CGPathMoveToPoint(aPath,NULL, _moneyOne.center.x-30, _moneyOne.center.y-30);
    CGPathAddQuadCurveToPoint(aPath, NULL, _moneyOne.center.x - 10, _moneyOne.center.y - 6, _moneyOne.center.x, _moneyOne.center.y);
    
    CAKeyframeAnimation *moneyOneAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moneyOneAni.path = aPath;
    
    CABasicAnimation *roateMoneyOne = [CABasicAnimation animationWithKeyPath:@"transform"];
    roateMoneyOne.fromValue =  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_1_PI,0,0,1)];
    roateMoneyOne.toValue = [NSValue valueWithCATransform3D: CATransform3DIdentity];
    //roateMoneyOne.removedOnCompletion = YES;
    //roateMoneyOne.fillMode = kCAFillModeBackwards;
    //    roateMoneyOne.duration = 2.f;
    //    roateMoneyOne.cumulative = YES;
    
    AnimationGroup *group = [AnimationGroup animation];
    [group setAnimations:@[alphaAnimation,moneyOneAni,roateMoneyOne]];
    group.removedOnCompletion = NO;
    group.delegate = self;
    group.tag = 1000;
    group.fillMode = kCAFillModeForwards;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.duration = .4f;
    
    [_moneyOne.layer addAnimation:group forKey:@"moneyOne"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    AnimationGroup *group = (AnimationGroup *)anim;
    if([_moneyOne.layer animationForKey:@"moneyOne"] == group)
    {
        CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        alphaAnimation.toValue = @(1);
        alphaAnimation.fromValue = @(0);
        alphaAnimation.duration = .3f;
        alphaAnimation.removedOnCompletion = NO;
        alphaAnimation.fillMode = kCAFillModeForwards;
        
        CGMutablePathRef aPath = CGPathCreateMutable();
        CGPathMoveToPoint(aPath,NULL, _moneyTwo.center.x-10, _moneyTwo.center.y-10);
        CGPathAddQuadCurveToPoint(aPath, NULL, _moneyTwo.center.x - 6, _moneyTwo.center.y - 6, _moneyTwo.center.x, _moneyTwo.center.y);
        
        CAKeyframeAnimation *moneyOneAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        moneyOneAni.path = aPath;
        
        CABasicAnimation *roateMoneyOne = [CABasicAnimation animationWithKeyPath:@"transform"];
        roateMoneyOne.fromValue =  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_1_PI/3,0,0,1)];
        roateMoneyOne.toValue = [NSValue valueWithCATransform3D: CATransform3DIdentity];
        //roateMoneyOne.removedOnCompletion = YES;
        //roateMoneyOne.fillMode = kCAFillModeBackwards;
        //    roateMoneyOne.duration = 2.f;
        //    roateMoneyOne.cumulative = YES;
        
        AnimationGroup *group = [AnimationGroup animation];
        [group setAnimations:@[alphaAnimation,moneyOneAni,roateMoneyOne]];
        group.removedOnCompletion = NO;
        group.delegate = self;
        group.fillMode = kCAFillModeForwards;
        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        group.duration = .4f;
        
        [_moneyTwo.layer addAnimation:group forKey:@"moneyTwo"];
        [self startTextAnimation];
    }
    if([_moneyTwo.layer animationForKey:@"moneyTwo"] == group)
    {
        CABasicAnimation *glodAlpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
        glodAlpha.toValue = @(1);
        glodAlpha.delegate = self;
        glodAlpha.fromValue = @(0);
        glodAlpha.beginTime = CACurrentMediaTime() + 0.23;
        glodAlpha.duration = 1.5f;
        glodAlpha.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        glodAlpha.removedOnCompletion = NO;
        glodAlpha.fillMode = kCAFillModeForwards;
        [_glodImageView.layer addAnimation:glodAlpha forKey:@"glodImageView"];
        
        
        CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        alphaAnimation.toValue = @(1);
        alphaAnimation.fromValue = @(0);
        alphaAnimation.duration = 1.5f;
        alphaAnimation.beginTime = CACurrentMediaTime() + 0.07;
        alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        alphaAnimation.removedOnCompletion = NO;
        alphaAnimation.fillMode = kCAFillModeForwards;
        [_signImageView.layer addAnimation:glodAlpha forKey:@"signImageView"];
        
        
    }
    if([_signImageView.layer animationForKey:@"signImageView"] == anim)
    {
        CABasicAnimation *circleAlpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
        circleAlpha.toValue = @(1);
        circleAlpha.fromValue = @(0);
        circleAlpha.duration = .7f*1.05;
       // circleAlpha.beginTime = CACurrentMediaTime() + 0.23;
        circleAlpha.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        circleAlpha.removedOnCompletion = NO;
        circleAlpha.fillMode = kCAFillModeForwards;
        [_cricleImageView.layer addAnimation:circleAlpha forKey:@"cricleImageView"];
    }
    
}
- (void)startTextAnimation
{
    _textImageView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 40);
    [UIView animateWithDuration:1.7 animations:^{
        _textImageView.alpha = 1;
        _textImageView.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        _isAnimating = NO;
//        
//        [_moneyOne.layer removeAnimationForKey:@"moneyOne"];
    }];
}
@end
