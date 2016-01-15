//
//  HWDottedLineView.m
//  画虚线
//
//  Created by hw500029 on 15/6/1.
//  Copyright (c) 2015年 MYP. All rights reserved.
//

#import "HWDottedLineView.h"
#import "Define-OC.h"
@implementation HWDottedLineView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(12, 0, self.frame.size.width - 24, self.frame.size.height)];
        imageView1.backgroundColor = [UIColor clearColor];
        [self addSubview:imageView1];
        
        
        UIGraphicsBeginImageContext(imageView1.frame.size);   //开始画线
        [imageView1.image drawInRect:CGRectMake(0, 0, imageView1.frame.size.width, imageView1.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
        
        
        CGFloat lengths[] = {3,2};
        CGContextRef line = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(line, TITLE_COLOR_66.CGColor);
        
        CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
        CGContextMoveToPoint(line, 0, self.frame.size.height);    //开始画线
        CGContextSetLineWidth(line, 0.5);
        CGContextAddLineToPoint(line,self.frame.size.width - 12, self.frame.size.height);
        CGContextStrokePath(line);
        
        imageView1.image = UIGraphicsGetImageFromCurrentImageContext();

    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
