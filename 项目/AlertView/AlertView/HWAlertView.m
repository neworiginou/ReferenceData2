//
//  HWAlertView.m
//  AlertView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "HWAlertView.h"
#import "CenterView.h"

#define kAlertWidth (643/2.f)

#define kAlertHeight (803/2.f)



@interface HWAlertView ()

@property (nonatomic, strong)UIView *cover;

@property (nonatomic, strong)CenterView *centerView;

@property (nonatomic, assign)BOOL isShowing;

@end

@implementation HWAlertView

- (instancetype)init
{
    if(self = [super init])
    {
       
        _cover = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        _cover.alpha = 0;
        
        [_cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideForCover)]];
        
        _cover.backgroundColor = [UIColor blackColor];
        
//----------------------------------
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGPoint center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.f, [UIScreen mainScreen].bounds.size.height/2.f);
        
        self.frame = CGRectMake(center.x - kAlertWidth/2.f, center.y - kAlertHeight/2.f, kAlertWidth, kAlertHeight);
//--------------------------------
        
        
        _centerView = [[CenterView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        __unsafe_unretained HWAlertView *weak = self;

        
        _centerView.cancelAction = ^(void)
        {
            [weak hide];
        };
    
        _centerView.backgroundColor = self.backgroundColor;
        
        [self addSubview:_centerView];
        //----------------------
        
        self.layer.cornerRadius = 7;
        
        self.layer.masksToBounds = YES;
        
    }
    return self;
}

- (void)hideForCover
{
    [self hide];
}
- (void)setTipNumber:(NSString *)tipNumber
{
    _tipNumber = tipNumber;
    
    _centerView.tipNumber = tipNumber;
}
- (void)setProjectName:(NSString *)projectName
{
    _projectName = projectName;
    
    _centerView.projectName = projectName;
}
- (void)setPerpoleName:(NSString *)perpoleName
{
    _perpoleName = perpoleName;
    
    _centerView.perpoleName = perpoleName;
    
}
- (void)setTelephone:(NSString *)telephone
{
    
    _telephone =telephone;
    
    _centerView.telephone = telephone;
}
- (void)setContext:(NSString *)context
{
    _context = context;
    
    _centerView.context = context;
}
- (void)setMoney:(NSString *)money
{
    _money = money;
    
    _centerView.money = money;
    
}

- (void)setGetTime:(NSString *)getTime
{
    _getTime = getTime;
    
    _centerView.getTime = getTime;
}
- (void)setNumberArr:(NSArray *)numberArr
{
    _centerView.numberArr = numberArr;
    
    _numberArr = numberArr;
}
- (void)hide
{
    CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scale.duration =0.25;
    scale.fromValue = [NSNumber numberWithFloat:1];
    scale.toValue = [NSNumber numberWithFloat:0.8];
    scale.fillMode = kCAFillModeForwards;
    scale.removedOnCompletion = NO;
    scale.autoreverses = NO;
    
    CABasicAnimation *opacity=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    opacity.duration = 0.25;
    opacity.fromValue = [NSNumber numberWithFloat:1];
    opacity.toValue = [NSNumber numberWithFloat:0];
    opacity.fillMode = kCAFillModeForwards;
    opacity.removedOnCompletion = NO;
    opacity.autoreverses = NO;
    
    [self.layer addAnimation:scale forKey:@"sc"];
    [self.layer addAnimation:opacity forKey:@"op"];
    
    _isShowing = NO;

    
    [self removeCover];
}
- (void)removeCover
{
    [UIView animateWithDuration:0.25 animations:^{
        
        _cover.alpha = 0;
        
    }completion:^(BOOL finished) {
        
        [_cover removeFromSuperview];
        
        [self removeFromSuperview];
        
    }];
}
- (void)show
{
    if(_isShowing)
    {
        return;
    }
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    [window addSubview:self];
    
    CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scale.duration = 0.25;
    scale.fromValue = [NSNumber numberWithFloat:1.2];
    scale.toValue = [NSNumber numberWithFloat:1];
    
    CABasicAnimation *opacity=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    opacity.duration = 0.25;
    opacity.fromValue = [NSNumber numberWithFloat:0];
    opacity.toValue = [NSNumber numberWithFloat:1];
    
    
    [self.layer addAnimation:scale forKey:@"sc"];
    [self.layer addAnimation:opacity forKey:@"op"];
    
    _isShowing = YES;
    
    [self addCover];
}
- (void)addCover
{
    [UIView animateWithDuration:0.25 animations:^{
        
        _cover.alpha = 0.2;
        
    }completion:^(BOOL finished) {
        
        [self.superview insertSubview:_cover belowSubview:self];
        
        
        
    }];
}
@end
