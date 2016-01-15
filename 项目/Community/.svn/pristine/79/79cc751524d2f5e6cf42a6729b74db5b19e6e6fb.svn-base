//
//  HWInviteCustomRecordListCell.m
//  Community
//
//  Created by niedi on 15/6/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWInviteCustomRecordListCell.h"

@interface HWInviteCustomRecordListCell ()
{
    DLable *_rightLab;
    DLable *_leftLab;
    DImageV *_buttomLine;
}
@end

@implementation HWInviteCustomRecordListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _leftLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:15 w:kScreenWidth - 2 * 15 h:15];
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

- (void)fillDataWithDateStr:(NSString *)dateStr timesStr:(NSString *)times
{
    _leftLab.text = dateStr;
    _rightLab.text = times;
}


+ (CGFloat)getCellHeight
{
    return 45.0f;
}

@end
