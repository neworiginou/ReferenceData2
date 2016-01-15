//
//  RedPacketView.m
//  HaoWu_4.0
//
//  Created by zhangxun on 14-8-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "RedPacketView.h"
#import "STScratchView.h"

@implementation RedPacketView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        STScratchView *stView = [[STScratchView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:stView];
    }
    return self;
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
