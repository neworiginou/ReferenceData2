//
//  FootView.m
//  AlertView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "FootView.h"

#define kSpaceX (27/2.f)

#define kLineHeight (1.2f)

@interface FootView ()

@property (nonatomic, strong)UILabel *label1;

@property (nonatomic, strong)UILabel *label2;

@property (nonatomic, strong)UILabel *label3;

@end


@implementation FootView


- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UILabel *label1 = [[UILabel alloc]init];
        
        label1.text = @"收 款 日 期:";
        
        UILabel *label2 = [[UILabel alloc]init];
        
        label2.text = @"签约后凭此联到好屋中国换取发票";
        
        UILabel *label3 = [[UILabel alloc]init];
        
        label3.text = @"索取发票请致电： 400-1808-116";
        
        [self addSubview:label1];
        
        [self addSubview:label2];
        
        [self addSubview:label3];
        
        _label1 = label1;
        
        _label2 = label2;
        
        _label3 = label3;
        
        _label1.font = [UIFont systemFontOfSize:13];
        
        _label2.font = [UIFont systemFontOfSize:11.9];
        
        _label3.font = _label2.font;
        
        _label1.textColor = [UIColor colorWithRed:161/255.f green:162/255.f blue:163/255.f alpha:1.0];
        
        _label2.textColor = [UIColor colorWithRed:161/255.f green:162/255.f blue:163/255.f alpha:1.0];
        
        _label3.textColor = [UIColor colorWithRed:161/255.f green:162/255.f blue:163/255.f alpha:1.0];
        
        [self initTimeLabel];
    }
    return self;
}
- (void)initTimeLabel
{
    _timeLabel = [[UILabel alloc]init];
    
    _timeLabel.font = [UIFont systemFontOfSize:14.1];
    
    _timeLabel.textColor = [UIColor blackColor];
    
    [self addSubview:_timeLabel];
}
- (void)setSpaceX:(CGFloat)spaceX
{
    _spaceX = spaceX;
    
    _label1.frame = CGRectMake(spaceX, 11, 162/2.f, 23.7);
    
    _label2.frame = CGRectMake(spaceX, CGRectGetMaxY(_label1.frame)+15, 300, 17);
    
    _label3.frame = CGRectMake(spaceX, CGRectGetMaxY(_label2.frame), CGRectGetWidth(_label2.frame), CGRectGetHeight(_label2.frame));
    
    _timeLabel.frame = CGRectMake(CGRectGetMaxX(_label1.frame)+7, 10, 200, 23.7);
    
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, kSpaceX, 0);
    
    CGContextSetLineWidth(ctx, kLineHeight);
    
    CGContextAddLineToPoint(ctx, self.frame.size.width - kSpaceX, 0);
    
    [[UIColor colorWithRed:221/255.f green:222/255.f blue:223/255.f alpha:1.0]setStroke];
    
    CGContextDrawPath(ctx,
                      kCGPathStroke);//绘制路径path
}


@end
