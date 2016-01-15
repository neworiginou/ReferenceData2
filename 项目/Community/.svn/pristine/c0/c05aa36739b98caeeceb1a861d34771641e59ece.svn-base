//
//  DButton.h
//  DView
//
//  Created by niedi on 15/6/5.
//  Copyright (c) 2015年 haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DBtnStyle) {
    DBtnStyleMain = 0,                          // 主色调
    DBtnStyleYellow,
    DBtnStyleRed,

    DBtnStyleDisabled = NSIntegerMax,
};


@interface DButton : UIButton

/*
 *  各属性传nil或0，取默认值
 *  默认值：    tf = 15；txt = @"button"; action为空
 *
 */


/** txt frame action */
+ (DButton *)btnTxt:(NSString *)txt frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id)target action:(SEL)action;

/** txt txtFont frame action */
+ (DButton *)btnTxt:(NSString *)txt txtFont:(CGFloat)tf frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id)target action:(SEL)action;

+ (DButton *)btnImg:(NSString *)img frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id)target action:(SEL)action;


- (void)setStyle:(DBtnStyle)style;

- (void)setTxtColor:(UIColor *)txtColor;

- (void)setRadiuStyle;

- (void)setRadius:(CGFloat)Radius;

- (void)setBorder:(UIColor *)borderColor;

- (void)setBorder:(UIColor *)borderColor borderWidth:(CGFloat)width;

- (void)cancleHighlighted;


@end


///** txt txtColor frame action */
//+ (UIButton *)txt:(NSString *)txt txtFont:(CGFloat)tf frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h txtColor:(UIColor *)tColor target:(id)target action:(SEL)action;
//
///** txt txtColor backColor frame action */
//+ (UIButton *)txt:(NSString *)txt txtFont:(CGFloat)tf txtColor:(UIColor *)tColor backColor:(UIColor *)backColor frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id)target action:(SEL)action;     //设置backColor即添加此颜色的backImg
