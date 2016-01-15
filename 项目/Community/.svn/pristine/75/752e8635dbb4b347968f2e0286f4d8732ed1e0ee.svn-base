//
//  HWAlertComplainAgainView.m
//  Community
//
//  Created by hw500027 on 15/6/16.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWAlertComplainAgainView.h"
#import "AppDelegate.h"

#define BTN_TAG     123
@interface HWAlertComplainAgainView() <UITextViewDelegate>
{
    UIView *_backgroundView;
    UITextView *_textView;
}
@end

@implementation HWAlertComplainAgainView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, 0, 560 / 2, 400 / 2);
        self.backgroundColor = [UIColor whiteColor];
        if (IPHONE4)
        {
            self.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 4);
        }
        else if (IPHONE5)
        {
            self.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 3);
        }
        else
        {
            self.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
        }
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
    titleLabel.text = @"说说哪里让你比较不满意吧。。。";
    titleLabel.font = FONT(16);
    titleLabel.textColor = THEME_COLOR_SMOKE;
    [titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:21];
    [titleLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
    
    //输入框背景
    UIView *intputView = [[UIView alloc] initWithFrame:CGRectMake(38 / 2, 94 / 2, 486 / 2, 158 / 2)];
    intputView.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
    intputView.layer.borderColor = THEME_COLOR_LINE.CGColor;
    intputView.layer.borderWidth = 1;
    intputView.layer.masksToBounds = YES;
    intputView.layer.cornerRadius = 1;
    [self addSubview:intputView];
    
    //输入框
    _textView = [UITextView newAutoLayoutView];
    _textView.delegate = self;
    _textView.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
    [intputView addSubview:_textView];
    
    [_textView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:intputView withOffset:13];
    [_textView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:intputView withOffset:12];
    [_textView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:intputView withOffset:- 12];
    [_textView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:intputView withOffset:- 13];
    
    //再次投诉按钮  取消按钮
    CGSize btnSize = CGSizeMake(110, 40);
    for (int i = 0; i < 2; i ++)
    {
        UIButton *btn = [UIButton newAutoLayoutView];
        [self addSubview:btn];
        [btn autoSetDimensionsToSize:btnSize];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3;
        [btn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:intputView withOffset:15];
        btn.tag = i + BTN_TAG;
        [btn addTarget:self action:@selector(didCLickBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0)
        {
            [btn setTitle:@"再次投诉" forState:UIControlStateNormal];
            [btn setButtonGrayStyle];
            [btn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_NORMAL andSize:btnSize] forState:UIControlStateNormal];
            [btn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_HIGHLIGHT andSize:btnSize] forState:UIControlStateHighlighted];
            [btn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:20];
        }
        else
        {
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setBackgroundImage:[Utility imageWithColor:THEBUTTON_YELLOW_NORMAL andSize:btnSize] forState:UIControlStateNormal];
            [btn setBackgroundImage:[Utility imageWithColor:THEBUTTON_YELLOW_HIGHLIGHT andSize:btnSize] forState:UIControlStateHighlighted];
            [btn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:- 20];
        }
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toTap)];
    [self addGestureRecognizer:tap];
}

- (void)didCLickBtn:(UIButton *)btn
{
    [self endEditing:YES];
    if (btn.tag == BTN_TAG)
    {
        if (_textView.text.length != 0)
        {
            [self hidenView];
            
            if (_delegate && [_delegate respondsToSelector:@selector(didClickComplainBtn:)])
            {
                [_delegate didClickComplainBtn:_textView.text];
            }
        }
    }
    else
    {
        [self hidenView];
    }
}

- (void)toTap
{
    [self endEditing:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSMutableString *resultText = [textView.text mutableCopy];
    [resultText replaceCharactersInRange:range withString:text];
    if (resultText.length > 200 && range.length == 0)
    {
        return NO;
    }
    return YES;
}

@end
