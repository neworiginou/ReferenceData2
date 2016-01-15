//
//  EmptyControl.m
//  HaoWu
//
//  Created by PengHuang on 13-11-2.
//  Copyright (c) 2013年 PengHuang. All rights reserved.
//

#import "EmptyControl.h"
#import "Utility.h"

@interface EmptyControl() {
    
}

@property (nonatomic,strong) removeBtnClicked btnClickBlock;

@end

@implementation EmptyControl
@synthesize btnClickBlock = _btnClickBlock;

- (id)initWithTitle:(NSString *)_text frame:(CGRect)_frame onClick:(removeBtnClicked)_clickBlock
{
    self = [super initWithFrame:CGRectMake(_frame.origin.x, _frame.origin.y, _frame.size.width, CONTENT_HEIGHT - _frame.origin.y)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _btnClickBlock = [_clickBlock copy];
        
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _frame.size.width, _frame.size.height)];
        bgview.backgroundColor = [UIColor clearColor];
        [self addSubview:bgview];
        
        UIImageView *imgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emptyData"]];
        imgview.center = CGPointMake(_frame.size.width/2.0, _frame.size.height / 2.0f - 30 + (IPHONE4 ? 20 : 0));
        [self addSubview:imgview];
        
        UILabel *lbl = [[UILabel alloc] init];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.textColor = THEME_COLOR_TEXT;
        lbl.font = [UIFont fontWithName:FONTNAME size:16];
        lbl.frame = CGRectMake(0, CGRectGetMaxY(imgview.frame) + 10, self.frame.size.width, 30);
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = _text;
        [self addSubview:lbl];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, _frame.size.width, _frame.size.height);
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
    }
    return self;
}

- (void)btnClick
{
    if(_btnClickBlock)
        _btnClickBlock();
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
