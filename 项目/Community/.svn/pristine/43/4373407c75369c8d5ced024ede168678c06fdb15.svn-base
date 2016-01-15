//
//  HWAlertSlideChoseDateView.m
//  Community
//
//  Created by hw500027 on 15/6/16.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWAlertSlideChoseDateView.h"
#import "HWSlideChoseDateView.h"
#import "AppDelegate.h"

@interface HWAlertSlideChoseDateView() <HWSlideChoseDateViewDelegate>
{
    UIView *_backgroundView;
    NSString *_selectData;
}
@end

@implementation HWAlertSlideChoseDateView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, 0, 560 / 2, 480 / 2);
        self.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
        self.backgroundColor = [UIColor whiteColor];
        [self configUI];
    }
    return self;
}

- (void)didClickButton
{
    if (_myblock)
    {
        if (_selectData.length == 0)
        {
            _selectData = @"当天";
        }
        _myblock(_selectData);
        
        [self hidenView];
    }
}

-(void)hidenView
{
    [self.customBackgroundView removeFromSuperview];
    [self removeFromSuperview];
}


-(void)showeAlertViewWithCompleteBlock:(MyBlock)block
{
    _myblock = block;
    [self show];
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

-(void)show
{
    AppDelegate *app = SHARED_APP_DELEGATE;
    [app.window addSubview:self.customBackgroundView];
    
    [self animationAlert:self];
    [app.window addSubview:self];
}

- (void)addSlideView
{
    HWSlideChoseDateView *view = [[HWSlideChoseDateView alloc] initWithFrame:CGRectMake(0, 135 / 2, self.frame.size.width, 0)];
    view.slideViewDelegate = self;
    [self addSubview:view];
}

- (void)didSelectSlideDate:(NSString *)date
{
    NSLog(@"%@",date);
    _selectData = date;
}

- (void)configUI
{
    //标题
    UILabel *titleLabel = [UILabel newAutoLayoutView];
    [self addSubview:titleLabel];
    titleLabel.text = @"选择延长的天数";
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:21];
    [titleLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
    
    //分割线
    UIView *line = [UIView newAutoLayoutView];
    [self addSubview:line];
    [line autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:titleLabel withOffset:14];
    [line autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:0];
    [line autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:0];
    [line autoSetDimension:ALDimensionHeight toSize:0.5f];
    line.backgroundColor = THEME_COLOR_LINE;
    
    //添加滑动视图
    [self addSlideView];

    //添加按钮
    CGSize btnSize = CGSizeMake(480 / 2, 90 / 2);
    UIButton *button = [UIButton newAutoLayoutView];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 3;
    [self addSubview:button];
    [button setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_NORMAL andSize:btnSize] forState:UIControlStateNormal];
    [button setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_HIGHLIGHT andSize:btnSize] forState:UIControlStateHighlighted];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickButton) forControlEvents:UIControlEventTouchUpInside];
    
    [button autoSetDimensionsToSize:btnSize];
    [button autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:- 20];
    [button autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
}

@end
