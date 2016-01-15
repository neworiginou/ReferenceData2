//
//  HWInviteCustomRecordCell.m
//  Community
//
//  Created by niedi on 15/6/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWInviteCustomRecordCell.h"

@interface HWInviteCustomRecordCell ()
{
    DLable *_nameLab;
    DLable *_identityLab;
    DLable *_detailLab;
    DLable *_dateLab;
}
@end

@implementation HWInviteCustomRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _nameLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:15 w:kScreenWidth - 2 * 15 h:16.0f];
        [self.contentView addSubview:_nameLab];
        
        _identityLab = [DLable LabTxt:@"" txtFont:TF12 txtColor:THEME_COLOR_ORANGE frameX:65 y:16 w:35 h:15.0f];
        _identityLab.backgroundColor = THEME_COLOR_ORANGE_light;
        _identityLab.textAlignment = NSTextAlignmentCenter;
        [_identityLab setRadius:7.5f];
        _identityLab.layer.borderWidth = 0.5f;
        _identityLab.layer.borderColor = THEME_COLOR_ORANGE.CGColor;
        [self.contentView addSubview:_identityLab];
        
        _detailLab = [DLable LabTxt:@"" txtFont:TF14 txtColor:THEME_COLOR_TEXT frameX:15 y:CGRectGetMaxY(_nameLab.frame) + 10 w:kScreenWidth - 2 * 10 h:14];
        [self.contentView addSubview:_detailLab];
        
        _dateLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:kScreenWidth - 110 - 15 y:(70 - 15) / 2.0f w:110 h:15];
        _dateLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_dateLab];
        
        DImageV *buttomLine = [DImageV imagV:@"" frameX:0 y:69.5f w:kScreenWidth h:0.5f];
        buttomLine.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:buttomLine];
    }
    return self;
}

- (NSString *)getDateStr:(NSString *)visitorDate
{
    NSString *dateStr;
    if (visitorDate.length == 19)
    {
        dateStr = [visitorDate substringToIndex:10];
    }
    else
    {
        dateStr = visitorDate;
    }
    return dateStr;
}

- (void)fillDataWithModel:(HWInviteCustomRecordModel *)model
{
    [self fillDataWithModel:model type:NO];
}

- (void)fillDataWithModel:(HWInviteCustomRecordModel *)model type:(BOOL)isLongCustom
{
    _nameLab.text = model.visitorName;
    
    if (model.relationship.length != 0)
    {
        CGFloat width = [Utility calculateStringWidth:model.visitorName font:[UIFont fontWithName:FONTNAME size:TF15] constrainedSize:CGSizeMake(10000, 18.0f)].width;
        CGRect frame = _identityLab.frame;
        frame.origin.x = 15 + width + 5;
        _identityLab.frame = frame;
        
        _identityLab.text = model.relationship;
        _identityLab.hidden = NO;
    }
    else
    {
        _identityLab.hidden = YES;
    }
    
    if ([model.isVisit isEqualToString:@"0"])
    {
        _detailLab.text = [NSString stringWithFormat:@"预约来访：%@", [self getDateStr:model.visitorDate]];
    }
    else
    {
        if (isLongCustom)
        {
            _detailLab.text = [NSString stringWithFormat:@"最近来访：%@", [self getDateStr:model.visitorDate]];
        }
        else
        {
            _detailLab.text = [NSString stringWithFormat:@"已经来访：%@", [self getDateStr:model.visitorDate]];
        }
    }
    
    if ([model.isPast isEqualToString:@"1"])
    {
        if ([model.dateCount isEqualToString:@"1"])
        {
            _dateLab.text = @"当天有效";
            _dateLab.textColor = THEME_COLOR_TEXT;
        }
        else if ([model.dateCount isEqualToString:@"2"])
        {
            _dateLab.text = @"两天有效";
            _dateLab.textColor = THEME_COLOR_TEXT;
        }
        else if ([model.dateCount isEqualToString:@"3"])
        {
            _dateLab.text = @"三天有效";
            _dateLab.textColor = THEME_COLOR_TEXT;
        }
        else if ([model.dateCount isEqualToString:@"7"])
        {
            _dateLab.text = @"一周有效";
            _dateLab.textColor = THEME_COLOR_TEXT;
        }
    }
    else
    {
        if ([model.dateCount isEqualToString:@"1"])
        {
            _dateLab.text = @"当天有效";
            _dateLab.textColor = UIColorFromRGB(0xdf5c5d);
        }
        else if ([model.dateCount isEqualToString:@"2"])
        {
            _dateLab.text = @"两天有效";
            _dateLab.textColor = UIColorFromRGB(0xef9c46);
        }
        else if ([model.dateCount isEqualToString:@"3"])
        {
            _dateLab.text = @"三天有效";
            _dateLab.textColor = UIColorFromRGB(0x64b1d4);
        }
        else if ([model.dateCount isEqualToString:@"7"])
        {
            _dateLab.text = @"一周有效";
            _dateLab.textColor = UIColorFromRGB(0x1db1ae);
        }
    }
}

+ (CGFloat)getCellHeight:(HWInviteCustomRecordModel *)model
{
    return 70.0f;
}



@end
