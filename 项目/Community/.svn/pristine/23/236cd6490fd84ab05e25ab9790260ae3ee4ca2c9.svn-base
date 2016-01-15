//
//  HWInviteCustomCell.m
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWInviteCustomCell.h"

@interface HWInviteCustomCell ()
{
    BOOL _isFold;
    DLable *_rightLab;
    DImageV *_buttomLine;
    DImageV *downImg;
    UIDatePicker *datePicker;
}
@end

@implementation HWInviteCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _isFold = YES;
        self.layer.masksToBounds = YES;
        
        DLable *leftLab = [DLable LabTxt:@"到访日期" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:15 w:200 h:15];
        [self.contentView addSubview:leftLab];
        
        _rightLab = [DLable LabTxt:@"选择到访日期" txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:kScreenWidth - 36 - 200 y:15 w:200 h:15];
        _rightLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_rightLab];
        
        downImg = [DImageV imagV:@"arrow3" frameX:kScreenWidth - 16 - 15 y:(45.0f - 9.0f) / 2.0f w:16 h:9];
        [self.contentView addSubview:downImg];
        
        DImageV *line = [DImageV imagV:@"" frameX:0 y:44.5f w:kScreenWidth h:0.5f];
        line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:line];
        
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 45.0f, kScreenWidth, 210.0f)];
        datePicker.backgroundColor = BACKGROUND_COLOR;
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.minimumDate = [NSDate date];
        [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:datePicker];
        
        _buttomLine = [DImageV imagV:@"" frameX:0 y:210.0f + 44.5f w:kScreenWidth h:0.5f];
        _buttomLine.backgroundColor = THEME_COLOR_LINE;
        _buttomLine.hidden = YES;
        [self.contentView addSubview:_buttomLine];
    }
    return self;
}

- (void)dateChanged:(UIDatePicker *)datePickerr
{
    _rightLab.text = [self getDateStr:datePickerr.date];
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerDateChanged:)])
    {
        [self.delegate datePickerDateChanged:datePickerr.date];
    }
}

- (void)setFold:(BOOL)isFold
{
    _isFold = isFold;
    _buttomLine.hidden = isFold;
    
    if ([_rightLab.text isEqualToString:@"选择到访日期"])
    {
        _rightLab.text = [self getDateStr:[datePicker date]];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerDateChanged:)])
    {
        [self.delegate datePickerDateChanged:[datePicker date]];
    }
    
    if (isFold)
    {
        downImg.image = [UIImage imageNamed:@"arrow3"];
    }
    else
    {
        downImg.image = [UIImage imageNamed:@"arrow4"];
    }
}

+ (CGFloat)getCellHeight:(BOOL)isFold
{
    if (isFold)
    {
        return 45.0f;
    }
    else
    {
        return 210.0f + 45.0f;
    }
}

- (NSString *)getDateStr:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

@end
