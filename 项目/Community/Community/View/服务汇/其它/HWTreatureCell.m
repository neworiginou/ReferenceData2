//
//  HWTreatureCell.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWTreatureCell.h"

@implementation HWTreatureCell

@synthesize dateLabel;
@synthesize contentLabel;
@synthesize priceLabel;
@synthesize verticalLine;
@synthesize championImgV;
@synthesize championLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(19.5, 0, 12, 12)];
        circleView.layer.borderColor = THEME_COLOR_LINE.CGColor;
        circleView.layer.borderWidth = 1.0f;
        circleView.backgroundColor = [UIColor whiteColor];
        circleView.layer.cornerRadius = 6.0f;
        [self.contentView addSubview:circleView];
        
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 130, 12)];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.font = [UIFont fontWithName:FONTNAME size:12.0f];
        dateLabel.textColor = THEME_COLOR_TEXT;
        [self.contentView addSubview:dateLabel];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(dateLabel.frame), CGRectGetMaxY(dateLabel.frame) + 5, 170, 0)];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.textColor = THEME_COLOR_TEXT;
        contentLabel.font = [UIFont fontWithName:FONTNAME size:13.0f];
        contentLabel.numberOfLines = 0;
        contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:contentLabel];
        
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 105, 0, 90, 30)];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.textColor = THEME_COLOR_MONEY;
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.adjustsFontSizeToFitWidth = YES;
        priceLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        [self.contentView addSubview:priceLabel];
        
        championImgV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(dateLabel.frame), CGRectGetMaxY(dateLabel.frame) + 5, 16, 12)];
        championImgV.image = [UIImage imageNamed:@"crown"];
        [self.contentView addSubview:championImgV];
        
        championLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(championImgV.frame) + 3, CGRectGetMinY(championImgV.frame), 120, 13)];
        championLabel.backgroundColor = [UIColor clearColor];
        championLabel.font = [UIFont fontWithName:FONTNAME size:13.0f];
        championLabel.textColor = THEME_COLOR_MONEY;
        championLabel.text = @"唯一最低价";
        
        [self.contentView addSubview:championLabel];
        
        verticalLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(circleView.frame) - 0.5f, CGRectGetMaxY(circleView.frame), 1, 0)];
        verticalLine.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:verticalLine];
    }
    return self;
}

- (void)setTreatureInfo:(HWRecordModel *)info
{
    NSString *priceStr = info.cutPrice;
    dateLabel.text = [Utility getDetailTimeWithTimestamp:info.createTime];
    
    if (info.samePriceTimes.intValue <= 1)
    {
        if (info.uniqueLowerTimes.intValue <= 0)
        {
            // 最低唯一价
            championLabel.hidden = NO;
            championImgV.hidden = NO;
            contentLabel.hidden = YES;
            priceLabel.text = [NSString stringWithFormat:@"￥%@",priceStr];
        }
        else
        {
            // 更低唯一
            championLabel.hidden = YES;
            championImgV.hidden = YES;
            contentLabel.hidden = NO;
            
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"有%@个更低唯一价",info.uniqueLowerTimes]];
            [string addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_MONEY range:NSMakeRange(1, info.uniqueLowerTimes.length)];
            contentLabel.attributedText = string;
            priceLabel.text = [NSString stringWithFormat:@"￥%@",priceStr];
            
            CGRect ctntFrame = contentLabel.frame;
            ctntFrame.size.height = [Utility calculateStringHeight:contentLabel.text font:contentLabel.font constrainedSize:CGSizeMake(contentLabel.frame.size.width, 1000)].height;
            contentLabel.frame= ctntFrame;
        }
        
    }
    else
    {
        // 显示相同价
        
        championLabel.hidden = YES;
        championImgV.hidden = YES;
        contentLabel.hidden = NO;
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"有%@个相同价",info.samePriceTimes]];
        [string addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_MONEY range:NSMakeRange(1, info.samePriceTimes.length)];
        contentLabel.attributedText = string;
        priceLabel.text = [NSString stringWithFormat:@"￥%@",priceStr];
        
        CGRect ctntFrame = contentLabel.frame;
        ctntFrame.size.height = [Utility calculateStringHeight:contentLabel.text font:contentLabel.font constrainedSize:CGSizeMake(contentLabel.frame.size.width, 1000)].height;
        contentLabel.frame= ctntFrame;
    }
    
    CGRect frame = verticalLine.frame;
    frame.size.height = [HWTreatureCell getCellHeight:info] - 12;
    verticalLine.frame = frame;
}

+ (float)getCellHeight:(HWRecordModel *)info
{
    float height = 15 + 15;
    NSString *peopleCount = info.uniqueLowerTimes;
    
    if (info.isLowest.intValue == 1)
    {
        NSString *string = [NSString stringWithFormat:@"唯一最低价"];
        UIFont *font = [UIFont fontWithName:FONTNAME size:13.0f];
        return height + [Utility calculateStringHeight:string font:font constrainedSize:CGSizeMake(170, 1000)].height;
    }
    else
    {
        NSString *string = [NSString stringWithFormat:@"有%@个更低唯一价",peopleCount];
        UIFont *font = [UIFont fontWithName:FONTNAME size:13.0f];
        return height + [Utility calculateStringHeight:string font:font constrainedSize:CGSizeMake(170, 1000)].height;
    }
    
    return height;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
