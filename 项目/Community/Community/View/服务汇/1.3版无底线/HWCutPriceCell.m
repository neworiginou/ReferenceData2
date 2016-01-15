//
//  HWCutPriceCell.m
//  Community
//
//  Created by lizhongqiang on 15/4/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWCutPriceCell.h"

@implementation HWCutPriceCell
@synthesize time;
@synthesize price;
@synthesize detail;
@synthesize onlyPriceImg;
@synthesize onlyPriceDot;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.price = [[UILabel alloc] initWithFrame:CGRectMake(48, 10, 150, 30)];
        [self.price setBackgroundColor:[UIColor clearColor]];
        [self.price setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALLTITLE]];
        [self.price setTextColor:THE_COLOR_RED_FE];
        [self.contentView addSubview:self.price];
        
        self.time = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 150, 20)];
        [self.time setBackgroundColor:[UIColor clearColor]];
        [self.time setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SUPERSMALL]];
        [self.time setTextColor:THEME_COLOR_GRAY_MIDDLE];
        [self.contentView addSubview:self.time];
        
        self.detail = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, kScreenWidth - 50 - 15, 24)];
        [self.detail setBackgroundColor:[UIColor clearColor]];
        [self.detail setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL12]];
        [self.detail setTextColor:THEME_COLOR_GRAY_MIDDLE];
        [self.detail setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.detail];
        
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(50, 59.5f, kScreenWidth - 50, 0.5f)];
//        [line setBackgroundColor:THEME_COLOR_LINE];
//        [self.contentView addSubview:line];  37 28
        self.onlyPriceImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 125, 23, 18, 14)];
        [self.onlyPriceImg setBackgroundColor:[UIColor clearColor]];
        [self.onlyPriceImg setImage:[UIImage imageNamed:@"onlyprice"]];
        [self.onlyPriceImg setHidden:YES];
        [self.contentView addSubview:self.onlyPriceImg];
        
        CALayer *line1 = [[CALayer alloc] init];
        line1.frame = CGRectMake(50, 59.5f, kScreenWidth - 50, 0.5f);
        [line1 setBackgroundColor:THEME_COLOR_LINE.CGColor];
        [self.contentView.layer addSublayer:line1];
        
        CALayer *line2 = [[CALayer alloc] init];
        line2.frame = CGRectMake(25, 0, 0.5f, 60);
        [line2 setBackgroundColor:THEME_COLOR_LINE.CGColor];
        [self.contentView.layer addSublayer:line2];
        
        UIImageView *imgDot = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 9)];
        [imgDot setCenter:CGPointMake(25, 30)];
        [imgDot setImage:[UIImage imageNamed:@"grayDot"]];
        [imgDot setHidden:NO];
        [self.contentView addSubview:imgDot];
        
        self.onlyPriceDot = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
        [self.onlyPriceDot setCenter:CGPointMake(25, 30)];
        [self.onlyPriceDot setImage:[UIImage imageNamed:@"orange"]];
        [self.onlyPriceDot setHidden:YES];
        [self.contentView addSubview:self.onlyPriceDot];
    }
    return self;
}

- (void)setCellWithModel:(HWCutPriceModel *)model
{
    self.price.text = [NSString stringWithFormat:@"￥%@",model.cutPrice];
    self.time.text = [Utility getTimeWithTimestamp:model.createTime WithDateFormat:@"YYYY-MM-dd HH:mm"];
    
    if (model.samePriceTimes.intValue <= 1)
    {
        if (model.uniqueLowerTimes.intValue <= 0)
        {
            //最低唯一价
            [self.detail setTextColor:THE_COLOR_RED];
            self.detail.text = @"你是唯一最低价";
            [self.onlyPriceImg setHidden:NO];
            [self.onlyPriceDot setHidden:NO];
        }
        else
        {
            //更低唯一价
            [self.detail setTextColor:THEME_COLOR_GRAY_MIDDLE];
            self.detail.text = [NSString stringWithFormat:@"有%@个更低唯一价",model.uniqueLowerTimes];
            [self.onlyPriceImg setHidden:YES];
            [self.onlyPriceDot setHidden:YES];
        }
    }
    else
    {
        //相同价
        [self.detail setTextColor:THEME_COLOR_GRAY_MIDDLE];
        self.detail.text = [NSString stringWithFormat:@"有%@个相同出价",model.samePriceTimes];
        [self.onlyPriceImg setHidden:YES];
        [self.onlyPriceDot setHidden:YES];
    }
    
}

@end
