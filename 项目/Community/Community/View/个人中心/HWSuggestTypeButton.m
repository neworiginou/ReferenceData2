//
//  HWSuggestTypeButton.m
//  Community
//
//  Created by zhangxun on 14-9-18.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWSuggestTypeButton.h"

@implementation HWSuggestTypeButton
@synthesize hasSelected;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        sigImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12.5, 20, 20)];
        sigImageV.image = [UIImage imageNamed:@"type_unsel"];
        [self addSubview:sigImageV];
        
        _titleLabe = [[UILabel alloc]initWithFrame:CGRectMake(40, 12.5, 50, 20)];
        _titleLabe.textColor = [UIColor lightGrayColor];
        _titleLabe.backgroundColor = [UIColor clearColor];
        _titleLabe.font = [UIFont fontWithName:FONTNAME size:14];
        [self addSubview:_titleLabe];
        self.hasSelected = NO;
        
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _titleLabe.text = title;
}

- (void)setSel{
    sigImageV.image = [UIImage imageNamed:@"type_sel"];
    self.hasSelected = YES;
}

- (void)setUnsel{
    sigImageV.image = [UIImage imageNamed:@"type_unsel"];
    self.hasSelected= NO;
}

- (void)addTarget:(id)target action:(SEL)selector{
    sigImageV.userInteractionEnabled = YES;
    _titleLabe.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:selector];
    [self addGestureRecognizer:tap];
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
