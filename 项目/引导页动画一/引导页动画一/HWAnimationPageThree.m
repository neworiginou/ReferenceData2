//
//  HWAnimationPageThree.m
//  引导页动画一
//
//  Created by lizhongqiang on 15/7/22.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "HWAnimationPageThree.h"
#define kScaleWidth ([UIScreen mainScreen].bounds.size.width/375.f)
#define kScaleHeight ([UIScreen mainScreen].bounds.size.height/667.f)
@interface HWAnimationPageThree ()
@property (nonatomic, strong)UIImageView *bgImageView;
@property (nonatomic, strong)UIImageView *iconNewHouse;
@property (nonatomic, strong)UIImageView *iconSecondHouse;
@property (nonatomic, strong)UIImageView *iconRecommd;
@property (nonatomic, strong)UIImageView *iconStar;
@property (nonatomic, strong)UIImageView *iconCar;
@property (nonatomic, strong)UIImageView *textImageView;
@property (nonatomic, strong)UIImageView *nowUseringIcon;
@end
@implementation HWAnimationPageThree
- (instancetype)init
{
    if(self = [super init])
    {
        CGFloat spaceX = 0;
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat x = 47*kScaleWidth;
        CGFloat y = 65*kScaleHeight;
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.translatesAutoresizingMaskIntoConstraints = NO;
       _bgImageView.clipsToBounds = YES;
        _bgImageView.hidden = YES;
       // _bgImageView.backgroundColor = [UIColor redColor];
        [self addSubview:_bgImageView];
//        _bgImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 2*(47), 280);
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bgImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:y]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bgImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-x]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bgImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:x]];
        if([UIScreen mainScreen].bounds.size.width == 320&&[UIScreen mainScreen].bounds.size.height == 480)
        {
            _bgImageView.layer.cornerRadius = 320/2.f*kScaleHeight;
            spaceX = 9;
            [self.bgImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.bgImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:320*kScaleHeight]];
        }
        else
        {
            _bgImageView.layer.cornerRadius = 280/2.f*kScaleHeight;
            spaceX = 0;
            [self.bgImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.bgImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:280*kScaleHeight]];
        }
        
        _bgImageView.image = [UIImage imageNamed:@"guide3_bg"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //----------------------------------------
        CGPoint center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.f, [UIScreen mainScreen].bounds.size.height/2.f);
        
        _iconNewHouse = [[UIImageView alloc]init];
        _iconNewHouse.alpha = 0;
        _iconNewHouse.translatesAutoresizingMaskIntoConstraints = NO;
        _iconNewHouse.image = [UIImage imageNamed:@"guide3_play3"];
        [self addSubview:_iconNewHouse];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.iconNewHouse attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:(67/2.f)*kScaleWidth]];//
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.iconNewHouse attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:85*kScaleHeight]];
        [self.iconNewHouse  addConstraint:[NSLayoutConstraint constraintWithItem:self.iconNewHouse attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:75*kScaleWidth]];
        [self.iconNewHouse  addConstraint:[NSLayoutConstraint constraintWithItem:self.iconNewHouse attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:75*kScaleHeight]];
        _iconNewHouse.contentMode = UIViewContentModeScaleAspectFill;
        
        //---------------------------------------
        _iconSecondHouse = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide3_play4"]];
        [self addSubview:_iconSecondHouse];
        _iconSecondHouse.alpha = 0;
        _iconSecondHouse.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 100*kScaleWidth-spaceX),107*kScaleHeight,79*kScaleWidth, 79*kScaleHeight);
        _iconSecondHouse.contentMode = UIViewContentModeScaleAspectFill;
        //-------------------------------------
        _iconRecommd = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide3_play5"]];
        [self addSubview:_iconRecommd];
        _iconRecommd.alpha = 0;
        _iconRecommd.frame = CGRectMake(center.x + 69*kScaleWidth, 250*kScaleHeight + spaceX*3, 67*kScaleWidth, 67*kScaleHeight);
        _iconRecommd.contentMode = UIViewContentModeScaleAspectFill;
        //---------------------------------------
        _iconStar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide3_play6"]];
        [self addSubview:_iconStar];
        
        _iconStar.alpha = 0;
        _iconStar.center = CGPointMake(center.x-105, center.y+30);
        _iconStar.bounds = CGRectMake(0, 0, 50, 50);
        _iconStar.contentMode = UIViewContentModeScaleAspectFill;
        //----------------------------------------
        _iconCar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide3_play2"]];
        _iconCar.alpha = 0;
        //_iconCar.backgroundColor = [UIColor redColor];
        _iconCar.contentMode = UIViewContentModeScaleAspectFit;
        if([UIScreen mainScreen].bounds.size.width == 320&&[UIScreen mainScreen].bounds.size.height == 480)
        {
            _iconCar.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - x, (280/2.f+21)*kScaleHeight, 25.7*kScaleWidth, 25.7*kScaleHeight);
        }
        else
        {
            _iconCar.frame = CGRectMake([UIScreen mainScreen].bounds.size.width -x, (320/2.f - 22)*kScaleHeight, 25.7*kScaleWidth, 25.7*kScaleHeight);
        }
        
        [_bgImageView addSubview:_iconCar];
        //---------------------------------------
        _textImageView = [[UIImageView alloc]init];
        _textImageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.f, [UIScreen mainScreen].bounds.size.height - 190*kScaleHeight);
        _textImageView.bounds = CGRectMake(0, 0, 370*kScaleWidth, 67*kScaleHeight);
        _textImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_textImageView];
        _textImageView.image = [UIImage imageNamed:@"guide3_text"];
        _textImageView.alpha = 0;
        //----------------------------------------
        _nowUseringIcon = [[UIImageView alloc]init];
        _nowUseringIcon.center = CGPointMake(center.x, [UIScreen mainScreen].bounds.size.height-100*kScaleHeight);
        [self addSubview:_nowUseringIcon];
        _nowUseringIcon.image = [UIImage imageNamed:@"enter"];
