//
//  HWChangeTextField.m
//  Community
//
//  Created by zhangxun on 14-9-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWChangeTextField.h"

@implementation HWChangeTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        UIView *lineV1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        lineV1.backgroundColor = THEME_COLOR_LINE;
        [self addSubview:lineV1];
        
        UIView *lineV2 = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 0.5, kScreenWidth, 0.5)];
        lineV2.backgroundColor = THEME_COLOR_LINE;
        [self addSubview:lineV2];
        
        UIView *leftV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, frame.size.height)];
        leftV.backgroundColor = [UIColor whiteColor];
        self.leftView = leftV;
        
        UIView *llV1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0.5)];
        llV1.backgroundColor = THEME_COLOR_LINE;
        [leftV addSubview:llV1];
        
        UIView *llV2 = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 0.5, 10, 0.5)];
        llV2.backgroundColor = THEME_COLOR_LINE;
        [leftV addSubview:llV2];
        
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.secureTextEntry = YES;
        
        self.font = [UIFont fontWithName:FONTNAME size:15];
        self.textColor = THEME_COLOR_SMOKE;
        
    }
    return self;
}

@end
