//
//  DLable.m
//  DView
//
//  Created by niedi on 15/6/5.
//  Copyright (c) 2015年 haowu. All rights reserved.
//

#import "DLable.h"
#import "Ddefine.h"

@implementation DLable

+ (DLable *)lab{
    return [[self alloc]init];
}

/** title txtFont frame */
+ (DLable *)LabTxt:(NSString *)txt txtFont:(CGFloat)tf frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h
{
    return [self LabTxt:txt txtFont:tf txtColor:THEME_COLOR_SMOKE frameX:x y:y w:w h:h];
}


/** title txtFont txtColor frame */
+ (DLable *)LabTxt:(NSString *)txt txtFont:(CGFloat)tf txtColor:(UIColor *)txtColor frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h
{
    return [[self lab] LabTxt:txt txtFont:tf txtColor:txtColor frameX:x y:y w:w h:h];
}

- (DLable *)LabTxt:(NSString *)txt txtFont:(CGFloat)tf txtColor:(UIColor *)txtColor frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h
{
    self.backgroundColor = [UIColor clearColor];
    self.numberOfLines = 0;
    
    if (txt)
    {
        self.text = txt;
    }
    else
    {
        self.text = @"";
    }
    
    if (tf > 0)
    {
        self.font = [UIFont fontWithName:FONTNAME size:tf];
    }
    else
    {
        self.font = [UIFont fontWithName:FONTNAME size:TF15];
    }
    
    self.textColor = txtColor;
    
    self.frame = CGRectMake(x, y, w, h);
    
    return self;
}


- (void)setRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    
}


@end
