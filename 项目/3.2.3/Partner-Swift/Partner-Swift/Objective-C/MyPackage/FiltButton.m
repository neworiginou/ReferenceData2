//
//  FiltButton.m
//  HaoWu_4.0
//
//  Created by zhangxun on 14-5-24.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "FiltButton.h"

@implementation FiltButton
@synthesize titleIV = _titleIV, titleLabe = _titleLabe;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    _titleLabe = [[UILabel alloc]init];
    _titleLabe.backgroundColor = [UIColor clearColor];
    
    _titleLabe.userInteractionEnabled = YES;
    _titleLabe.frame = CGRectZero;
    [self addSubview:_titleLabe];
    
    _titleIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"filter_down2"]];
    _titleIV.userInteractionEnabled = YES;
    _titleIV.frame = CGRectZero;
    [self addSubview:_titleIV];
    
    return self;
}

- (void)setTitle:(NSString *)title{
//    CGSize size = [title sizeWithFont:_titleLabe.font];
    _titleLabe.text = title;
    [_titleLabe sizeToFit];
    _titleLabe.center = CGPointMake(self.frame.size.width / 2.0 - _titleIV.image.size.width/2.0f + 3, self.frame.size.height/2.0f);
    
    _titleIV.frame = CGRectMake(_titleLabe.frame.origin.x + _titleLabe.frame.size.width + 5 , (self.frame.size.height - _titleIV.image.size.height/2) / 2.0, 8, 5);
    
    
}

- (void)setTitleRightAlignment
{
    _titleIV.frame = CGRectMake(self.frame.size.width - 5 - 5, (self.frame.size.height - _titleIV.image.size.height/2)/2.0f, 8, 5);
    _titleLabe.frame = CGRectMake(CGRectGetMinX(_titleIV.frame) - _titleLabe.frame.size.width - 5, (self.frame.size.height - _titleLabe.frame.size.height)/2.0f, _titleLabe.frame.size.width, _titleLabe.frame.size.height);
}

- (void)addTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
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
