//
//  SingleSelectButton.m
//  CallPhoneAlert
//
//  Created by lizhongqiang on 14-8-28.
//  Copyright (c) 2014年 Lizhongqiang. All rights reserved.
//

#import "HWSingleSelectButton.h"

@implementation HWSingleSelectButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame unSelectImage:(UIImage *)img selectImage:(UIImage *)selectImg
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundImage:img forState:UIControlStateNormal];
        [self setBackgroundImage:selectImg forState:UIControlStateSelected];
        [self addTarget:self action:@selector(btnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        self.selected = NO;
    }
    return self;
}

- (void)btnClickEvent:(id)sender
{
    if (self.selected == YES)
    {
        self.selected = NO;
    }
    else if (self.selected == NO)
    {
        self.selected = YES;
    }
}

- (BOOL)isBtnSelected
{
    return self.selected;
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
