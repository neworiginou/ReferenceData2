//
//  LoadingView.m
//  Test
//
//  Created by zhangxun on 14-10-12.
//  Copyright (c) 2014年 zhangxun. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

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
        self.backgroundColor = [UIColor clearColor];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"run_%d",i]]];
        }
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - 115) / 2.0, (frame.size.height - 115) / 2.0, 115.0, 115.0)];
        imageV.backgroundColor = [UIColor clearColor];
        imageV.animationDuration = 0.4;
        imageV.animationImages = array;
        [self addSubview:imageV];
        [imageV startAnimating];
    }
    return self;
}

@end
