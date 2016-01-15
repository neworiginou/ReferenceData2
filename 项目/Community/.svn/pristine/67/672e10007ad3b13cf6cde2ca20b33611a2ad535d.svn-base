//
//  HWGridView.m
//  camera
//
//  Created by caijingpeng.haowu on 14-9-1.
//  Copyright (c) 2014年 caijingpeng.haowu. All rights reserved.
//

#import "HWGridView.h"

@implementation HWGridView

- (void)initialLine
{
    for (int i = 0; i < 4; i++)
    {
        float originX;
        float originY;
        float width;
        float height;
        
        if (i == 0)
        {
            originX = self.frame.size.width/3.0f;
            originY = 0;
            width = 0.5f;
            height = self.frame.size.height;
        }
        else if (i == 1)
        {
            originX = self.frame.size.width/3.0f * 2;
            originY = 0;
            width = 0.5f;
            height = self.frame.size.height;
        }
        else if (i == 2)
        {
            originX = 0;
            originY = self.frame.size.height/3.0f;
            width = self.frame.size.width;
            height = 0.5f;
        }
        else
        {
            originX = 0;
            originY = self.frame.size.height/3.0f * 2;
            width = self.frame.size.width;
            height = 0.5f;
        }
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, width, height)];
        line.backgroundColor = [UIColor whiteColor];
        [self addSublayer:line.layer];
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self initialLine];
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
