
//
//  HWCountDownView.m
//  Community
//
//  Created by niedi on 15/5/7.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWCountDownView.h"

#define ksrate        kScreenRate
#define counDownWidth 85 * ksrate
#define counDownHeigh 20 * ksrate

#define twoNumWidth   19 * ksrate
#define threeNumWidth 26 * ksrate

@interface HWCountDownView ()
{
    NSString *_firstStr;
    NSString *_secondStr;
    NSString *_thirdStr;
    
    UILabel *_numLab0;
    UILabel *_dotLab0;
    UILabel *_numLab1;
    UILabel *_dotLab1;
    UILabel *_numLab2;
    
    NSUInteger _lastFirstLength;
}

@end

@implementation HWCountDownView


+ (instancetype)countDownViewFrame:(CGRect)frame first:(NSString *)str0 second:(NSString *)str1 third:(NSString *)str2
{
    return [[HWCountDownView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, counDownWidth, counDownHeigh) first:str0 second:str1 third:str2];
}

- (instancetype)initWithFrame:(CGRect)frame first:(NSString *)str0 second:(NSString *)str1 third:(NSString *)str2
{
    if (self = [super initWithFrame:frame])
    {
        self.layer.masksToBounds = YES;
        
        _lastFirstLength = str0.length;
        _firstStr = str0;
        _secondStr = str1;
        _thirdStr = str2;
        
        
        _numLab0 = [self numView:str0];
        _numLab0.frame = CGRectMake(0, 0, _numLab0.frame.size.width, _numLab0.frame.size.height);
//        UIImageView *img1 = [[UIImageView alloc] initWithFrame:_numLab0.frame];
//        [img1 setImage:[UIImage imageNamed:@"homecut"]];
//        [self addSubview:img1];
        [self addSubview:_numLab0];
        
        
        _dotLab0 = [self dotview];
        _dotLab0.frame = CGRectMake(CGRectGetMaxX(_numLab0.frame), 0, _dotLab0.frame.size.width, _dotLab0.frame.size.height);
        [self addSubview:_dotLab0];
        
        
        _numLab1 = [self numView:str1];
        _numLab1.frame = CGRectMake(CGRectGetMaxX(_dotLab0.frame), 0, _numLab1.frame.size.width, _numLab1.frame.size.height);
//        UIImageView *img2 = [[UIImageView alloc] initWithFrame:_numLab1.frame];
//        [img2 setImage:[UIImage imageNamed:@"homecut"]];
//        [self addSubview:img2];
        [self addSubview:_numLab1];
        
        
        _dotLab1 = [self dotview];
        _dotLab1.frame = CGRectMake(CGRectGetMaxX(_numLab1.frame), 0, _dotLab1.frame.size.width, _dotLab1.frame.size.height);
        [self addSubview:_dotLab1];
        
        
        _numLab2 = [self numView:str2];
        _numLab2.frame = CGRectMake(CGRectGetMaxX(_dotLab1.frame), 0, _numLab2.frame.size.width, _numLab2.frame.size.height);
//        UIImageView *img3 = [[UIImageView alloc] initWithFrame:_numLab2.frame];
//        [img3 setImage:[UIImage imageNamed:@"homecut"]];
//        [self addSubview:img3];
        [self addSubview:_numLab2];
        
    }
    return self;
}

- (void)setStr:(NSString *)str0 second:(NSString *)str1 third:(NSString *)str2
{
    if (str0.length != _lastFirstLength)
    {
        _lastFirstLength = str0.length;
        
        CGFloat firstWidth = str0.length == 2 ? twoNumWidth : threeNumWidth;
        _numLab0.frame = CGRectMake(0, 0, firstWidth, _numLab0.frame.size.height);
        _dotLab0.frame = CGRectMake(CGRectGetMaxX(_numLab0.frame), 0, _dotLab0.frame.size.width, _dotLab0.frame.size.height);
        _numLab1.frame = CGRectMake(CGRectGetMaxX(_dotLab0.frame), 0, _numLab1.frame.size.width, _numLab1.frame.size.height);
        _dotLab1.frame = CGRectMake(CGRectGetMaxX(_numLab1.frame), 0, _dotLab1.frame.size.width, _dotLab1.frame.size.height);
        _numLab2.frame = CGRectMake(CGRectGetMaxX(_dotLab1.frame), 0, _numLab2.frame.size.width, _numLab2.frame.size.height);
    }
    
    if (![str0 isEqualToString:_firstStr] && str0 != nil)
    {
        _numLab0.text = str0;
    }
    
    if (![str1 isEqualToString:_secondStr] && str1 != nil)
    {
        _numLab1.text = str1;
    }
    
    if (![str2 isEqualToString:_thirdStr] && str2 != nil)
    {
        _numLab2.text = str2;
    }
}


- (UILabel *)numView:(NSString *)numStr
{
    CGFloat firstWidth = numStr.length == 2 ? twoNumWidth : threeNumWidth;
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, firstWidth, counDownHeigh)];
    numLab.backgroundColor = THEME_COLOR_SMOKE;
    numLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13 * ksrate];
    numLab.textColor = [UIColor whiteColor];
    numLab.textAlignment = NSTextAlignmentCenter;
    numLab.text = numStr;
    numLab.layer.cornerRadius = 3;
    numLab.layer.masksToBounds = YES;
    return numLab;
}

- (UILabel *)dotview
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 9 * ksrate, counDownHeigh)];
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = THEME_COLOR_SMOKE;
    lab.text = @":";
    lab.textAlignment = NSTextAlignmentCenter;
    return lab;
}

@end
