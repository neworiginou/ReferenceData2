//
//  HeadView.m
//  AlertView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "HeadView.h"

#define kLineHeight (.32f)

#define kBtnWidth (19.f)

#define kSpaceX (27/2.f)

@interface HeadView ()

@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)UIButton *rightBtn;


@end

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if(self = [super initWithFrame:frame])
    {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - kLineHeight)];
        
        [self initTitleLabel];
      
        [self initRightBtn];
    }
    return self;
}


- (void)initTitleLabel
{
    
    _titleLabel.text = @"好屋网专用收据";
    
    _titleLabel.textColor = [UIColor blackColor];
    
    _titleLabel.font = [UIFont systemFontOfSize:17.1];
    
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_titleLabel];
    
    
    
}

- (void)initRightBtn
{
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    

    _rightBtn.frame = CGRectMake(self.frame.size.width - kSpaceX - kBtnWidth, self.frame.size.height/2.f - kBtnWidth/2.f, kBtnWidth, kBtnWidth);
    
    [_rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [_rightBtn addTarget:self action:@selector(cancelaction) forControlEvents:UIControlEventTouchUpInside];
    
    [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _rightBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [self addSubview:_rightBtn];
}
- (void)cancelaction
{
    if(self.cancelAction)
    {
        self.cancelAction();
    }
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, _spaceX, self.frame.size.height - kLineHeight);
    
    CGContextSetLineWidth(ctx, kLineHeight);
    
    CGContextAddLineToPoint(ctx, self.frame.size.width - _spaceX, self.frame.size.height - kLineHeight);
    
    [[UIColor colorWithRed:221/255.f green:222/255.f blue:223/255.f alpha:1.0]setStroke];
    
    CGContextDrawPath(ctx,
                      kCGPathStroke);//绘制路径path
}

@end
