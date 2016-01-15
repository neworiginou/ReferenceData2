//
//  HWInputBackView.m
//  Community
//
//  Created by caijingpeng.haowu on 14-9-6.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWInputBackView.h"
#import "Define-OC.h"

#define TOP_DOWN_TAG 888

@implementation HWInputBackView

- (id)initWithFrame:(CGRect)frame withLineCount:(int)count
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        for (int i = 0; i < 2; i++)
        {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, i * CGRectGetHeight(self.frame), kScreenWidth, 0.5f)];
//            line.backgroundColor = THEME_COLOR_LINE;
            line.backgroundColor = CD_LineColor;
            line.tag = TOP_DOWN_TAG + i;
            [self addSubview:line];
        }
        for (int i = 0; i < count - 1; i++)
        {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, (i + 1) * CGRectGetHeight(self.frame)/(float)count, kScreenWidth, 0.5f)];
            line.backgroundColor = CD_LineColor;
            [self addSubview:line];
        }
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    UIView *line = [self viewWithTag:(TOP_DOWN_TAG + 1)];
    line.frame = CGRectMake(0, frame.size.height - 0.5f, frame.size.width, 0.5f);
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
