//
//  HWLine.m
//  HaoWuAgenciesEdition
//
//  Created by zhuming on 14-6-11.
//  Copyright (c) 2014年 ZhuMing. All rights reserved.
//

#import "HWLine.h"

@implementation HWLine

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib
{
    self.frame = CGRectMake([_x floatValue] , [_y floatValue], [_w floatValue], [_h floatValue]);
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
