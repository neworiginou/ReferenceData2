//
//  HWCustomGuideAlertView.m
//  Community
//
//  Created by hw500027 on 15/4/17.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：新手游客引导 弹出自定义alertview
//
//  修改记录：
//      姓名          日期                      修改内容
//      陆晓波        2015-04-17                创建文件
//


#import "HWCustomGuideAlertView.h"
#import "AppDelegate.h"

@interface HWCustomGuideAlertView()
{
    UIView *_backgroundView;
    UIImageView *_alertImgView;
    NSInteger _type;
}
@end

@implementation HWCustomGuideAlertView

-(id)initWithAlertType:(NSInteger)type customContent:(NSString *)content
{
    self = [super init];
    if (self)
    {
        _type = type;
        _contentText = content;
        self.backgroundColor = [UIColor colorWithWhite:0.885 alpha:0.98];
        //绑定成功
        if (type == 3)
        {
            [self bindSucceed];
        }
        else
        {
            return nil;
        }
    }
    return self;
}

-(id)initWithAlertType:(NSInteger)type
{
    self = [super init];
    if (self)
    {
        _type = type;
        self.backgroundColor = [UIColor colorWithWhite:0.885 alpha:0.98];
        //欢迎来到考拉大本营 alertView
        if (type == 0)
        {
            [self addWelcomeAlertView];
        }
        //干的漂亮 alertView
        else if (type == 1)
        {
            [self wellDoneAlertView];
        }
        //连续5次密码错误 alertView
        else if (type == 2)
        {
            [self errorPasswordAlertView];
        }
        else
        {
            return nil;
        }
    }
    return self;
}

