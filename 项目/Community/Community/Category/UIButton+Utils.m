//
//  UIButton+Utils.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "UIButton+Utils.h"

@implementation UIButton (Utils)

- (void)setActiveState
{
    self.userInteractionEnabled = YES;
    self.titleLabel.alpha = 1.0f;
    [self setBackgroundImage:[Utility imageWithColor:THEME_COLOR_ORANGE andSize:self.frame.size] forState:UIControlStateNormal];
    [self setBackgroundImage:[Utility imageWithColor:THEME_COLOR_ORANGE_HIGHLIGHT andSize:self.frame.size] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)setInactiveState
{
    self.userInteractionEnabled = NO;
    self.titleLabel.alpha = 0.5f;
//    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [self setBackgroundImage:[Utility imageWithColor:THEME_COLOR_BUTTON_INACTIVE andSize:self.frame.size] forState:UIControlStateNormal];
}

- (void)setButtonGrayStyle
{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.layer.cornerRadius = 3.5f;
//    self.layer.masksToBounds = YES;
    
    CGSize size = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];//autolayout下获取控件size-yang
    [self setBackgroundImage:[Utility imageWithColor:THEME_COLOR_GRAY andSize:self.frame.size] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:FONTNAME size:19.0f];
}

- (void)setButtonFreezeStyle
{
    [self setBackgroundColor:UIColorFromRGB(0xf5f5f5)];
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    [self setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:FONTNAME size:19.0f];
}

- (void)setButtonYellowStyle
{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.layer.cornerRadius = 3.5f;
    self.layer.masksToBounds = YES;
    [self setBackgroundImage:[Utility imageWithColor:UIColorFromRGB(0xffd200) andSize:self.frame.size] forState:UIControlStateNormal];
    [self setBackgroundImage:[Utility imageWithColor:UIColorFromRGB(0xfcbc00) andSize:self.frame.size] forState:UIControlStateHighlighted];
    self.titleLabel.font = [UIFont fontWithName:FONTNAME size:19.0f];
}

- (void)setButtonOrangeStyle
{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.layer.cornerRadius = 3.5f;
    self.layer.masksToBounds = YES;
    [self setBackgroundImage:[Utility imageWithColor:THEME_COLOR_ORANGE andSize:self.frame.size] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:FONTNAME size:19.0f];
}

- (void)setButtonRedStyle
{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[Utility imageWithColor:[UIColor redColor] andSize:self.frame.size] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:FONTNAME size:19.0f];
}

- (void)setGrayBorderStyle
{
    [self setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
    self.layer.cornerRadius = 3.5f;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = THEME_COLOR_TEXT.CGColor;
    self.layer.borderWidth = 1.0f;
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:FONTNAME size:14.0f];
}

- (void)setGreenBorderStyle
{
    [self setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
    self.layer.cornerRadius = 3.5f;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = THEME_COLOR_ORANGE.CGColor;
    self.layer.borderWidth = 1.0f;
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:FONTNAME size:14.0f];
}

- (void)setRedFillStyle
{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.layer.cornerRadius = 3.5f;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = THEME_COLOR_TEXT.CGColor;
    self.layer.borderWidth = 0.0f;
    [self setBackgroundImage:[Utility imageWithColor:THEME_COLOR_RED andSize:self.frame.size] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:FONTNAME size:14.0f];
}

- (void)setFreezeStyle
{
    [self setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
    self.backgroundColor = UIColorFromRGB(0xf6f6f6);
    self.layer.cornerRadius = 3.5f;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = UIColorFromRGB(0xe0e0e0).CGColor;
    self.layer.borderWidth = 1.0f;
}

- (void)setNonFreezeStyle
{
    [self setTitleColor:UIColorFromRGB(0x6bae00) forState:UIControlStateNormal];
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 3.5f;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = UIColorFromRGB(0x6bae00).CGColor;
    self.layer.borderWidth = 1.0f;
}

- (void)setButtonRoundStyle
{
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 3.5f;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.borderWidth = 0.0f;
}

- (void)setButtonCustomStyleWithButtonSize:(CGSize)size buttonNormalColor:(UIColor *)normalColor buttonHighlightColor:(UIColor *)highLightColor
{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:FONTNAME size:19.0f];
    self.layer.cornerRadius = 3.5f;
    self.layer.masksToBounds = YES;
    [self setBackgroundImage:[Utility imageWithColor:normalColor andSize:size] forState:UIControlStateNormal];
    [self setBackgroundImage:[Utility imageWithColor:highLightColor andSize:size] forState:UIControlStateHighlighted];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
