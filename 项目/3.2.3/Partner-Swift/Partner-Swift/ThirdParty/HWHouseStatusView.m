//
//  HWHouseStatusView.m
//  MoreHouse
//
//  Created by gusheng on 14-12-6.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//

#import "HWHouseStatusView.h"
//#import "GeneralControl.h"
@implementation HWHouseStatusView
@synthesize houseStatusLabel;
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
        
        
//        houseStatusLabel = [GeneralControl createLabel:CGRectMake(10, 10, 50, 20) font:TITLE_FUBIAOTI_SIZE textAligment:NSTextAlignmentCenter labelColor:[UIColor whiteColor]];
//        houseStatusLabel.transform = CGAffineTransformMakeRotation(M_PI*50/180.0);
//        [self addSubview:houseStatusLabel];
    }
    return self;
}
@end
