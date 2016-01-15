//
//  NewOldBtn.m
//  SearchView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "NewOldBtn.h"

#define kSanHeight 9.1f

#define kSanWidth 36/2.f

#define UIColorFromRGB(rgbValue)	    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation NewOldBtn


- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBtn)]];
        
    }
    return self;
}

- (void)clickBtn
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickNewOldBtn:)])
    {
        [self.delegate clickNewOldBtn:self];
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    
    [_title drawInRect:CGRectMake(4, 4, 100, 42/2.f) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:34/2.0f],NSForegroundColorAttributeName:UIColorFromRGB(0xFFFFFFF)}];
    
    if(_temp)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextBeginPath(ctx);//标记
        
        CGPoint center = CGPointMake(self.frame.size.width/2.f  , self.frame.size.height - kSanHeight);
        
        
        
        CGContextMoveToPoint(ctx, center.x, center.y);
        
        CGContextAddLineToPoint(ctx, center.x - kSanWidth/2.f, self.frame.size.height);
        
        CGContextAddLineToPoint(ctx, center.x + kSanWidth/2.f, self.frame.size.height);
        
        CGContextClosePath(ctx);//路径结束标志，不写默认封闭
        
        [[UIColor whiteColor]setFill];
        
        CGContextDrawPath(ctx,
                          kCGPathEOFill);//绘制路径path
    }
}


@end
