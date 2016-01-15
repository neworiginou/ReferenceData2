//
//  SQSupplementaryView.m
//  TestOne
//
//  Created by gusheng on 14-12-9.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "SQSupplementaryView.h"
#import "HWGeneralControl.h"
@implementation SQSupplementaryView
@synthesize contentLabel;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BACKGROUND_COLOR;
        contentLabel = [HWGeneralControl createLabel:CGRectMake(15, 0,kScreenWidth-2*15, 30) font:13.0f textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_GRAY_MIDDLE];
        contentLabel.tag = 1;
        [self addSubview:contentLabel];
    }
    return self;
}

@end
