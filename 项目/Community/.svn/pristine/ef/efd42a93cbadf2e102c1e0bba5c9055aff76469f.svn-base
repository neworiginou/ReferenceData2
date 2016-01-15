//
//  HWNumberButton.m
//  Community
//
//  Created by lizhongqiang on 14-9-2.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  描述：带左右加减号的按钮 无切图

#import "HWNumberButton.h"

@implementation HWNumberButton
@synthesize numLabel;
@synthesize number;
@synthesize limitNum;
@synthesize strType;

- (id)initWithFrame:(CGRect)frame Number:(int)num LimitNum:(int)limitNumber
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        number = num;
        
        minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [minusBtn setFrame:CGRectMake(0, 0, 36, 36)];
        [minusBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        [minusBtn setBackgroundImage:[UIImage imageNamed:@"subtract"] forState:UIControlStateNormal];
        [minusBtn addTarget:self action:@selector(minusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:minusBtn];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(47, 0, 90, 36)];
        [imgView setImage:[UIImage imageNamed:@"input"]];
        [self addSubview:imgView];
        
        numLabel = [[UILabel alloc] initWithFrame:CGRectMake(47, 0, 90, 36)];
        [numLabel setBackgroundColor:[UIColor clearColor]];
        [numLabel setText:[NSString stringWithFormat:@"%i",number]];
        [numLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:numLabel];
        
        addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setFrame:CGRectMake(144, 0, 36, 36)];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"addPress"] forState:UIControlStateHighlighted];
        [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addBtn];
        
        limitNum = limitNumber;
        
        if (number <= limitNum)
        {
            minusBtn.enabled = NO;
        }
        
    }
    return self;
}

//卧室",@"客厅",@"厨房",@"卫生间",@"阳台",@"花园"
- (void)minusBtnClick:(id)sender
{
    
    if ([strType isEqualToString:@"卧室"])
    {
        [MobClick event:@"click_reduce_bedroom"];
    }
    else if ([strType isEqualToString:@"客厅"])
    {
        [MobClick event:@"click_reduce_livingroom"];
    }
    else if ([strType isEqualToString:@"厨房"])
    {
        [MobClick event:@"click_reduce_kitchenroom"];
    }
    else if ([strType isEqualToString:@"卫生间"])
    {
        [MobClick event:@"click_reduce_bathroom"];
    }
    else if ([strType isEqualToString:@"阳台"])
    {
        [MobClick event:@"click_reduce_balcony"];
    }
    else if ([strType isEqualToString:@"花园"])
    {
        [MobClick event:@"click_reduce_garden"];
    }
    
    number --;
    [numLabel setText:[NSString stringWithFormat:@"%i",number]];
    
    if (number <= limitNum)
    {
        minusBtn.enabled = NO;
    }
    
    
}

- (void)addBtnClick:(id)sender
{
    
    if ([strType isEqualToString:@"卧室"])
    {
        [MobClick event:@"click_add_bedroom"];
    }
    else if ([strType isEqualToString:@"客厅"])
    {
        [MobClick event:@"click_add_livingroom"];
    }
    else if ([strType isEqualToString:@"厨房"])
    {
        [MobClick event:@"click_add_kitchenroom"];
    }
    else if ([strType isEqualToString:@"卫生间"])
    {
        [MobClick event:@"click_add_bathroom"];
    }
    else if ([strType isEqualToString:@"阳台"])
    {
        [MobClick event:@"click_add_balcony"];
    }
    else if ([strType isEqualToString:@"花园"])
    {
        [MobClick event:@"click_add_garden"];
    }
    
    number ++;
    [numLabel setText:[NSString stringWithFormat:@"%i",number]];
    if (number >= limitNum)
    {
        minusBtn.enabled = YES;
    }
}


- (int)getButtonNumber
{
    return number;
}

@end
