//
//  HWAnimationPageOne.m
//  引导页动画一
//
//  Created by lizhongqiang on 15/7/21.
//  Copyright (c) 2015年 lqq. All rights reserved.
//
#import "HWAnimationPageOne.h"
#define kScaleWidth ([UIScreen mainScreen].bounds.size.width/375.f)
#define kScaleHeight ([UIScreen mainScreen].bounds.size.height/667.f)
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
        CGFloat width = (375- 2*30)*kScaleWidth;
        
        UIImageView *bgImageview = [[UIImageView alloc]init];
        if([UIScreen mainScreen].bounds.size.width == 320&&[UIScreen mainScreen].bounds.size.height == 480)
        {
            bgImageview.frame = CGRectMake(50*kScaleWidth, 60*kScaleWidth, [UIScreen mainScreen].bounds.size.width - 2*50*kScaleWidth, [UIScreen mainScreen].bounds.size.width - 2*50*kScaleWidth);
        }
        else
        {
            bgImageview.frame = CGRectMake(30*kScaleWidth, 100*kScaleHeight, width, width);
        }
        
        [self addSubview:bgImageview];
        bgImageview.contentMode = UIViewContentModeScaleAspectFill;
        bgImageview.image = [UIImage imageNamed:@"guide1_bg"];
        _bgImageView = bgImageview;
        
//-----------------------------------
        _phoneImageView = [[UIImageView alloc]init];
        _phoneImageView.frame = CGRectMake(37*kScaleWidth, 65*kScaleHeight, 330*kScaleWidth, 500*kScaleHeight);
        [self addSubview:_phoneImageView];
        //_phoneImageView.backgroundColor = [UIColor redColor];
        _phoneImageView.hidden = YES;
        _phoneImageView.image = [UIImage imageNamed:@"guide1_play1"];
        _phoneImageView.contentMode = UIViewContentModeScaleAspectFit;
//--------------------------------------
        _firstCell = [[UIImageView alloc]init];
        _firstCell.contentMode = UIViewContentModeScaleAspectFit;
        _firstCell.image = [UIImage imageNamed:@"guide1_play2"];
        [self addSubview:_firstCell];
        _firstCell.hidden = YES;
//        _firstCell.backgroundColor = [UIColor blueColor];
        _firstCell.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width == 320&&[UIScreen mainScreen].bounds.size.height == 480?105.5:106)*kScaleWidth, ([UIScreen mainScreen].bounds.size.width == 320&&[UIScreen mainScreen].bounds.size.height == 480?256:260)*kScaleHeight, 165*kScaleWidth, 68*kScaleHeight);
     
//-----------------------------------
        _secondCell = [[UIImageView alloc]init];
        _secondCell.contentMode = UIViewContentModeScaleAspectFit;
        _secondCell.image = [UIImage imageNamed:@"guide1_play3"];
        [self addSubview:_secondCell];
        _secondCell.hidden = YES;
        _secondCell.contentMode = UIViewContentModeScaleAspectFit;
//        _secondCell.backgroundColor = [UIColor redColor];
        _secondCell.frame = CGRectMake(_firstCell.frame.origin.x, ([UIScreen mainScreen].bounds.size.width == 320&&[UIScreen mainScreen].bounds.size.height == 480?48.1:41.5)*kScaleHeight+_firstCell.frame.origin.y, 165*kScaleWidth, 68*kScaleHeight);
