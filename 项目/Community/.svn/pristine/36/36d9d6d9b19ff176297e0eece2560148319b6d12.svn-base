//
//  DView.m
//  DView
//
//  Created by niedi on 15/6/5.
//  Copyright (c) 2015年 haowu. All rights reserved.
//

#import "DView.h"

@implementation DView

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (DView *)viewFrameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h
{
    return [[self alloc] initWithFrame:CGRectMake(x, y, w, h)];
}

- (void)setRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}


+ (CALayer *)layerFrameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h
{
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(x, y, w, h);
    layer.backgroundColor = THEME_COLOR_LINE.CGColor;
    return layer;
}

@end
