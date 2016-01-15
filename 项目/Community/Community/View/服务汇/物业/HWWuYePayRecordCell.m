//
//  HWWuYePayRecordCell.m
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYePayRecordCell.h"

@interface HWWuYePayRecordCell ()
{
    DLable *titleLab;
    DLable *moneyLab;
    DLable *fromDateLab;
    DLable *toDateLab;
}
@end

@implementation HWWuYePayRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        DImageV *headerImg = [DImageV imagV:@"wuyefeiSmallIcon" frameX:15 y:8 w:21.5f h:18.5f];
        [self.contentView addSubview:headerImg];
        
        titleLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:45.0f y:0 w:kScreenWidth - 45.0f - 30.0f h:35.0f];
        [self.contentView addSubview:titleLab];
        
        moneyLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_MONEY frameX:0 y:0 w:kScreenWidth - 30.0f h:33.0f];
        moneyLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:moneyLab];
        
        DImageV *rightImg = [DImageV imagV:@"arrow" frameX:kScreenWidth - 9 - 15 y:(35.0f - 16.0f) / 2.0f w:9 h:16];
        [self.contentView addSubview:rightImg];
        
        DImageV *middLine = [DImageV imagV:@"" frameX:45.0f y:35.0f w:kScreenWidth - 45.0f - 15 h:0.5f];
        middLine.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:middLine];
        
        fromDateLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:45.0f y:CGRectGetMaxY(middLine.frame) + 8 w:kScreenWidth - 45.0f - 15.0f h:15.0f];
        [self.contentView addSubview:fromDateLab];
        
        toDateLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:45.0f y:CGRectGetMaxY(fromDateLab.frame) + 8 w:kScreenWidth - 45.0f - 15.0f h:15.0f];
        [self.contentView addSubview:toDateLab];
        
        DImageV *buttomLine = [DImageV imagV:@"" frameX:0 y:89.5f w:kScreenWidth h:0.5f];
        buttomLine.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:buttomLine];
    }
    return self;
}

- (void)fillDataWithModel:(HWWuYePayRecordModel *)model
{
    NSString *titleStr;
    if (model.unit_no.length != 0)
    {
        titleStr = [NSString stringWithFormat:@"物业费 %@-%@-%@", model.building_no, model.unit_no, model.room_no];
    }
    else
    {
        titleStr = [NSString stringWithFormat:@"物业费 %@-%@", model.building_no, model.room_no];
    }
    
    titleLab.text = titleStr;
    moneyLab.text = [NSString stringWithFormat:@"%.2f元", model.charge.floatValue];
    fromDateLab.text = [NSString stringWithFormat:@"缴费至%@", [Utility getTimeWithTimestamp:model.eTime]];
    toDateLab.text = [NSString stringWithFormat:@"缴费时间%@", [Utility getTimeWithTimestamp:model.payCreateTime]];
}


+ (CGFloat)getCellHeight:(HWWuYePayRecordModel *)model
{
    return 90.0f;
}


@end
