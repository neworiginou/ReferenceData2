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

//判断手机号是否合法
- (BOOL)isTelPhoneNub:(NSString *)str
{
    if ([str length] == 0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"请输入手机号", nil) message:NSLocalizedString(@"如13526568964", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    if (str.length < 11)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    return YES;
}

//判断邮箱是否合法
- (BOOL)isValidateEmail:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}

@end
