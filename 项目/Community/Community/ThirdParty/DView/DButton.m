//
//  DButton.m
//  DView
//
//  Created by niedi on 15/6/5.
//  Copyright (c) 2015年 haowu. All rights reserved.
//

#import "DButton.h"
#import "DView.h"

@interface DButton ()
{
    BOOL _isCancleHighlight;
}
@end

@implementation DButton

+ (DButton *)btn{
    return [self buttonWithType:UIButtonTypeCustom];
}

+ (DButton *)btnImg:(NSString *)img frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id)target action:(SEL)action
{
    return [[self btn] btnImg:img frameX:x y:y w:w h:h target:target action:action];
}

- (DButton *)btnImg:(NSString *)img frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id)target action:(SEL)action
{
    if (img)
    {
        [self setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    }
    
    self.frame = CGRectMake(x, y, w, h);
    
    if (target && action)
    {
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/** txt frame action */
+ (DButton *)btnTxt:(NSString *)txt frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id)target action:(SEL)action
{
    return [self btnTxt:txt txtFont:15 frameX:x y:y w:w h:h target:target action:action];
}

/** txt txtFont frame action */
+ (DButton *)btnTxt:(NSString *)txt txtFont:(CGFloat)tf frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id)target action:(SEL)action
{
    return [[self btn] btnTxt:txt txtFont:tf frameX:x y:y w:w h:h target:target action:action];
}


- (DButton *)btnTxt:(NSString *)txt txtFont:(CGFloat)tf frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id)target action:(SEL)action
{
    _isCancleHighlight = NO;
    if (txt)
    {
        [self setTitle:txt forState:UIControlStateNormal];
    }
    else
    {
        [self setTitle:@"" forState:UIControlStateNormal];
    }
    
    if (tf > 0)
    {
        self.titleLabel.font = [UIFont fontWithName:FONTNAME size:tf];
    }
    else
    {
        self.titleLabel.font = [UIFont fontWithName:FONTNAME size:TF15];
    }
    
    self.frame = CGRectMake(x, y, w, h);
    
    if (target && action)
    {
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)setStyle:(DBtnStyle)style
{
    switch (style) {
        case DBtnStyleMain:
        {
            self.userInteractionEnabled = YES;
            [self setBackgroundImage:[DView imageWithColor:THEME_COLOR_ORANGE andSize:self.frame.size] forState:UIControlStateNormal];
            [self setBackgroundImage:[DView imageWithColor:THEME_COLOR_ORANGE_HIGHLIGHT andSize:self.frame.size] forState:UIControlStateHighlighted];
        }
            break;
        case DBtnStyleDisabled:
        {
            self.userInteractionEnabled = NO;
            [self setBackgroundImage:[DView imageWithColor:THEBUTTON_GRAY_NORMAL andSize:self.frame.size] forState:UIControlStateNormal];
            [self setBackgroundImage:[DView imageWithColor:THEBUTTON_GRAY_HIGHLIGHT andSize:self.frame.size] forState:UIControlStateHighlighted];
        }
            break;
        case DBtnStyleRed:
        {
            self.userInteractionEnabled = YES;
            [self setBackgroundImage:[Utility imageWithColor:UIColorFromRGB(0xd64440) andSize:self.frame.size] forState:UIControlStateNormal];
            [self setBackgroundImage:[Utility imageWithColor:UIColorFromRGB(0xbf2c2d) andSize:self.frame.size] forState:UIControlStateHighlighted];
        }
            break;
        case DBtnStyleYellow:
        {
            self.userInteractionEnabled = YES;
            [self setBackgroundImage:[DView imageWithColor:THEBUTTON_YELLOW_NORMAL andSize:self.frame.size] forState:UIControlStateNormal];
            self.layer.borderWidth = 0.5f;
            self.layer.borderColor = UIColorFromRGB(0xf09d3b).CGColor;
            [self setBackgroundImage:[DView imageWithColor:THEBUTTON_YELLOW_HIGHLIGHT andSize:self.frame.size] forState:UIControlStateHighlighted];
        }
            break;
        default:
            break;
    }
}

- (void)setTxtColor:(UIColor *)txtColor
{
    [self setTitleColor:txtColor forState:UIControlStateNormal];
}

- (void)setRadiuStyle
{
    self.layer.cornerRadius = 3.5f;
    self.layer.masksToBounds = YES;
}

- (void)setRadius:(CGFloat)Radius
{
    self.layer.cornerRadius = Radius;
    self.layer.masksToBounds = YES;
}


- (void)setBorder:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = 0.5f;
}

- (void)setBorder:(UIColor *)borderColor borderWidth:(CGFloat)width
{
    [self setBorder:borderColor];
    self.layer.borderWidth = width;
}


- (void)cancleHighlighted
{
    _isCancleHighlight = YES;
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (_isCancleHighlight)
    {
        
    }
    else
    {
        [super setHighlighted:highlighted];
    }
}

@end