//-------------------------------------------
        _textImageView = [[UIImageView alloc]init];
        _textImageView.contentMode = UIViewContentModeScaleAspectFit;
        _textImageView.image = [UIImage imageNamed:@"guide1_text"];
        [self addSubview:_textImageView];
        _textImageView.alpha = 0;
        _textImageView.frame = CGRectMake(((375-330)/2.f)*kScaleWidth, [UIScreen mainScreen].bounds.size.height-152*kScaleHeight, 330*kScaleWidth, 79*kScaleHeight);
    }
    return self;
}
- (void)startAnimation
{
    [self reset];
//---------------------------------------------
    CABasicAnimation *bgAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    bgAnimation.fromValue = @(0.2);
    bgAnimation.removedOnCompletion = YES;
    bgAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    bgAnimation.duration = 0.55;
    
    [_bgImageView.layer addAnimation:bgAnimation forKey:@"bgImageViewScale"];
//-----------------------------------------
    CABasicAnimation *phoneAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    phoneAnimation.fromValue = @(100);
    
    phoneAnimation.removedOnCompletion = YES;
    
    phoneAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    phoneAnimation.repeatCount = 1;
    
    phoneAnimation.duration = .31f;
    
    phoneAnimation.beginTime = CACurrentMediaTime() + 0.45; // 2秒后执行
    
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
    
     self.firstCell.transform = CGAffineTransformMakeScale(1.15, 1.15);
    [UIView commitAnimations];

//
}
- (void)reset
{
    _firstCell.transform = CGAffineTransformIdentity;
    _firstCell.hidden = YES;
    _secondCell.hidden = YES;
    [_phoneImageView.layer removeAnimationForKey:@"phonemove"];
    _secondCell.transform = CGAffineTransformIdentity;
    [_bgImageView.layer removeAnimationForKey:@"bgImageViewScale"];
    _phoneImageView.hidden = YES;
    _textImageView.alpha = 0;
    _bgLayer.hidden = YES;
    _isAnimating = YES;
}
- (void)showView
{
    _firstCell.hidden = NO;
    _textImageView.transform = CGAffineTransformMakeTranslation(0, 47*kScaleHeight);
    [UIView animateWithDuration:1 animations:^{
        _textImageView.alpha = 1;
        _textImageView.transform = CGAffineTransformIdentity;
        
    }];
}
- (void)showSecondCell
{
    _secondCell.hidden = NO;
    [UIView animateWithDuration:.4f animations:^{
        if([UIScreen mainScreen].bounds.size.width == 320&&[UIScreen mainScreen].bounds.size.height == 480)
        {
            _secondCell.transform = CGAffineTransformMakeScale(1.23, 1.23);
        }
        else
        {
            _secondCell.transform = CGAffineTransformMakeScale(1.27, 1.27);
        }
        
//       _secondCell.frame = CGRectMake(100*kScaleWidth-17.7*kScaleWidth,  253*kScaleHeight+40*kScaleHeight-10*kScaleHeight, 175*kScaleWidth*1.22, 70*kScaleHeight*1.22);
    }completion:^(BOOL finished) {
        if(_bgLayer != nil)
        {
            [_bgLayer removeFromSuperlayer];
            _bgLayer = nil;
        }
        _bgLayer = [CALayer layer];
        _bgLayer.backgroundColor = [UIColor colorWithRed:213/255.f green:213/255.f blue:213/255.f alpha:1.0].CGColor;
      
        if([UIScreen mainScreen].bounds.size.height == 480)
        {
            _bgLayer.frame = CGRectMake(77*kScaleWidth, 290*kScaleHeight, 148*kScaleWidth, 24*kScaleHeight);
        }
        else
        {
            _bgLayer.frame = CGRectMake(77*kScaleWidth, 290*kScaleHeight, 150*kScaleWidth, 16*kScaleHeight);
        }
        
        [_phoneImageView.layer addSublayer:_bgLayer];
        
        CAShapeLayer *masklayer = [CAShapeLayer layer];
        masklayer.frame = _bgLayer.bounds;
        masklayer.path = [self bezierPath];
        _bgLayer.mask = masklayer;
        _isAnimating = NO;
    } ];
}
- (CGPathRef)bezierPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 0, _bgLayer.bounds.size.height - 10*kScaleHeight);
   // CGPathAddArc(path, NULL, 0, _bgLayer.bounds.size.height, 20*kScaleWidth,  -M_PI_2, 0, NO);
    CGPathAddQuadCurveToPoint(path, NULL, 17*kScaleWidth, _bgLayer.bounds.size.height - 17*kScaleHeight, 19*kScaleWidth, _bgLayer.bounds.size.height);
    //CGPathMoveToPoint(path, NULL, 10, self.bounds.size.height);
    CGPathAddLineToPoint(path, NULL, _bgLayer.bounds.size.width - 18.5*kScaleWidth, _bgLayer.bounds.size.height);
    //CGPathAddArc(path, NULL, _bgLayer.bounds.size.width, _bgLayer.bounds.size.height, 20*kScaleHeight,  -M_PI, -M_PI_2, NO);
    CGPathAddQuadCurveToPoint(path, NULL, _bgLayer.bounds.size.width - 21*kScaleWidth, _bgLayer.bounds.size.height - 23*kScaleHeight, _bgLayer.bounds.size.width, _bgLayer.bounds.size.height - 4);
    CGPathAddLineToPoint(path, NULL, _bgLayer.bounds.size.width, 0);
    CGPathAddLineToPoint(path, NULL, 0, 0);
    
    
    return path;
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
