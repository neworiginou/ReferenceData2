//
//  HWCountDownCustomView.m
//  customCount
//
//  Created by hw500028 on 4/2/15.
//  Copyright (c) 2015 YL. All rights reserved.
//

#import "HWCountDownCustomView.h"
//#import <ALView+PureLayout.h>
#import "UIView+AutoLayout.h"
#import "AppDelegate.h"
@interface HWCountDownCustomView()
{
    CGFloat _currentCenterX;
    CGFloat endTime;
    NSInteger countDownTime;
    CGFloat _timeLineImgVWidth;
    
}
@property (nonatomic, strong) UIView * backgroundView;
@property (nonatomic, strong) UIView * countDownView;
@property (nonatomic, strong) UIImageView * slideView;
@property (nonatomic, strong) NSLayoutConstraint * slideViewCenterX;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * awakeContent;
@property (nonatomic, strong) UIButton * sureBtn;
@property (nonatomic, strong) NSString *type;
@end
@implementation HWCountDownCustomView
@synthesize type;
#define kScreenWidth     [UIScreen mainScreen].bounds.size.width
#define FONT(fontsize)           [UIFont fontWithName:@"Helvetica Neue" size:fontsize]

- (instancetype)initWithFrame:(CGRect)frame WithType:(NSString *)strType
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.type = strType;
        countDownTime = 15; // 默认 15 分钟
        _currentCenterX = 0;
        _countDownView = [UIView newAutoLayoutView];
        [self addSubview:_countDownView];
        [_countDownView autoCenterInSuperview];
        [_countDownView autoSetDimensionsToSize:CGSizeMake(kScreenWidth - 30, 240)];
        _countDownView.layer.cornerRadius = 3.0f;
        _countDownView.layer.masksToBounds = YES;
        _countDownView.backgroundColor = [UIColor whiteColor];
        
        UILabel * title = [UILabel newAutoLayoutView];
        [_countDownView addSubview:title];
        [title autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        [title autoAlignAxisToSuperviewAxis:ALAxisVertical];
//        title.text = @"开始倒计时提醒";
        title.text = [NSString stringWithFormat:@"%@倒计时提醒",self.type];
        
        self.awakeContent = [UILabel newAutoLayoutView];
        [_countDownView addSubview:self.awakeContent];
        [self.awakeContent autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:title withOffset:25];
        [self.awakeContent autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        self.awakeContent.text = [NSString stringWithFormat:@"%@前15分钟,闹铃提醒我",self.type];
//        self.awakeContent.text = @"开始前15分钟,闹铃提醒我";
        self.awakeContent.font = FONT(14.0f);
        
        UIImageView *timeLineImgV = [UIImageView newAutoLayoutView];
        [_countDownView addSubview:timeLineImgV];
        [timeLineImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.awakeContent withOffset:35];
        [timeLineImgV autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [timeLineImgV autoSetDimensionsToSize:CGSizeMake(kScreenWidth - 70, 33)];
        timeLineImgV.image = [UIImage imageNamed:@"timeLine"];
        timeLineImgV.userInteractionEnabled = YES;
        _timeLineImgVWidth = [timeLineImgV systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].width;

        UILabel *hwlabel1 = [UILabel newAutoLayoutView];
        [_countDownView addSubview:hwlabel1];
        [hwlabel1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:timeLineImgV withOffset:-10];
        hwlabel1.text = @"关闭";
        hwlabel1.font = FONT(13.0);
        hwlabel1.textColor = [UIColor blackColor];
        [hwlabel1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:timeLineImgV withOffset:5.0];
        
        UILabel * hwlabel2 = [UILabel newAutoLayoutView];
        [_countDownView addSubview:hwlabel2];
        [hwlabel2 autoAlignAxis:ALAxisVertical toSameAxisOfView:timeLineImgV];
        [hwlabel2 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:hwlabel1 withOffset:0];
        hwlabel2.text = @"15min";
        hwlabel2.font = FONT(13.0f);
        
        UILabel * hwlabel3 = [UILabel newAutoLayoutView];
        [_countDownView addSubview:hwlabel3];
        [hwlabel3 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:hwlabel1 withOffset:0];
        [hwlabel3 autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:timeLineImgV withOffset:10];
        hwlabel3.text = @"30min";
        hwlabel3.font = FONT(13.0f);
        _slideView = [UIImageView newAutoLayoutView];
        [timeLineImgV addSubview:_slideView];
        _slideViewCenterX = [_slideView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_slideView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_slideView autoSetDimensionsToSize:CGSizeMake(30, 30)];
        _slideView.image = [UIImage imageNamed:@"orangeDot"];
        _slideView.userInteractionEnabled = YES;
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
        [_slideView addGestureRecognizer:panGesture];
        
        self.timeLabel = [UILabel newAutoLayoutView];
        [timeLineImgV addSubview:_timeLabel];
        [_timeLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:_slideView];
        [_timeLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_slideView withOffset: -30];
        _timeLabel.font = FONT(15.0f);
        _timeLabel.textColor = UIColorFromRGB(0x55bb23);
        [_timeLabel setText:@"15min"];
        
        CALayer *line = [[CALayer alloc] init];
        line.frame = CGRectMake(0, 240 - 45 - 0.5f, kScreenWidth - 30, 0.5f);
        line.backgroundColor = THEME_COLOR_LINE.CGColor;
        [_countDownView.layer addSublayer:line];
        
        self.sureBtn = [UIButton newAutoLayoutView];
        [_countDownView addSubview:self.sureBtn];
        [self.sureBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        [self.sureBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth - 30, 45)];
        [self.sureBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [self.sureBtn setBackgroundImage:[Utility imageWithColor:THEME_COLOR_TEXTBACKGROUND andSize:CGSizeMake(kScreenWidth - 30, 45)] forState:UIControlStateNormal];
        [self.sureBtn setBackgroundImage:[Utility imageWithColor:UIColorFromRGB(0xc2c2c2) andSize:CGSizeMake(kScreenWidth - 30, 45)] forState:UIControlStateHighlighted];
        [self.sureBtn setTitleColor:THEME_COLOR_SMOKE forState:UIControlStateNormal];
        [self.sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return self;
}

- (void)show
{
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del.window addSubview:self.backgroundView];
        [del.window addSubview:self];
    });


}

- (UIView *)backgroundView
{
    if (_backgroundView == nil)
    {
        _backgroundView = [[UIView alloc]initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.6;
        
    }
    return _backgroundView;
}


- (void)handleGesture:(UIPanGestureRecognizer *)pan
{
    CGFloat width = kScreenWidth - 70;
    CGFloat centerY = width /2;
    CGPoint transtion = [pan translationInView:pan.view.superview];
    CGPoint location = [pan locationInView:pan.view.superview];
    _slideViewCenterX.constant = _currentCenterX + transtion.x;
    int nearbyTime = floorf(location.x/(width / 30));
    NSLog(@"%f",_slideViewCenterX.constant);
    if (location.x <= 0)
    {
        _slideViewCenterX.constant = (-(kScreenWidth - 70) / 2);
    }
    if (location.x >= (kScreenWidth - 70))
    {
        _slideViewCenterX.constant = (kScreenWidth - 70) / 2;

    }
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
            
            if (_slideViewCenterX.constant < 0) {
                nearbyTime = floorf((centerY - (-(_slideViewCenterX.constant))) / (width/30)) ;
            }
            else
            {
                nearbyTime = floorf((centerY + _slideViewCenterX.constant) / (width/30)) ;
            }
            self.timeLabel.text = [NSString stringWithFormat:@"%dmin",nearbyTime];

            break;
        case UIGestureRecognizerStateEnded:
            _currentCenterX = _slideViewCenterX.constant;
            if (_slideViewCenterX.constant < 0) {
                nearbyTime = floorf((centerY - (-(_slideViewCenterX.constant))) / (width/30)) ;
            }
            else
            {
                nearbyTime = floorf((centerY + _slideViewCenterX.constant) / (width/30)) ;
            }
            self.awakeContent.text = [NSString stringWithFormat:@"%@前%d分钟,闹铃提醒我",self.type,nearbyTime];
            countDownTime = nearbyTime;
            NSLog(@"fdsf");
            if (self.afterSureBtnBlock)
            {
                self.afterSureBtnBlock(_slideViewCenterX.constant);
            }
            break;
        case UIGestureRecognizerStateFailed:
            break;
        default:
            break;
    }
}

- (void) sureBtnClick
{
    NSInteger seconds = countDownTime * 60;
    if (self.sureBtnBlock)
    {
        self.sureBtnBlock(seconds);
    }
    [self.backgroundView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)resetSlideViewWithMinutes:(NSString *)minutes withConstant:(float)constant
{
    self.timeLabel.text = [NSString stringWithFormat:@"%dmin",[minutes integerValue]];
    self.awakeContent.text = [NSString stringWithFormat:@"%@前%d分钟,闹铃提醒我",self.type,[minutes integerValue]];
    float floatTime = (float)countDownTime * 2;
    _currentCenterX = _timeLineImgVWidth / floatTime * ([minutes integerValue] - countDownTime);
    _slideViewCenterX.constant = constant;
}

@end
