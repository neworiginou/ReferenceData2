//
//  HWQuestionButton.m
//  Community
//
//  Created by lizhongqiang on 14-9-12.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWQuestionButton.h"

@implementation HWQuestionButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame unSelected:(UIImage *)img selected:(UIImage *)selectImg title:(NSString *)strTitle
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake((frame.size.width - 50)/2, 5, 50, 50)];//图片大小50X50
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        [btn setBackgroundImage:selectImg forState:UIControlStateSelected];
        
    }
    return self;
}





@end
