//
//  HWContentImageView.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  图片上添加文字

#import "HWContentImageView.h"

@implementation HWContentImageView

@synthesize contentLab;
@synthesize contentString;
@synthesize backView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3f];
        [self addSubview:backView];
        
        self.contentLab = [[UILabel alloc] initWithFrame:CGRectZero];
        contentLab.backgroundColor = [UIColor clearColor];
        contentLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        contentLab.textColor = [UIColor whiteColor];
        contentLab.numberOfLines = 0;
        contentLab.lineBreakMode = NSLineBreakByWordWrapping;
        [backView addSubview:contentLab];
    }
    return self;
}

- (void)setContentString:(NSString *)contentStr
{
    contentString = contentStr;
    
    
    backView.frame = CGRectMake(0, 0, self.frame.size.width, 0);
    CGSize size = [Utility calculateStringHeight:contentString font:contentLab.font constrainedSize:CGSizeMake(CGRectGetWidth(backView.frame) - 20, 1000)];
    
    backView.frame = CGRectMake(0, self.frame.size.height - size.height - 10, self.frame.size.width, size.height + 10);
    self.contentLab.frame = CGRectMake(10, 5, CGRectGetWidth(backView.frame) - 20, size.height);
    self.contentLab.text = contentStr;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
