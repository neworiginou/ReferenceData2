//
//  UIButton+Utils.h
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Utils)

// 设置激活状态
- (void)setActiveState;
// 设置未激活状态
- (void)setInactiveState;

- (void)setButtonYellowStyle;

- (void)setButtonOrangeStyle;

- (void)setButtonGrayStyle;

- (void)setButtonFreezeStyle;

- (void)setButtonRedStyle;

- (void)setGrayBorderStyle;

- (void)setRedFillStyle;

- (void)setFreezeStyle;
- (void)setNonFreezeStyle;

- (void)setGreenBorderStyle;
//创建圆角按钮
- (void)setButtonRoundStyle;

//设置自定义按钮背景色
- (void)setButtonCustomStyleWithButtonSize:(CGSize)size buttonNormalColor:(UIColor *)normalColor buttonHighlightColor:(UIColor *)highLightColor;

@end
