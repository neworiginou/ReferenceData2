//
//  HWAlertComplainView.m
//  Community
//
//  Created by niedi on 15/6/19.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWAlertComplainView.h"
#import "AppDelegate.h"

#define BTN_TAG     123
@interface HWAlertComplainView() <UITextViewDelegate>
{
    UIView *_backgroundView;
    UITextView *_textView;
}
@end

@implementation HWAlertComplainView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, 0, 560 / 2, 400 / 2);
        self.backgroundColor = [UIColor whiteColor];
        self.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
        [self configUI];
    }
    return self;
}

-(void)show
{
    AppDelegate *app = SHARED_APP_DELEGATE;
    [app.window addSubview:self.customBackgroundView];
    
    [self animationAlert:self];
    [app.window addSubview:self];
}

-(void)hidenView
{
    [self.customBackgroundView removeFromSuperview];
    [self removeFromSuperview];
}

-(UIView *)customBackgroundView
{
    if (_backgroundView == nil)
    {
        _backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.6;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toTap)];
        [_backgroundView addGestureRecognizer:tap];
    }
    return _backgroundView;
}

//类似alertView弹出动画
-(void)animationAlert:(UIView *)view
{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
}

- (void)configUI
{
    //标题
    UILabel *titleLabel = [UILabel newAutoLayoutView];
    [self addSubview:titleLabel];
    titleLabel.text = @"您对本次物业处理的结果满意吗？";
    titleLabel.textColor = THEME_COLOR_SMOKE;
    titleLabel.font = FONT(16);
    [titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:21];
    [titleLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
    
    DImageV *line = [DImageV imagV:@"" frameX:0 y:50 w:560 / 2 h:0.5f];
    line.backgroundColor = THEME_COLOR_LINE;
    [self addSubview:line];
    
    DButton *evaluateBtn = [DButton btnImg:@"appraisal_2" frameX:25 y:CGRectGetMaxY(line.frame) + 18 w:90 h:90 target:self action:@selector(satisfyBtnClick)];
    [self addSubview:evaluateBtn];
    
    DButton *evaluateBtn1 = [DButton btnImg:@"appraisal_1" frameX:560 / 2 - 25 - 90 y:CGRectGetMaxY(line.frame) + 18 w:90 h:90 target:self action:@selector(unSatisfyBtnClick)];
    [self addSubview:evaluateBtn1];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toTap)];
    [self addGestureRecognizer:tap];
}

- (void)satisfyBtnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(evaluateBtnClickResult:)])
    {
        [self.delegate evaluateBtnClickResult:YES];
    }
    [self hidenView];
}

- (void)unSatisfyBtnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(evaluateBtnClickResult:)])
    {
        [self.delegate evaluateBtnClickResult:NO];
    }
    [self hidenView];
}

- (void)toTap
{
    [self hidenView];
}
@end
