//
//  Switch.m
//  PUClient
//
//  Created by lizhongqiang on 15/7/31.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "Switch.h"

@implementation Switch

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //self.layer.masksToBounds = YES;
    }
    return self;
}
- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(70, 16);
    [super setFrame:frame];
}
- (void)setBounds:(CGRect)bounds
{
    bounds.size = CGSizeMake(70, 16);
    [super setBounds:bounds];
}
@end
