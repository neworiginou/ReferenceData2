//
//  NSString+ZY.h
//  CoderBlog
//
//  Created by Lixing.wang on 14-5-6.
//  Copyright (c) 2014年 Lixing.wang. All rights reserved.
//

@interface NSString (ZY)

/**
 *  计算一个字符串在限定的宽度和字体下的长度
 *
 *  @param font  限定的字体
 *  @param width 限定的宽度
 *
 *  @return 字符串的长度
 */
- (NSInteger)heightWithFont:(UIFont* )font width:(CGFloat)width;
/**
 *  根据字符串
 *
 *  @param title title名字
 *
 *  @return 返回一个宽度
 */
-(NSInteger)setButtonTitle:(NSString*)title;

//根据内容获取宽度
- (NSInteger)widthWithFont:(UIFont* )font height:(CGFloat)hight;

//按要求截取字符串
- (NSString *)stringAtIndexByCount:(NSString *)string withCount:(NSInteger)count;
/**
 *  除道连续的空格跟回车
 *
 *  @return 返回一个字符，看是不是空
 */
- (NSString*)replaceString;
@end
