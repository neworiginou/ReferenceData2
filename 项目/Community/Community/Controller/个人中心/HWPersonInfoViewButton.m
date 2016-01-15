//
//  HWPersonInfoViewButton.m
//  Community
//
//  Created by hw500028 on 15/1/28.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWPersonInfoViewButton.h"
#define Ratio 0.7

@implementation HWPersonInfoViewButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
       
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textColor  =[UIColor redColor];
        self.titleLabel.font  = [UIFont fontWithName:FONTNAME size:13.0f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHeight = contentRect.size.height * (Ratio );
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

#pragma mark 调整内部UILabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleHeight = contentRect.size.height * (1-Ratio);
    CGFloat titleY = contentRect.size.height - titleHeight -3;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

@end
