//
//  HWHouseStatusView.m
//  MoreHouse
//
//  Created by gusheng on 14-12-6.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//

#import "HWPriviledgeStatusView.h"
#import "HWGeneralControl.h"
@implementation HWPriviledgeStatusView
@synthesize priviledgeStatus;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView *backGroudImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        backGroudImage.image = [UIImage imageNamed:@"gray_triangle"];
        [self addSubview:backGroudImage];
        
        
        priviledgeStatus = [HWGeneralControl createLabel:CGRectMake(10, 10, 50, 20) font:13.0 textAligment:NSTextAlignmentCenter labelColor:[UIColor whiteColor]];
        priviledgeStatus.transform = CGAffineTransformMakeRotation(M_PI*50/180.0);
        [self addSubview:priviledgeStatus];
    }
    return self;
}
@end
