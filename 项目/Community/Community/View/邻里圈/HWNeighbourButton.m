//
//  HWNeighbourButton.m
//  Community
//
//  Created by zhangxun on 14-9-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWNeighbourButton.h"

@implementation HWNeighbourButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        _iconIV = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:_iconIV];
        
        _countLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _countLabel.font = [UIFont fontWithName:FONTNAME size:13];
        _countLabel.textColor = [UIColor colorWithRed:154.0 / 255.0 green:158.0 / 255.0 blue:164.0 / 255.0 alpha:1];
        [self addSubview:_countLabel];
        
        self.backgroundColor = UIColorFromRGB(0xf9f9f9);
        
//        UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
//        topLine.backgroundColor = [UIColor colorWithRed:194.0 / 255.0 green:194.0 / 255.0 blue:194.0 / 255.0 alpha:1];
//        [self addSubview:topLine];
        
        
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
        lineV.backgroundColor = [UIColor colorWithRed:194.0 / 255.0 green:194.0 / 255.0 blue:194.0 / 255.0 alpha:1];
        [self addSubview:lineV];
    }
    return self;
}

/**
 *	@brief	添加事件
 *
 *	@param 	target 	目标
 *	@param 	action 	事件
 *
 *	@return	N/A
 */
- (void)addLine{
    UIView *leftLineV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5, kBottomHeight)];
    leftLineV.backgroundColor = [UIColor colorWithRed:194.0 / 255.0 green:194.0 / 255.0 blue:194.0 / 255.0 alpha:1];
    [self addSubview:leftLineV];
}

- (void)addTarget:(id)target action:(SEL)action

{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

/**
 *	@brief	设置数量 用于左侧按钮
 *
 *	@param 	count 	评论数目
 *
 *	@return	N/A
 */
- (void)setCount:(NSString *)count
{
    if ([count intValue] > 99)
    {
        _countLabel.text = @"99+";
    }else{
        _countLabel.text = count;
    }
    [_countLabel sizeToFit];
    // 33 *30    16.5 * 15
    _iconIV.image = [UIImage imageNamed:@"talks"];
    
    _iconIV.frame = CGRectMake((self.frame.size.width - 21 - 5 - _countLabel.frame.size.width) / 2.0, (self.frame.size.height - 21) / 2.0, 21, 21);
    _countLabel.frame = CGRectMake(_iconIV.frame.size.width + _iconIV.frame.origin.x + 5, (self.frame.size.height - _countLabel.frame.size.height) / 2.0 - 1, _countLabel.frame.size.width, _countLabel.frame.size.height);
    
}

/**
 *	@brief	设置标题，用于右侧按钮
 *
 *	@param 	title 	标题内容
 *
 *	@return	N/A
 */
- (void)setTitle:(NSString *)title
{
    
    _countLabel.text = title;
    [_countLabel sizeToFit];
    _iconIV.image = [UIImage imageNamed:@"setMark"];
    _iconIV.frame = CGRectMake((self.frame.size.width - 21 - 5 - _countLabel.frame.size.width) / 2.0, (self.frame.size.height - 21) / 2.0, 21, 21);
    _countLabel.frame = CGRectMake(_iconIV.frame.size.width + _iconIV.frame.origin.x + 5, (self.frame.size.height - _countLabel.frame.size.height) / 2.0 - 1, _countLabel.frame.size.width, _countLabel.frame.size.height);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.backgroundColor = [UIColor lightGrayColor];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    self.backgroundColor = UIColorFromRGB(0xf9f9f9);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.backgroundColor = UIColorFromRGB(0xf9f9f9);
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
