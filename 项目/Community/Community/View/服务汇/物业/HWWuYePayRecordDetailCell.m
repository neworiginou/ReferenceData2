//
//  HWWuYePayRecordDetailCell.m
//  Community
//
//  Created by niedi on 15/6/26.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYePayRecordDetailCell.h"

@interface HWWuYePayRecordDetailCell ()
{
    DLable *_rightLab;
    DLable *_leftLab;
    DImageV *_buttomLine;
}
@end

@implementation HWWuYePayRecordDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _leftLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:0 w:200 h:45];
        [self.contentView addSubview:_leftLab];
        
        _rightLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:90 y:0 w:kScreenWidth - 90 - 15 h:45];
        [self.contentView addSubview:_rightLab];
        
        _buttomLine = [DImageV imagV:@"" frameX:0 y:44.5f w:kScreenWidth  h:0.5f];
        _buttomLine.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:_buttomLine];
    }
    return self;
}

- (void)fillDataWithLeftStr:(NSString *)leftStr rightStr:(NSString *)rightStr
{
    _leftLab.text = leftStr;
    _rightLab.text = rightStr;
}


+ (CGFloat)getCellHeight
{
    return 45.0f;
}

@end