#pragma mark --
#pragma mark 设置按钮点击效果及响应事件
-(void)buttonSetSelectEffect:(UIButton *)btn
{
    [btn setBackgroundImage:[Utility imageWithColor:[UIColor colorWithWhite:0.885 alpha:0.98] andSize:[btn systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[Utility imageWithColor:[UIColor colorWithWhite:0.8 alpha:0.98] andSize:[btn systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark --

-(void)bindSucceed
{
    self.frame = CGRectMake(0, 0, 480 / 2, 460 / 2);
    self.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    //您的考拉币已转移到正式账户中 label
    UILabel *contentLabel = [UILabel newAutoLayoutView];
    contentLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    contentLabel.text = _contentText;
    contentLabel.numberOfLines = 0;
    [self addSubview:contentLabel];
    
    [contentLabel autoSetDimension:ALDimensionWidth toSize:THEME_FONT_BIG * 14];
    [contentLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
    [contentLabel autoSetDimension:ALDimensionHeight toSize:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [contentLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:-136 / 2];
    
    //绑定成功 label
    UILabel *bindSucceedLabel = [UILabel newAutoLayoutView];
    bindSucceedLabel.text = @"绑定成功";
    bindSucceedLabel.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:bindSucceedLabel];
    [bindSucceedLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
    [bindSucceedLabel autoSetDimension:ALDimensionHeight toSize:18];
    [bindSucceedLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:contentLabel withOffset:-16];
    
    //分割线
    UIView *line = [Utility drawLineWithFrame:CGRectMake(0, 356 / 2, self.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0.671 green:0.675 blue:0.694 alpha:1.000];
    [self addSubview:line];
    
    //确认按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"我知道了" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:FONTNAME size:23];
    [btn setTitleColor:[UIColor colorWithRed:0.0f green:0.5f blue:1.0f alpha:1.0f] forState:UIControlStateNormal];
    btn.tag = 0;
    [self addSubview:btn];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line];
    [btn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:line];
    [btn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:line];
    [btn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self];
    [self buttonSetSelectEffect:btn];
}

-(void)errorPasswordAlertView
{
    self.frame = CGRectMake(0, 0, 480 / 2, 460 / 2);
    self.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    //连续5次错误密码提示 label
    UILabel *contentLabel = [UILabel newAutoLayoutView];
    contentLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    contentLabel.text = @"您已经连续5次输入密码错误，该账号已被冻结，请点击忘记密码”来解冻或明天再尝试登录";
    contentLabel.numberOfLines = 0;
    [self addSubview:contentLabel];

    [contentLabel autoSetDimension:ALDimensionWidth toSize:THEME_FONT_BIG * 14];
    [contentLabel autoSetDimension:ALDimensionHeight toSize:THEME_FONT_BIG relation:NSLayoutRelationGreaterThanOrEqual];
    [contentLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:-136 / 2];
    [contentLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
    
    //分割线
    UIView *line = [Utility drawLineWithFrame:CGRectMake(0, 356 / 2, self.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0.671 green:0.675 blue:0.694 alpha:1.000];
    [self addSubview:line];
    
    //确认按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"我知道了" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:FONTNAME size:23];
    [btn setTitleColor:[UIColor colorWithRed:0.0f green:0.5f blue:1.0f alpha:1.0f] forState:UIControlStateNormal];
    btn.tag = 0;
    [self addSubview:btn];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line];
    [btn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:line];
    [btn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:line];
    [btn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self];
    [self buttonSetSelectEffect:btn];
}

-(void)wellDoneAlertView
{
    self.frame = CGRectMake(0, 0, 564 / 2, 500 / 2);
    self.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    //作为鼓励，考拉君送你10考拉币 label
    UILabel *contentLabel = [UILabel newAutoLayoutView];
    contentLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALLTITLE];
    contentLabel.text = @"作为鼓励，考拉君送你10考拉币";
    [self addSubview:contentLabel];
    [contentLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
    [contentLabel autoSetDimension:ALDimensionHeight toSize:THEME_FONT_SMALLTITLE];
    [contentLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:-164 / 2];
    
    //干的漂亮 label
    UILabel *welldoneLabel = [UILabel newAutoLayoutView];
    welldoneLabel.text = @"干的漂亮";
    welldoneLabel.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:welldoneLabel];
    [welldoneLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
    [welldoneLabel autoSetDimension:ALDimensionHeight toSize:18];
    [welldoneLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:contentLabel withOffset:-16];
    
    //分割线
    UIView *line = [Utility drawLineWithFrame:CGRectMake(0, 420 / 2 - 20, self.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0.671 green:0.675 blue:0.694 alpha:1.000];
    [self addSubview:line];
    
    //我知道了/去花考拉币按钮
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    NSArray *btnTitle = @[@"我知道了",@"去花考拉币"];
    for (int i = 0; i < 2; i ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[btnTitle pObjectAtIndex:i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:FONTNAME size:23];
        [btn setTitleColor:[UIColor colorWithRed:0.0f green:0.5f blue:1.0f alpha:1.0f] forState:UIControlStateNormal];
        btn.tag = i;
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:btn];
        if (i == 0)
        {
            btn1 = btn;
        }
        else
        {
            btn2 = btn;
        }
    }
    [btn1 autoSetDimension:ALDimensionWidth toSize:self.frame.size.width / 2];
    [btn1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self];
    [btn1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line];
    [btn1 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self];
    
    [btn2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:btn1];
    [btn2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:btn1];
    [btn2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line];
    [btn2 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self];
    [self buttonSetSelectEffect:btn1];
    [self buttonSetSelectEffect:btn2];
    
    //按钮分割线
    CGFloat btnLineHeight = [btn1 systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    UIView *btnLine = [Utility drawLineWithFrame:CGRectMake(self.frame.size.width / 2, CGRectGetMaxY(line.frame), 0.5, btnLineHeight*2)];
    btnLine.backgroundColor = [UIColor colorWithRed:0.671 green:0.675 blue:0.694 alpha:1.000];
    [self addSubview:btnLine];
}

-(void)addWelcomeAlertView
{
    self.frame = CGRectMake(0, 0, 564 / 2, 450 / 2);
    self.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    //欢迎来到考拉大本营label
    UILabel *contentLabel = [UILabel newAutoLayoutView];
    contentLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALLTITLE];
    contentLabel.text = @"去看看邻居们在说什么";

    [self addSubview:contentLabel];
    contentLabel.numberOfLines = 1;
    contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//    contentLabel.textAlignment = NSTextAlignmentCenter;
    [contentLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
    [contentLabel autoSetDimension:ALDimensionHeight toSize:THEME_FONT_SMALLTITLE];
    [contentLabel autoSetDimension:ALDimensionWidth toSize:self.frame.size.width - 30 relation:NSLayoutRelationLessThanOrEqual];
    [contentLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:-164 / 2];
    
    //分割线
    UIView *line = [Utility drawLineWithFrame:CGRectMake(0, 330 / 2, self.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0.671 green:0.675 blue:0.694 alpha:1.000];
    [self addSubview:line];

    //我知道了/看看邻居们在说什么
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    NSArray *btnTitle = @[@"先不去",@"去看看"];
    for (int i = 0; i < 2; i ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[btnTitle pObjectAtIndex:i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:FONTNAME size:23];
        [btn setTitleColor:[UIColor colorWithRed:0.0f green:0.5f blue:1.0f alpha:1.0f] forState:UIControlStateNormal];
        btn.tag = i;
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:btn];
        if (i == 0)
        {
            btn1 = btn;
        }
        else
        {
            btn2 = btn;
        }
    }
    [btn1 autoSetDimension:ALDimensionWidth toSize:self.frame.size.width / 2];
    [btn1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self];
    [btn1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line];
    [btn1 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self];
    
    [btn2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:btn1];
    [btn2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:btn1];
    [btn2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line];
    [btn2 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self];
    [self buttonSetSelectEffect:btn1];
    [self buttonSetSelectEffect:btn2];
    
    //按钮分割线
    CGFloat btnLineHeight = [btn1 systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    UIView *btnLine = [Utility drawLineWithFrame:CGRectMake(self.frame.size.width / 2, CGRectGetMaxY(line.frame), 0.5, btnLineHeight*2)];
    btnLine.backgroundColor = [UIColor colorWithRed:0.671 green:0.675 blue:0.694 alpha:1.000];
    [self addSubview:btnLine];
//    //确认按钮
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:@"看看邻居们在说什么" forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont fontWithName:FONTNAME size:23];
//    [btn setTitleColor:[UIColor colorWithRed:0.0f green:0.5f blue:1.0f alpha:1.0f] forState:UIControlStateNormal];
//    btn.tag = 0;
//    [self addSubview:btn];
//    btn.translatesAutoresizingMaskIntoConstraints = NO;
//    [btn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line];
//    [btn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:line];
//    [btn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:line];
//    [btn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self];
//    [self buttonSetSelectEffect:btn];
}

-(void)show
{
    AppDelegate *app = SHARED_APP_DELEGATE;
    [app.window addSubview:self.customBackgroundView];
    
    [self animationAlert:self];
    [app.window addSubview:self];
    [self animationAlert:self.alertImageView];
    [app.window addSubview:self.alertImageView];
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

-(UIImageView *)alertImageView
{
    NSArray *imgArray = @[@"pop_icon3",@"pop_icon4",@"pop_icon1",@"pop_icon2"];
    
    CGSize size = [Utility calculateStringHeight:_contentText font:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG] constrainedSize:CGSizeMake(THEME_FONT_BIG * 14, 1000)];
    
    if (_alertImgView == nil)
    {
        _alertImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[imgArray pObjectAtIndex:_type]]];
        _alertImgView.frame = CGRectMake(0, self.frame.origin.y - 10 - (_contentText.length==0?0:(size.height - 18)), _alertImgView.frame.size.width, _alertImgView.frame.size.height);
        _alertImgView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2 + (_type == 0 ? 20 : 0), _alertImgView.center.y);
    }
    return _alertImgView;
}

-(void)hidenView
{
    [self.customBackgroundView removeFromSuperview];
    [self.alertImageView removeFromSuperview];
    [self removeFromSuperview];
}

-(void)sureBtnClick:(UIButton *)btn
{
    if (_completeBlock)
    {
        _completeBlock(btn.tag);
        [self hidenView];
    }
}

-(UIView *)customBackgroundView
{
    if (_backgroundView == nil)
    {
        _backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.6;
    }
    return _backgroundView;
}

-(void)showCustomGuideAlertViewWithCompleteBlock:(CompleteBlock)block
{
    _completeBlock = block;
    [self show];
}

@end
