//
//  ETIMonthHeaderView.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/3/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "CalendarMonthHeaderView.h"

#define kScale (667/2200.f)
@interface CalendarMonthHeaderView ()
@property (weak, nonatomic) UILabel *day1OfTheWeekLabel;
@property (strong, nonatomic)CALayer *linerLayer;
@end


#define CATDayLabelWidth  40.0f
#define CATDayLabelHeight 150.0f*kScale

@implementation CalendarMonthHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)setup
{
    
    self.clipsToBounds = YES;
    
    //月份
    UILabel *masterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0, [UIScreen mainScreen].bounds.size.width, 151.f*kScale)];
    [masterLabel setBackgroundColor:[UIColor whiteColor]];
    [masterLabel setTextAlignment:NSTextAlignmentCenter];
    [masterLabel setFont:[UIFont fontWithName:@"ArialMT Regular" size:48.0f*kScale]];
    self.masterLabel = masterLabel;
    //self.masterLabel.textColor = UIColorWithRGB(34, 34, 34);
    [self addSubview:self.masterLabel];
    
    _linerLayer = [CALayer layer];
    //_linerLayer.backgroundColor = UIColorWithRGB(206, 206, 206).CGColor;
    [self.layer addSublayer:_linerLayer];
    _linerLayer.frame = CGRectMake(0, masterLabel.bounds.size.height - 0.5, masterLabel.bounds.size.width, 0.5);
    



}


@end
