//
//  HWProNewsTextCell.m
//  Community
//
//  Created by lizhongqiang on 14-9-3.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWProNewsTextCell.h"

#define CONSTRAINED_WIDTH   (kScreenWidth - 42 - 15)
#define MARGIN_LEFT         42

@implementation HWProNewsTextCell
{
    UILabel *label;
    UIImageView *line;                  //竖线
    UILabel *labelTime;                 //
    UIImageView *lineTop;               //
    UILabel *replyLab;                  //回复
}
//@synthesize strText;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        lineTop = [[UIImageView alloc] initWithFrame:CGRectMake(25, 0, 1, 5)];
        lineTop.image = [Utility imageWithColor:THEME_COLOR_LINE andSize:lineTop.frame.size];
        [self.contentView addSubview:lineTop];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 12, 12)];
        [img setImage:[UIImage imageNamed:@"shop_time"]];
        [self.contentView addSubview:img];
        
        
        line = [[UIImageView alloc] initWithFrame:CGRectMake(25, 17, 1, 100)];
        line.image = [Utility imageWithColor:THEME_COLOR_LINE andSize:line.frame.size];
        [self.contentView addSubview:line];
        
        labelTime = [[UILabel alloc] initWithFrame:CGRectMake(42, 3, 200, 15)];
        [labelTime setBackgroundColor:[UIColor clearColor]];
        [labelTime setTextColor:THEME_COLOR_TEXT];
        [labelTime setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
//        [labelTime setText:@"2014-09-10 10:40"];
        [self.contentView addSubview:labelTime];
        
        replyLab = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, CGRectGetMaxY(labelTime.frame) + 2, CONSTRAINED_WIDTH, 0)];
        replyLab.textColor = THEME_COLOR_TEXT;
        replyLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        replyLab.backgroundColor = [UIColor clearColor];
        replyLab.numberOfLines = 0;
        replyLab.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:replyLab];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(42, 0, kScreenWidth - 42 - 15, 21)];
        [label setBackgroundColor:[UIColor clearColor]];
        label.numberOfLines = 0;
        [label setTextColor:THEME_COLOR_TEXT];
        [label setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
        [self.contentView addSubview:label];
    }
    return self;
}



- (void)setNews:(HWPropertyNewsClass *)news
{
//    labelTime.text = news.cre;//时间戳
    
    labelTime.text = [Utility getMinTimeWithTimestamp:news.createTime];
//    labelTime.text = news.timeDistance;
    replyLab.text = news.replyContent;
    CGSize replySize;
    if (IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName: replyLab.font};
        replySize = [news.replyContent boundingRectWithSize:CGSizeMake(CONSTRAINED_WIDTH, CGFLOAT_MAX) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    else
    {
        replySize = [news.replyContent sizeWithFont:replyLab.font constrainedToSize:CGSizeMake(CONSTRAINED_WIDTH, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    }
    if (replySize.width == 0)
    {
        CGRect frame = replyLab.frame;
        frame.size.width = CONSTRAINED_WIDTH;
        frame.size.height = 0;
        replyLab.frame = frame;
    }
    else
    {
        CGRect frame = replyLab.frame;
        frame.size.width = CONSTRAINED_WIDTH;
        frame.size.height = replySize.height;
        replyLab.frame = frame;
    }
    
    label.text = news.content;
    
    CGSize size;
    if (IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName: label.font};
        size = [news.content boundingRectWithSize:CGSizeMake(CONSTRAINED_WIDTH, CGFLOAT_MAX) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    else
    {
        size = [news.content sizeWithFont:label.font constrainedToSize:CGSizeMake(CONSTRAINED_WIDTH, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    label.frame = CGRectMake(MARGIN_LEFT,
                             (replySize.width == 0 ? 25 : (CGRectGetMaxY(replyLab.frame) + 5)),
                             size.width,
                             size.height);
    
    float height = fmax(40.0f, (size.width == 0 ? 0 : size.height + 10) + 20 + (replySize.width == 0 ? 0 : (replySize.height + 5)));
    
    [line setFrame:CGRectMake(25, 17, 1, height - 17)];
}

+ (CGFloat)getCellHeightWithForCellDic:(HWPropertyNewsClass *)news
{
//    news.replyContent = @"萨科技辅导老师激发了深刻法拉盛附近拉斯法拉盛里发生了房间爱丽丝房间爱上法拉盛假发；是敬爱放家里收到积分拉斯";
    CGSize replySize;
    if (IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]};
        replySize = [news.replyContent boundingRectWithSize:CGSizeMake(CONSTRAINED_WIDTH, CGFLOAT_MAX) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    else
    {
        replySize = [news.replyContent sizeWithFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG] constrainedToSize:CGSizeMake(CONSTRAINED_WIDTH, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    
    
    CGSize size;
    if (IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]};
        size = [news.content boundingRectWithSize:CGSizeMake(CONSTRAINED_WIDTH, CGFLOAT_MAX) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    else
    {
        size = [news.content sizeWithFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL] constrainedToSize:CGSizeMake(CONSTRAINED_WIDTH, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    }
    
//    NSLog(@"%@ %f",news.content, size.height);
    
    float height = fmax(40.0f, (size.width == 0 ? 0 : size.height + 10) + 20 + (replySize.width == 0 ? 0 : (replySize.height + 5)));
    
    return height;

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
