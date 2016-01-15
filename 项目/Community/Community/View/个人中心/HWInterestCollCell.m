//
//  HWInterestCollCell.m
//  Community
//
//  Created by lizhongqiang on 14-10-12.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWInterestCollCell.h"

@implementation HWInterestCollCell
{
    
}
@synthesize interestName;
@synthesize btnName;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        btnName = [UIButton buttonWithType:UIButtonTypeCustom];
        btnName.frame = CGRectMake(0, 0, 87, 35);
        btnName.layer.cornerRadius = 5;
        btnName.layer.masksToBounds = YES;
        btnName.layer.borderWidth = 0.5f;
        btnName.layer.borderColor = THEME_COLOR_TEXT.CGColor;
        [btnName setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
//        btnName.backgroundColor = THEME_COLOR_GRAY_MIDDLE;
        [self addSubview:btnName];
        
        self.userInteractionEnabled = YES;
    }
    
    return self;
}


@end
