//
//  HWCommitHomeServiceCell1.m
//  Community
//
//  Created by niedi on 15/6/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWCommitHomeServiceCell1.h"

@interface HWCommitHomeServiceCell1 ()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    BOOL _isFold;
    DLable *_rightLab;
    DImageV *_buttomLine;
    DImageV *downImg;
    
    NSArray *_titleArr;
}
@end

@implementation HWCommitHomeServiceCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _isFold = YES;
        _titleArr = @[@"上午", @"下午", @"晚上", @"全天"];
        self.layer.masksToBounds = YES;
        
        DLable *leftLab = [DLable LabTxt:@"时间段" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:15 w:200 h:15];
        [self.contentView addSubview:leftLab];
        
        _rightLab = [DLable LabTxt:@"上午" txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:90 y:15 w:kScreenWidth - 90 - 36 h:15];
        [self.contentView addSubview:_rightLab];
        
        downImg = [DImageV imagV:@"arrow3" frameX:kScreenWidth - 16 - 15 y:(45.0f - 9.0f) / 2.0f w:16 h:9];
        [self.contentView addSubview:downImg];
        
        DImageV *line = [DImageV imagV:@"" frameX:0 y:44.5f w:kScreenWidth h:0.5f];
        line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:line];
        
        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 45.0f, kScreenWidth, 150.0f)];
        picker.backgroundColor = BACKGROUND_COLOR;
        picker.delegate = self;
        [picker selectRow:0 inComponent:0 animated:NO];
        [self.contentView addSubview:picker];
        
        _buttomLine = [DImageV imagV:@"" frameX:0 y:150.0f + 44.5f w:kScreenWidth h:0.5f];
        _buttomLine.backgroundColor = THEME_COLOR_LINE;
        _buttomLine.hidden = YES;
        [self.contentView addSubview:_buttomLine];
    }
    return self;
}

- (void)setFold:(BOOL)isFold
{
    _isFold = isFold;
    _buttomLine.hidden = isFold;
    
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
        return 150.0f + 45.0f;
    }
}

- (NSString *)getDateStr:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 4;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_titleArr pObjectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _rightLab.text = [_titleArr pObjectAtIndex:row];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerDateChanged:)])
    {
        [self.delegate pickerDateChanged:row];
    }
}

@end
