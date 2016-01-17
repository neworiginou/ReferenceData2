//
//  UIButton+CustomPosition.m
//  合伙人V3.3
//
//  Created by lizhongqiang on 16/1/16.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "UIButton+CustomPosition.h"

@implementation UIButton (CustomPosition)
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, CGRectGetWidth(contentRect), CGRectGetWidth(contentRect));
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, CGRectGetWidth(contentRect)+5, CGRectGetWidth(contentRect), CGRectGetHeight(contentRect) - CGRectGetWidth(contentRect));
}
@end
