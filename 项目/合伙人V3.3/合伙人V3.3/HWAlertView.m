//
//  HWAlertView.m
//  AlertView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "HWAlertView.h"
#import "UIView+AutoLayout.h"

#define kAlertWidth (637/2.f)

#define kAlertHeight (285/2.f)



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
        
        CGPoint center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.f, [UIScreen mainScreen].bounds.size.height/2.f-50);
        
        self.frame = CGRectMake(center.x - kAlertWidth/2.f, center.y - kAlertHeight/2.f, kAlertWidth, kAlertHeight);
//--------------------------------
        
        
        _centerView = [[CenterView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        __unsafe_unretained HWAlertView *weak = self;
    
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
@interface CenterView()
@property (nonatomic, strong)UILabel *messageLabel;
@property (nonatomic, strong)UIButton *decideBtn;
@end
@implementation CenterView
- (UILabel *)messageLabel{
    if(_messageLabel == nil){
        _messageLabel = [UILabel newAutoLayoutView];
        _messageLabel.text = @"您的邀请码不存在，\n请重新输入！";
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}
- (UIButton *)decideBtn{
    if(_decideBtn == nil){
        _decideBtn = [UIButton newAutoLayoutView];
        [_decideBtn setTitle:@"确定" forState:UIControlStateNormal];
    }
    return _decideBtn;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.messageLabel];
        [self addSubview:self.decideBtn];
        
        CALayer *liner = [CALayer layer];
        liner.frame = CGRectMake(0, 179/2.0, CGRectGetWidth(frame), 0.5);
        liner.backgroundColor = [UIColor colorWithRed:150/255.0 green:151/255.0 blue:151/255.0 alpha:1.0].CGColor;
        [self.layer addSublayer:liner];
    }
    return self;
}

- (void)layoutSubviews{
    [self.messageLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self];
    [self.messageLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self];
    [self.messageLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self];
    CGFloat height = 179/2.0;
    [self.messageLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:nil withOffset:height];
    
    
    [self.decideBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self];
    [self.decideBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self];
    [self.decideBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self];
    [self.decideBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:nil withOffset:CGRectGetHeight(self.frame)-height];
}
@end
