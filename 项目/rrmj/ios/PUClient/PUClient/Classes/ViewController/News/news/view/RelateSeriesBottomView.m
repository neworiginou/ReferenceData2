//
//  RelateSeriesBottomView.m
//  PUClient
//
//  Created by RRLhy on 15/8/13.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "RelateSeriesBottomView.h"

@implementation RelateSeriesBottomView

static NSString *title;

static UIFont *font;

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        title = @"相关美剧/明星";
        
        font = SYSTEMFONT(16);
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        [self setNeedsDisplay];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    
    paragraph.alignment = NSTextAlignmentCenter;
    
    [title drawAtPoint:CGPointMake(self.center.x - 60, 15) withAttributes:@{NSFontAttributeName:SYSTEMFONT(16),NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName:paragraph}];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 0, 50);
    CGContextAddLineToPoint(ctx, Main_Screen_Width, 50);
    CGContextSetLineWidth(ctx, 0.5);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:0.80 green:0.80 blue:0.78 alpha:1.0].CGColor);
    CGContextStrokePath(ctx);
    
    
}


@end
