//
//  RRMJTool.m
//  PUClient
//
//  Created by RRLhy on 15/7/31.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "RRMJTool.h"

@implementation RRMJTool

#pragma mark 通过城市名字，获得对应的地点代号
+ (NSString *)getValueWithCity:(NSString*)city
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"cityKey" ofType:@"plist"];
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSDictionary * dic = [dictionary objectForKey:@"CityName"];
    NSArray * keysAarry = [dic allKeys];
    NSString * value = @"";
    for (NSString * key in keysAarry) {
        
        if ([city isEqualToString:key]) {
            
            value  = [dic objectForKey:key];
            break;
        }
    }
    return value;
}

#pragma mark 通过城市代号，获得对应的城市名称
+ (NSString *)getKeyWith:(NSString * )value
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"cityKey"  ofType:@"plist"];
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSDictionary * dic = [dictionary objectForKey:@"CityName"];
    NSString * city = @"";
    
    if ([value isEqualToString:@""]) {
        city = @"选择城市";
    }else
    {
        NSArray * keysAarry = [dic allKeys];
        for (NSString * key in keysAarry) {
            NSString * oneValue = [dic objectForKey:key];
            if ([value isEqualToString:oneValue]) {
                city = key;
                break;
            }
        }
    }
    return city;
}

+ (UIImage*)levelImageWith:(NSInteger)level
{
    UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_me_grade%ld",(long)level]];
    return image;
}
+ (UIImage*)sexImageWith:(NSString *)sex
{
    UIImage * image;
    if ([sex isEqualToString:@"0"]) {
        image = [UIImage imageNamed:@"icon_me_female"];
    }else if([sex isEqualToString:@"1"]){
        image = [UIImage imageNamed:@"icon_me_male"];
    }else{
        image = nil;
    }
    return image;
}

+ (NSMutableAttributedString*)setLineSpacing:(CGFloat)spacing string:(NSString *)text
{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    return attributedString;
}

@end
