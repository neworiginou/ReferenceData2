//
//  HWTianTianTuanDetailCell.m
//  Community
//
//  Created by niedi on 15/8/8.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWTianTianTuanDetailCell.h"

@interface HWTianTianTuanDetailCell ()
{
    DLable *_leftLab;
    DImageV *_buttomLine;
}
@end

@implementation HWTianTianTuanDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _leftLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:15 w:kScreenWidth - 2 * 15 h:15];
        [self.contentView addSubview:_leftLab];
        
        _buttomLine = [DImageV imagV:@"" frameX:0 y:44.5f w:kScreenWidth h:0.5f];
        _buttomLine.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:_buttomLine];
    }
    return self;
}

- (void)fillDataWithLeftStr:(NSString *)leftStr
{
    CGRect frame = _leftLab.frame;
    CGFloat height = [Utility calculateStringWidth:leftStr font:[UIFont fontWithName:FONTNAME size:TF15] constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
    frame.size.height = height;
    _leftLab.frame = frame;
    _leftLab.text = leftStr;
    
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
    CGFloat h = [Utility calculateStringWidth:leftStr font:[UIFont fontWithName:FONTNAME size:TF15] constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
    return 27.0f + h;
}

@end