//        _nowUseringIcon.backgroundColor = [UIColor redColor];
        _nowUseringIcon.contentMode = UIViewContentModeScaleAspectFit;
        _nowUseringIcon.bounds = CGRectMake(0, 0, 170*kScaleWidth, 80*kScaleHeight);
        _nowUseringIcon.alpha = .0;
    }
    return self;
}
-(void)startAnimation
{
    [self reset];
    _isAnimating = YES;
    _bgImageView.hidden = NO;
    _bgImageView.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.4 animations:^{
        _bgImageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        _iconNewHouse.transform = CGAffineTransformMakeScale(0., 0.);
        [UIView animateWithDuration:0.45 delay:0 options:UIViewAnimationOptionCurveEaseOut  animations:^{
            _iconNewHouse.alpha = 1;
            _iconNewHouse.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
        //----------------------
       [self startCarAnimation];
        ////////////------------------------
        _iconSecondHouse.transform = CGAffineTransformMakeScale(0., 0.);
        [UIView animateWithDuration:0.41 delay:0.41 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _iconSecondHouse.alpha = 1;
            _iconSecondHouse.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
        
        ////////////////////---------------------下面的SpringVelocity:参数与Duration有关联，也就意味着加速度--
        _iconRecommd.transform = CGAffineTransformMakeScale(0.0, 0.0);
        
        __weak HWAnimationPageThree *weakSelf = self;
        /*
         usingSpringWithDamping：它的范围为 0.0f 到 1.0f ，数值越小「弹簧」的振动效果越明显。
         initialSpringVelocity：初始的速度，数值越大一开始移动越快。值得注意的是，初始速度取值较高而时间较短时，也会出现反弹情况。
         */
        [UIView animateWithDuration:0.30 delay:0.61 usingSpringWithDamping:0.7 initialSpringVelocity:0.35 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _iconRecommd.alpha = 1;
            _iconRecommd.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            //------------------------------------
            [weakSelf startTextAnimation];
            
            _iconStar.transform = CGAffineTransformMakeScale(0.f, 0.f);
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                _iconStar.alpha = 1;
                _iconStar.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }];
   }];
    
}
- (void)reset
{
    _bgImageView.hidden = YES;
    _iconNewHouse.alpha = 0;
    _iconSecondHouse.alpha = 0;
    _iconRecommd.alpha = 0;
    _iconStar.alpha = 0;
    [_iconCar.layer removeAnimationForKey:@"alpha"];
    [_iconCar.layer removeAnimationForKey:@"position"];
    _textImageView.alpha = 0;
    _nowUseringIcon.alpha = 0;
}
- (void)startCarAnimation
{
    CABasicAnimation *alphaAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAni.duration = 0.17;
    alphaAni.toValue = @(1);
    alphaAni.removedOnCompletion = NO;
    alphaAni.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *position = [CABasicAnimation animationWithKeyPath:@"position.x"];
    position.toValue = @(-20);
    position.duration = 1.8;
    position.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    position.removedOnCompletion = NO;
    position.fillMode = kCAFillModeForwards;
    
    
    [_iconCar.layer addAnimation:alphaAni forKey:@"alpha"];
    [_iconCar.layer addAnimation:position forKey:@"position"];
}
- (void)startTextAnimation
{
    _textImageView.transform = CGAffineTransformMakeTranslation(0, 30);
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _textImageView.transform = CGAffineTransformIdentity;
        _textImageView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
           _nowUseringIcon.alpha = 1; 
        }];
        _isAnimating = NO;
    }];
}
@end


