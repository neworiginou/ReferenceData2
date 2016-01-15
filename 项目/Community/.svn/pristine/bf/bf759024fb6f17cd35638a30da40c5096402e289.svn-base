//
//  HWCustomBigAlert.m
//  Community
//
//  Created by lizhongqiang on 14-9-17.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWCustomBigAlert.h"

@implementation HWCustomBigAlert

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)init
{
    self = [super initWithFrame:[UIScreen mainScreen].applicationFrame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
        [self createView];
    }
    
    return self;
    
}

- (void)createView
{
    whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 44, 280)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 10;
    whiteView.center = CGPointMake(160, ([UIScreen mainScreen].applicationFrame.size.height + 40) / 2);
    [self addSubview:whiteView];
    
    mainView = [[UIView alloc] initWithFrame:CGRectMake(3, 3, kScreenWidth - 44 - 6, 280 - 6)];
    mainView.backgroundColor = [UIColor whiteColor];
    [whiteView addSubview:mainView];
    
    UIFont *bigFont = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    UIFont *smallFont = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    NSArray *bigArray = [[NSArray alloc] initWithObjects:@"无骚扰，更省心",@"手续费用少",@"成交容易", nil];
    NSArray *smallArray = [[NSArray alloc] initWithObjects:@"信息托管给物业，免去中介骚扰",@"物业做中间人，手续费减免",@"依托大数据支持，租房售房更容易", nil];
    NSArray *imgArray = [[NSArray alloc] initWithObjects:@"advantage1",@"advantage2",@"advantage3", nil];
    
    for (int i = 0; i < 3; i ++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 20 + 86 * i, 49, 49)];
        [imgView setBackgroundColor:[UIColor clearColor]];
        [imgView setImage:[UIImage imageNamed:imgArray[i]]];
        [mainView addSubview:imgView];
        
        UILabel *bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 25 + 86 * i, kScreenWidth - 70, 21)];
        [bigLabel setBackgroundColor:[UIColor clearColor]];
        [bigLabel setText:[bigArray objectAtIndex:i]];
        [bigLabel setFont:bigFont];
        [mainView addSubview:bigLabel];
        
        UILabel *smallLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 48 + 86 * i, kScreenWidth - 70, 21)];
        [smallLabel setBackgroundColor:[UIColor clearColor]];
        [smallLabel setFont:smallFont];
        [smallLabel setTextColor:THEME_COLOR_TEXT];
        [smallLabel setText:[smallArray objectAtIndex:i]];
        [mainView addSubview:smallLabel];
        
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 86 * 3, mainView.frame.size.width, 1)];
    [line setBackgroundColor:THEME_COLOR_LINE];
    [mainView addSubview:line];
    
    UIButton *btnRemove = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRemove setFrame:CGRectMake(3, 86 * 3, mainView.frame.size.width - 6, 40)];
    [btnRemove setTitle:@"知道了" forState:UIControlStateNormal];
    [btnRemove setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
    [btnRemove addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:btnRemove];
    
    [whiteView setFrame:CGRectMake(0, 0, kScreenWidth - 44, 298 + 6)];
    whiteView.center = CGPointMake(kScreenWidth / 2, ([UIScreen mainScreen].applicationFrame.size.height + 40) / 2);
    [mainView setFrame:CGRectMake(3, 3, kScreenWidth - 44 - 6, 298)];
}

- (void)remove
{
    CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scale.duration =0.25;
    scale.fromValue = [NSNumber numberWithFloat:1];
    scale.toValue = [NSNumber numberWithFloat:0.8];
    
    CABasicAnimation *opacity=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    opacity.duration = 0.25;
    opacity.fromValue = [NSNumber numberWithFloat:1];
    opacity.toValue = [NSNumber numberWithFloat:0];
    
    
    [whiteView.layer addAnimation:scale forKey:@"sc"];
    [whiteView.layer addAnimation:opacity forKey:@"op"];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.backgroundColor = [UIColor clearColor];
    }];
    
    [self performSelector:@selector(clear) withObject:nil afterDelay:0.20];
}

- (void)clear
{
    [self removeFromSuperview];
}

- (void)show
{
    [[[[UIApplication sharedApplication] windows] lastObject] addSubview:self];
    
    
    CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scale.duration = 0.25;
    scale.fromValue = [NSNumber numberWithFloat:2];
    scale.toValue = [NSNumber numberWithFloat:1];
    
    CABasicAnimation *opacity=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    opacity.duration = 0.25;
    opacity.fromValue = [NSNumber numberWithFloat:0];
    opacity.toValue = [NSNumber numberWithFloat:1];
    
    
    [whiteView.layer addAnimation:scale forKey:@"sc"];
    [whiteView.layer addAnimation:opacity forKey:@"op"];
}

@end
