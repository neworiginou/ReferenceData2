//
//  NSString+ZY.m
//  CoderBlog
//
//  Created by Lixing.wang on 14-5-6.
//  Copyright (c) 2014年 Lixing.wang. All rights reserved.
//

#import "NSString+ZY.h"

@implementation NSString (ZY)

#pragma mark - Public
//根据字符串获得高度
- (NSInteger)heightWithFont:(UIFont* )font width:(CGFloat)width {
    CGRect bounds = CGRectZero;

    bounds = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil];
    
    return ceilf(bounds.size.height);
}

//获取button 的width
- (NSInteger)setButtonTitle:(NSString*)title
{
    NSDictionary* attribute=@{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    
    CGSize size=CGSizeMake(0,0);

    size=[title boundingRectWithSize:CGSizeMake(100, 0) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
 
    return ceil(size.width);
    
}

//根据内容获取宽度
- (NSInteger)widthWithFont:(UIFont* )font height:(CGFloat)hight
{
    CGRect bounds = CGRectZero;
    
    bounds = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, hight) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
  
    return ceilf(bounds.size.width);
}

//按要求截取字符串
- (NSString *)stringAtIndexByCount:(NSString *)string withCount:(NSInteger)count
{
    int i;
    int sum=0;
    for(i=0;i<[string length];i++)
    {
        unichar str = [string characterAtIndex:i];
        if(str < 256){
            sum+=1;
        }
        else {
            sum+=2;
        }
        if(sum>count){
            //当字符大于count时，剪取三个位置，显示省略号。否则正常显示
            NSString * str=[string substringWithRange:NSMakeRange(0,[self charAtIndexByCount:string withCount:count-3])];
            
            return [NSString stringWithFormat:@"%@...",str];
        }
    }

    return string;
}

//超过count时，截取字符
- (NSInteger)charAtIndexByCount:(NSString *)string withCount:(NSInteger)count
{
    int i;
    int sum=0;
    int count2=0;
    for(i=0;i<[string length];i++)
    {
        unichar str = [string characterAtIndex:i];
        if(str < 256){
            sum+=1;
        }
        else {
            sum+=2;
        }
        count2++;
        if (sum>=count){
            break;
        }
    }
    if(sum>count){
        return count2-1;
    }
    else
        return count2;
}

- (NSString*)replaceString
{
    NSString * str = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return str;
}

@end
