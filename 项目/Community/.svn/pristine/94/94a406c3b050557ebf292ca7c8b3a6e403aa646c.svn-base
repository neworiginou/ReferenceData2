//
//  KACircleProgressView.m
//  NotCarryDoctor
//
//  Created by gusheng on 14-8-27.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//


#import "KACircleProgressView.h"

@implementation KACircleProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _trackLayer = [CAShapeLayer new];
        [self.layer addSublayer:_trackLayer];
        _trackLayer.fillColor = nil;
        _trackLayer.frame = self.bounds;
        
        _progressLayer = [CAShapeLayer new];
        [self.layer addSublayer:_progressLayer];
        _progressLayer.fillColor = nil;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.frame = self.bounds;
        
        //默认5
        self.progressWidth = 5;
        
        _dotView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _dotView.layer.cornerRadius = CGRectGetHeight(_dotView.frame) / 2.0f;
        _dotView.backgroundColor = [UIColor redColor];
//        _dotView.layer.masksToBounds = YES;
        
        _dotView.layer.masksToBounds = NO;
        _dotView.layer.shadowColor = [UIColor whiteColor].CGColor;
        _dotView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        _dotView.layer.shadowOpacity = 1.0f;
        _dotView.layer.shadowRadius = 4;
        [self addSubview:_dotView];
    }
    return self;
}

- (void)setTrack
{
    _trackPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f) radius:(self.bounds.size.width - _progressWidth)/ 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];;
    _trackLayer.path = _trackPath.CGPath;
}

- (void)setProgress
{
    float radius = (self.bounds.size.width - _progressWidth) / 2.0f;
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.height / 2.0f);
    double endAngle = (M_PI * 2) * _progress - M_PI_2;
    
    _progressPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:-M_PI_2 endAngle:endAngle clockwise:YES];
//    _progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f) radius:(self.bounds.size.width - _progressWidth) / 2 startAngle:(M_PI * 2) * (1-_progress) - M_PI_2 endAngle:M_PI + M_PI_2 clockwise:NO];
    _progressLayer.path = _progressPath.CGPath;
    
//    NSLog(@"%g", endAngle);
    
    if (_progress == 0)
    {
        _dotView.hidden = YES;
    }
    else
    {
        _dotView.hidden = NO;
    }
    
    if (!self.hidden)
    {
        _dotView.center = CGPointMake(radius * cos(endAngle) + center.x, radius * sin(endAngle) + center.y);
    }
}


- (void)setProgressWidth:(float)progressWidth
{
    _progressWidth = progressWidth;
    _trackLayer.lineWidth = _progressWidth;
    _progressLayer.lineWidth = _progressWidth;
    
    [self setTrack];
    [self setProgress];
}

- (void)setTrackColor:(UIColor *)trackColor
{
    _trackLayer.strokeColor = trackColor.CGColor;
}

- (void)setProgressColor:(UIColor *)progressColor
{
    _progressLayer.strokeColor = progressColor.CGColor;
    _dotView.backgroundColor = THEME_COLOR_BLUE;
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    
    [self setProgress];
}

- (void)setProgress:(float)progress animated:(BOOL)animated
{
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
@end
