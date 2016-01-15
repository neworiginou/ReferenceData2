//
//  HWWuYeAddHouseCell.m
//  Community
//
//  Created by niedi on 15/8/6.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYeAddHouseCell.h"

@interface HWWuYeAddHouseCell ()
{
    DLable *_leftLab;
    DImageV *_buttomLine;
}
@end


@implementation HWWuYeAddHouseCell

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
    CGFloat height = [Utility calculateStringHeight:leftStr font:FONT(TF15) constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
    CGRect frame = _leftLab.frame;
    frame.size.height = height;
    _leftLab.frame = frame;
    _leftLab.text = leftStr;
    
    frame = _buttomLine.frame;
    frame.origin.y = 45.0f - 15 + height - 0.5f;
    _buttomLine.frame = frame;
}


+ (CGFloat)getCellHeight:(NSString *)leftStr
{
    CGFloat height = [Utility calculateStringHeight:leftStr font:FONT(TF15) constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
    return 45.0f - 15 + height;
}

@end
