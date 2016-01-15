//
//  RightButton.m
//  Project1.0
//
//  Created by hw500028 on 14/12/23.
//  Copyright (c) 2014年 MYP. All rights reserved.
//

#import "RightButton.h"
#define Ratio 0.7
@implementation RightButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 2.文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        
        // 3.图片的内容模式
        self.imageView.contentMode = UIViewContentModeLeft;
        
        self.titleLabel.textColor = [UIColor blackColor];
    
    }
    return self;
}


#pragma mark 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageWidth = contentRect.size.width * (1-Ratio);
    CGFloat imageHeight = contentRect.size.height;
    CGFloat imageX = contentRect.size.width * Ratio;
    return CGRectMake(imageX + 5, imageY, imageWidth, imageHeight);
}

#pragma mark 调整内部UILabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleHeight = contentRect.size.height;
    CGFloat titleWidth = contentRect.size.width *Ratio;
    return CGRectMake(titleX + 5, titleY, titleWidth, titleHeight);
}

@end
