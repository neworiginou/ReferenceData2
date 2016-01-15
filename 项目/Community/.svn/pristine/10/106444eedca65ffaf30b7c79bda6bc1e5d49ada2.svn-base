//
//  DTxtField.m
//  DView
//
//  Created by niedi on 15/6/5.
//  Copyright (c) 2015年 haowu. All rights reserved.
//

#import "DTxtField.h"
#import "Ddefine.h"

@implementation DTxtField

+ (DTxtField *)txtField
{
    return [[self alloc] init];
}

/** 默认提示 密文 轮廓 frame */
+ (DTxtField *)fieldTxt:(NSString *)txt frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h
{
    return [[self txtField] fieldTxt:txt frameX:x y:y w:w h:h];
}

- (DTxtField *)fieldTxt:(NSString *)txt frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h
{
    self.placeholder = txt;
    self.frame = CGRectMake(x, y, w, h);
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    return self;
}

@end
