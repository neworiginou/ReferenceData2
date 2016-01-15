//
//  HWPriceRecordCell.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWPriceRecordCell.h"

#define CELL_HEIGHT     45.0f

@implementation HWPriceRecordCell

@synthesize timeLab;
@synthesize detailLab;
@synthesize priceLab;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        priceLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70.0f, CELL_HEIGHT)];
        priceLab.backgroundColor = [UIColor clearColor];
        priceLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        priceLab.textColor = THEME_COLOR_TEXT;
        priceLab.adjustsFontSizeToFitWidth = YES;
//        priceLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:priceLab];
        
        detailLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(priceLab.frame) + 5, 0, kScreenWidth - 85 - CGRectGetMaxX(priceLab.frame) - 5, CELL_HEIGHT)];
        detailLab.backgroundColor = [UIColor clearColor];
        detailLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        detailLab.textColor = THEME_COLOR_SMOKE;
        [self.contentView addSubview:detailLab];
        
        timeLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 80, 0, 75, CELL_HEIGHT)];
        timeLab.backgroundColor = [UIColor clearColor];
        timeLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        timeLab.textColor = THEME_COLOR_TEXT;
        timeLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:timeLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CELL_HEIGHT - 0.5f, kScreenWidth, 0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)setPriceRecord:(HWRecordModel *)info
{
    
//    priceLab.text = @"￥121.08";
//    detailLab.text = @"有5个更低唯一价";
//    timeLab.text = @"12-12";

    priceLab.text = [NSString stringWithFormat:@"￥%.2f", info.cutPrice.floatValue];
//    detailLab.text = [NSString stringWithFormat:@"有%@个更低唯一价", info.uniqueLowerTimes];
//    detailLab.text = @"";
//    detailLab.text = [NSString stringWithFormat:@"有%@个相同出价",info.samePriceTimes];
    timeLab.text = [Utility getHourTimeWithTimestamp:info.createTime];
    
    if (info.samePriceTimes.intValue <= 1)
    {
        if (info.uniqueLowerTimes.intValue == 0)
        {
            detailLab.text = @"最低唯一价";
        }
        else
        {
            detailLab.text = [NSString stringWithFormat:@"有%@个更低唯一价", info.uniqueLowerTimes];
        }
        
    }
    else
    {
        detailLab.text = [NSString stringWithFormat:@"有%@个相同出价",info.samePriceTimes];
    }
    
    
}

- (void)setSamePriceRecord:(HWRecordModel *)info
{
    detailLab.text = [NSString stringWithFormat:@"有%@个相同出价",info.samePriceTimes];
}

+ (float)getCellHeight:(NSDictionary *)info
{
    return CELL_HEIGHT;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
