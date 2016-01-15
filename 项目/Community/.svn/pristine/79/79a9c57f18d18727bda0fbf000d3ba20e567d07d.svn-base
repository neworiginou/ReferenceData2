//
//  HWShopNewsTableViewCell.m
//  Community
//
//  Created by lizhongqiang on 14-9-2.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWShopNewsTableViewCell.h"

@implementation HWShopNewsTableViewCell
{
    UIView *lineTop;
}
@synthesize labelTime;
@synthesize leftLabel;
@synthesize rightLabel;
@synthesize timeline;
//@synthesize imgTimeline;
@synthesize storeNews;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        UIFont *font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        
        lineTop = [[UIView alloc] initWithFrame:CGRectMake(25, 0, 1, 5)];
        [lineTop setBackgroundColor:THEME_COLOR_LINE];
        [self.contentView addSubview:lineTop];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 12, 12)];
        [img setImage:[UIImage imageNamed:@"shop_time"]];
        [self.contentView addSubview:img];
        
        
        timeline = [[UIView alloc] initWithFrame:CGRectMake(25, 17, 1, 50)];
        [timeline setBackgroundColor:THEME_COLOR_LINE];
        [self.contentView addSubview:timeline];
        
        labelTime = [[UILabel alloc] initWithFrame:CGRectMake(41, 0, 250, 15)];
        [labelTime setBackgroundColor:[UIColor clearColor]];
        [labelTime setTextColor:THEME_COLOR_TEXT];
        [labelTime setFont:font];
        [self.contentView addSubview:labelTime];
        
        leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(41, 20, 100, 21)];
        [leftLabel setBackgroundColor:[UIColor clearColor]];
        [leftLabel setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
        [leftLabel setTextColor:THEME_COLOR_SMOKE];
        [self.contentView addSubview:leftLabel];
        
        rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(41, 20, 250, 21)];
        [rightLabel setBackgroundColor:[UIColor clearColor]];
        [rightLabel setFont:font];
        [rightLabel setTextColor:THEME_COLOR_TEXT];
        rightLabel.numberOfLines = 0;
        [self.contentView addSubview:rightLabel];
    }
    return self;
}

-(void)setStoreNews:(HWStoreNewsClass *)aStoreNews
{
    storeNews = aStoreNews;
    
    UIFont *font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    
    rightLabel.text = storeNews.content;
    CGSize sizeRight = [storeNews.content sizeWithFont:font constrainedToSize:CGSizeMake(250, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    rightLabel.frame = CGRectMake(41, 20, 250, sizeRight.height);
    float height = fmaxf(60.0f, sizeRight.height + 20);
    timeline.frame = CGRectMake(25, 17, 1, height - 17);
    labelTime.text = storeNews.createDate;
//    [labelTime setText:[Utility getTimeWithTimestamp:storeNews.createDate]];
}

+(CGFloat)getCellHeight:(HWStoreNewsClass *)storeNews
{
//    return 50.0f;
    UIFont *font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    CGSize sizeRight = [storeNews.content sizeWithFont:font constrainedToSize:CGSizeMake(250, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    
    return fmaxf(60.0f, sizeRight.height + 20);
}



- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
