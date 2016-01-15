//
//  HWMyWuYeCell.m
//  Community
//
//  Created by niedi on 15/6/4.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWMyWuYeCell.h"

@interface HWMyWuYeCell ()
{
    DLable *_publishTitleLab;
    DLable *_publishTimeLab;
    DLable *_publishContentLab;
    CALayer *_lineButtom;
}
@end

@implementation HWMyWuYeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        DImageV *labaIcon = [DImageV imagV:@"icon_16_02" frameX:15 y:15 w:20 h:20];
        [self.contentView addSubview:labaIcon];
        
        _publishTitleLab = [DLable LabTxt:@"" txtFont:TF16 txtColor:THEME_COLOR_SMOKE frameX:CGRectGetMaxX(labaIcon.frame) + 5 y:15 w:kScreenWidth - 120 - 15 - (CGRectGetMaxX(labaIcon.frame) + 5) h:20];
        [self.contentView addSubview:_publishTitleLab];
        
        _publishTimeLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:kScreenWidth - 15 - 120 y:CGRectGetMinY(_publishTitleLab.frame) + 1 w:120 h:20];
        _publishTimeLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_publishTimeLab];
        
        _publishContentLab = [DLable LabTxt:nil txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:CGRectGetMaxY(labaIcon.frame) + 15 w:kScreenWidth - 2 * 15 h:50];
        [self.contentView addSubview:_publishContentLab];
        
        _lineButtom = [[CALayer alloc] init];
        [_lineButtom setFrame:CGRectMake(0, 65.0f, kScreenWidth, 0.5f)];
        [_lineButtom setBackgroundColor:THEME_COLOR_LINE.CGColor];
        [self.contentView.layer addSublayer:_lineButtom];
    }
    return self;
}


- (void)fillData:(HWMyWuYeModel *)model row:(NSInteger)row
{
    _publishTitleLab.text = @"物业通知";
    _publishTimeLab.text = [Utility getTimeWithTimestamp:model.timeStr];
    
    CGFloat height = [Utility calculateStringHeight:model.contentStr font:[UIFont fontWithName:FONTNAME size:TF15] constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
    CGRect frame = _publishContentLab.frame;
    frame.size.height = height;
    _publishContentLab.frame = frame;
    _publishContentLab.text = model.contentStr;
    
    frame = _lineButtom.frame;
    frame.origin.y = CGRectGetMaxY(_publishContentLab.frame) + 14.5f;
    _lineButtom.frame = frame;
}

+ (CGFloat)getHight:(HWMyWuYeModel *)model
{
    NSString *content = model.contentStr;
    CGFloat height = [Utility calculateStringHeight:content font:[UIFont fontWithName:FONTNAME size:TF15] constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
    return 65.0f + height;
}


@end
