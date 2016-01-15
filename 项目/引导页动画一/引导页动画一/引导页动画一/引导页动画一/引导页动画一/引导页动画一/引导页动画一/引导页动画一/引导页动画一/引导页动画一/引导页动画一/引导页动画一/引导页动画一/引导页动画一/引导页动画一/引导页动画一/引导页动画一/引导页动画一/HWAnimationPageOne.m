//
//  HWAnimationPageOne.m
//  引导页动画一
//
//  Created by lizhongqiang on 15/7/21.
//  Copyright (c) 2015年 lqq. All rights reserved.
//
#import "HWAnimationPageOne.h"
@interface HWAnimationPageOne ()

@property (nonatomic, strong)UIImageView *phoneImageView;

@property (nonatomic, strong)UIImageView *bgImageView;

@property (nonatomic, strong)CABasicAnimation *phoneAnimation;

@property (nonatomic, strong)UIImageView *firstCell;

@property (nonatomic, strong)UIImageView *secondCell;

@property (nonatomic, strong)CABasicAnimation *firstCellAnimation;

@property (nonatomic, strong)CABasicAnimation *secondCellAnimation;

@property (nonatomic, strong)CALayer *bgLayer;

@property (nonatomic, strong)UIImageView *textImageView;
@end

@implementation HWAnimationPageOne

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor purpleColor];
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width+2*11;
        
        UIImageView *bgImageview = [[UIImageView alloc]initWithFrame:CGRectMake(-11, 153/2.f, width, width)];
        [self addSubview:bgImageview];
        bgImageview.contentMode = UIViewContentModeScaleAspectFit;
        bgImageview.image = [UIImage imageNamed:@"guide1_bg"];
        _bgImageView = bgImageview;
        
//-----------------------------------
        _phoneImageView = [[UIImageView alloc]init];
        _phoneImageView.center = bgImageview.center;
        //_phoneImageView.backgroundColor = [UIColor redColor];
        _phoneImageView.bounds = CGRectMake(0, 0, 200, 400);
        [self addSubview:_phoneImageView];
        _phoneImageView.hidden = YES;
        _phoneImageView.image = [UIImage imageNamed:@"guide1_play1"];
        _phoneImageView.contentMode = UIViewContentModeScaleAspectFill;
//--------------------------------------
        _firstCell = [[UIImageView alloc]init];
        _firstCell.contentMode = UIViewContentModeScaleAspectFill;
        _firstCell.image = [UIImage imageNamed:@"guide1_play2"];
        [self addSubview:_firstCell];
        _firstCell.hidden = YES;
        //_firstCell.backgroundColor = [UIColor blueColor];
        _firstCell.center = CGPointMake(bgImageview.center.x, _phoneImageView.center.y+5);
        _firstCell.bounds = CGRectMake(0, 0, 327, 31);
     
//-----------------------------------
        _secondCell = [[UIImageView alloc]init];
        _secondCell.contentMode = UIViewContentModeScaleAspectFit;
        _secondCell.image = [UIImage imageNamed:@"guide1_play3"];
        [self addSubview:_secondCell];
        _secondCell.hidden = YES;
        _secondCell.contentMode = UIViewContentModeScaleAspectFill;
        //_secondCell.backgroundColor = [UIColor redColor];
        _secondCell.center = CGPointMake(bgImageview.center.x, _firstCell.center.y+19/2.f);
        _secondCell.bounds = CGRectMake(0, 0, 300, 31);
//-------------------------------------------
        _textImageView = [[UIImageView alloc]init];
        _textImageView.contentMode = UIViewContentModeScaleAspectFit;
        _textImageView.image = [UIImage imageNamed:@"guide1_text"];
        [self addSubview:_textImageView];
        _textImageView.alpha = 0;
        _textImageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.f, [UIScreen mainScreen].bounds.size.height-80);
        _textImageView.bounds = CGRectMake(0, 0, 280, 80);
    }
    return self;
}
- (void)startAnimation
{
    
//---------------------------------------------
    CABasicAnimation *bgAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    bgAnimation.fromValue = @(0.2);
    bgAnimation.removedOnCompletion = YES;
    bgAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    bgAnimation.duration = 0.4;
    
    [_bgImageView.layer addAnimation:bgAnimation forKey:@"bgImageViewScale"];
//-----------------------------------------
    CABasicAnimation *phoneAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    phoneAnimation.fromValue = @(100);
    
    phoneAnimation.removedOnCompletion = YES;
    
    phoneAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    phoneAnimation.repeatCount = 1;
    
    phoneAnimation.duration = .15f;
    
    phoneAnimation.beginTime = CACurrentMediaTime() + 0.3; // 2秒后执行
    
    phoneAnimation.delegate = self;
    
    _phoneAnimation = phoneAnimation;
    [_phoneImageView.layer addAnimation:phoneAnimation forKey:@"phonemove"];
    
//----------------------------------------
    [UIView beginAnimations:@"cellAnimation" context:nil];
    
    [UIView setAnimationDuration:.2f];
    
    [UIView setAnimationDelay:(0.5+0.5)];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    [UIView setAnimationWillStartSelector:@selector(showView)];
    
    [UIView setAnimationDidStopSelector:@selector(showSecondCell)];
    
     self.firstCell.frame = CGRectMake(self.firstCell.frame.origin.x-20, _firstCell.frame.origin.y-6, _firstCell.bounds.size.width*1.12, _firstCell.bounds.size.height*1.12);
    [UIView commitAnimations];

//
}
- (void)showView
{
    _firstCell.hidden = NO;
    
    [UIView animateWithDuration:1 animations:^{
        _textImageView.alpha = 1;
        _textImageView.center = CGPointMake(_textImageView.center.x, _textImageView.center.y-50);
    }];
}
- (void)showSecondCell
{_secondCell.hidden = NO;
    [UIView animateWithDuration:.4f animations:^{
       _secondCell.frame = CGRectMake(_secondCell.frame.origin.x-33, _secondCell.frame.origin.y-15, _secondCell.bounds.size.width*1.22, _secondCell.bounds.size.height*1.22);
    }completion:^(BOOL finished) {
        _bgLayer = [CALayer layer];
        _bgLayer.backgroundColor = [UIColor colorWithRed:213/255.f green:213/255.f blue:213/255.f alpha:1.0].CGColor;
        _bgLayer.frame = CGRectMake(49, 272, 101, 5+8+3);
        [_phoneImageView.layer addSublayer:_bgLayer];
    }];
}
- (void)animationDidStart:(CAAnimation *)anim
{
    //if(_phoneAnimation == anim)
    {
        _phoneImageView.hidden = NO;
    }
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //[self addSubview:_phoneImageView];
}
//- (void)drawRect:(CGRect)rect
//{
//    UIImage *image = [UIImage imageNamed:@"guide1_bg"];
//    
//    [image drawInRect:CGRectMake(57/2.f, 153/2.f, [UIScreen mainScreen].bounds.size.width-2*(57/2.f), [UIScreen mainScreen].bounds.size.width-2*(70/2.f))];
//}
@end
