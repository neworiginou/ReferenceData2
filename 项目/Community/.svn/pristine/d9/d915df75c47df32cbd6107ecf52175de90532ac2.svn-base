//
//  HWHomeServiceCell.m
//  Community
//
//  Created by niedi on 15/6/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWHomeServiceCell.h"

@interface HWHomeServiceCell ()
{
    DLable *_rightLab;
    DLable *_leftLab;
    DImageV *_buttomLine;
}
@end

@implementation HWHomeServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _leftLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:15 w:kScreenWidth - 100 - 15 h:15];
        [self.contentView addSubview:_leftLab];
        
        _rightLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:kScreenWidth - 15 - 200 y:15 w:200 h:15];
        _rightLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_rightLab];
        
        _buttomLine = [DImageV imagV:@"" frameX:0 y:44.5f w:kScreenWidth h:0.5f];
        _buttomLine.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:_buttomLine];
    }
    return self;
}

- (void)fillDataWithLeftStr:(NSString *)leftStr rightStr:(NSString *)rightStr
{
    CGRect frame = _leftLab.frame;
    CGFloat height = [Utility calculateStringWidth:leftStr font:[UIFont fontWithName:FONTNAME size:TF15] constrainedSize:CGSizeMake(kScreenWidth - 100 - 15, 10000)].height;
    frame.size.height = height;
    _leftLab.frame = frame;
    _leftLab.text = leftStr;
    
    _rightLab.center = CGPointMake(_rightLab.center.x, (30.0f + height) / 2.0f);

    _rightLab.text = rightStr;
    
    frame = _buttomLine.frame;
    frame.origin.y = 27.0f + height - 0.5f;
    _buttomLine.frame = frame;
}

//服务订单列表 带有商品数量
- (void)fillDataWithServiceListLeftStr:(NSString *)leftStr rightStr:(NSString *)rightStr
{
    CGRect frame = _leftLab.frame;
    CGFloat height = [Utility calculateStringWidth:leftStr font:[UIFont fontWithName:FONTNAME size:TF15] constrainedSize:CGSizeMake(kScreenWidth - 100 - 15, 10000)].height;
    frame.size.height = height;
    _leftLab.frame = frame;
    _leftLab.text = leftStr;
    
    if ([leftStr isEqual:@"总价"])
    {
        _rightLab.textColor = THE_COLOR_RED;
    }
    
    _rightLab.center = CGPointMake(_rightLab.center.x, (30.0f + height) / 2.0f);
    if (rightStr.length > 0)
    {
        _rightLab.text = [NSString stringWithFormat:@"%@元",rightStr];
        
        NSMutableAttributedString *str = [Utility setFullStr:leftStr fullStrWithFont:[UIFont fontWithName:FONTNAME size:TF15] fullStrWithColor:THEME_COLOR_SMOKE needChangeStrArray:@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"x"] changeStrWithFont:[UIFont fontWithName:FONTNAME size:TF15] changeStrColor:THEME_COLOR_TEXT];
        _leftLab.attributedText = str;
    }
    else
    {
        _leftLab.text = leftStr;
    }
    
    frame = _buttomLine.frame;
    frame.origin.y = 27.0f + height - 0.5f;
    _buttomLine.frame = frame;
}

- (void)setLeftGap:(BOOL)isGap
{
    if (isGap)
    {
        _buttomLine.left = 15.0f;
    }
    else
    {
        _buttomLine.left = 0.0f;
    }
}

- (void)setLeftGap:(BOOL)isGapL rigthGap:(BOOL)isGapR
{
    if (isGapL && isGapR)
    {
        _buttomLine.left = 15.0f;
        _buttomLine.width = kScreenWidth - 2 * 15;
    }
    else
    {
        if (isGapL && !isGapR)
        {
            [self setLeftGap:YES];
            _buttomLine.width = kScreenWidth - 15;
        }
        else if (isGapR && !isGapL)
        {
            [self setLeftGap:NO];
            _buttomLine.width = kScreenWidth - 15;
        }
        else
        {
            [self setLeftGap:NO];
            _buttomLine.width = kScreenWidth;
        }
    }
}

- (void)hideButtomLine:(BOOL)isHide
{
    _buttomLine.hidden = isHide;
}

+ (CGFloat)getCellHeight:(NSString *)leftStr
{
    CGFloat h = [Utility calculateStringWidth:leftStr font:[UIFont fontWithName:FONTNAME size:TF15] constrainedSize:CGSizeMake(kScreenWidth - 100 - 15, 10000)].height;
    return 27.0f + h;
}

@end
