//
//  HWMarginView.m
//  Community
//
//  Created by zhangxun on 15/1/16.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//类作用：封装的一个边界view，包含背景色和两条线
//      修改人         修改日期            修改内容
//
#import "HWMarginView.h"

@implementation HWMarginView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *lineV1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5f)];
        lineV1.backgroundColor = THEME_COLOR_LINE;
        [self addSubview:lineV1];
        UIView *lineV2 = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 0.5f, frame.size.width,0.5f)];
        lineV2.backgroundColor = THEME_COLOR_LINE;
        [self addSubview:lineV2];
        
        self.backgroundColor = BACKGROUND_COLOR;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
