//
//  CellHeadView.m
//  AlertView
//
//  Created by lizhongqiang on 15/7/8.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "CellHeadView.h"


@interface CellHeadView ()

@property (nonatomic, strong)UIView *contentView;

@property (nonatomic, strong)UILabel *label1;

@property (nonatomic, strong)UILabel *label2;

@property (nonatomic, strong)UILabel *label3;

@end

@implementation CellHeadView

- (instancetype)init
{
    if(self = [super init])
    {
        _contentView = [[UIView alloc]init];
        
        _contentView.backgroundColor = [UIColor colorWithRed:234/255.f green:235/255.f blue:236/255.f alpha:1.0];
        
        [self addSubview:_contentView];
        
        _label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 162/2.f, 55/2.f)];
        
        _label2 = [[UILabel alloc]initWithFrame:CGRectMake(_label1.frame.size.width, 0, 205/2.f, _label1.frame.size.height)];
        
        _label3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_label2.frame), 0, 224/2.f, CGRectGetHeight(_label1.frame))];
        
        [_contentView addSubview:_label1];
        
        [_contentView addSubview:_label2];
        
        [_contentView addSubview:_label3];
        
        _label1.textAlignment = NSTextAlignmentCenter;
        
        _label2.textAlignment = NSTextAlignmentCenter;
        
        _label3.textAlignment = NSTextAlignmentCenter;
        
        _label1.font = [UIFont systemFontOfSize:12];
        
        _label2.font = _label1.font;
        
        _label3.font = _label1.font;
        
        _label1.textColor = [UIColor blackColor];
        
        _label2.textColor = _label1.textColor;
        
        _label3.textColor = _label1.textColor;
        
        _label1.text = @"支付流水号";
        
        _label2.text = @"金额(元)";
        
        _label3.text = @"支付时间";
//        
//        _label1.backgroundColor = [UIColor redColor];
//        
//        _label2.backgroundColor = [UIColor blueColor];
//        
//        _label3.backgroundColor = [UIColor purpleColor];
    }
    return self;
}
- (void)setSpaceX:(CGFloat)spaceX
{
    _spaceX = spaceX;
    
    _contentView.frame = CGRectMake(spaceX, 13.9, _centerView.frame.size.width - 2*spaceX, 57/2.f);
    
    
}
@end
