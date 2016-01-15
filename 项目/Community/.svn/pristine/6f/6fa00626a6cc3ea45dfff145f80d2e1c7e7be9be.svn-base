//
//  HWProNewsImgCell.m
//  Community
//
//  Created by lizhongqiang on 14-9-3.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWProNewsImgCell.h"

#define CONSTRAINED_WIDTH   (kScreenWidth - 42 - 15)
#define MARGIN_LEFT         42

@implementation HWProNewsImgCell
{
    UIImageView *imgPhoto;                  //图片
    UILabel *labText;                       //文字
    UIImageView *line;                      //
    UILabel *labelTime;                     //
    UIImageView *lineTop;                   //
    UILabel *replyLab;
    UIView *backView;
}
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
        replyLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        replyLab.backgroundColor = [UIColor clearColor];
        replyLab.numberOfLines = 0;
        replyLab.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:replyLab];
        
        backView = [[UIView alloc] initWithFrame:CGRectMake(MARGIN_LEFT, 0, kScreenWidth - MARGIN_LEFT - 15, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        
        imgPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(backView.frame) + 3, CGRectGetMinY(backView.frame) + 3, 66, 50 - 6.0f)];
        [imgPhoto setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:imgPhoto];
        
        labText = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgPhoto.frame) + 10, CGRectGetMinY(backView.frame) + 3, kScreenWidth - CGRectGetMaxX(imgPhoto.frame) + 10 - 15 - 10, imgPhoto.frame.size.height)];
        [labText setBackgroundColor:[UIColor clearColor]];
        labText.numberOfLines = 0;
        labText.lineBreakMode = NSLineBreakByWordWrapping;
        [labText setTextColor:THEME_COLOR_TEXT];
        [labText setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
        [self.contentView addSubview:labText];
    }
    return self;
}

-(void)setNews:(HWPropertyNewsClass *)news
{
    [labelTime setText:[Utility getMinTimeWithTimestamp:news.createTime]];
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
    
    if (replySize.width == 0) {
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
    
    
    CGRect bFrame = backView.frame;
    bFrame.origin.y = CGRectGetMaxY(replyLab.frame) + 5;
    backView.frame = bFrame;
    
    imgPhoto.frame = CGRectMake(CGRectGetMinX(backView.frame) + 3, CGRectGetMinY(backView.frame) + 3, 66, 50 - 6.0f);
    
    __weak UIImageView *blockImgV = imgPhoto;
    [imgPhoto setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:news.url]] placeholderImage:[UIImage imageNamed:@"redDefault"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (error)
        {
            NSLog(@"Error : load image fail.");
            blockImgV.image = [UIImage imageNamed:@"redDefault"];
        }
        else
        {
            blockImgV.image = image;
            if (cacheType == 0)
            { // request url
                CATransition *transition = [CATransition animation];
                transition.duration = 1.0f;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionFade;
                [blockImgV.layer addAnimation:transition forKey:nil];
            }
        }
    }];
    
    labText.frame = CGRectMake(CGRectGetMaxX(imgPhoto.frame) + 10, CGRectGetMinY(backView.frame) + 3, kScreenWidth - CGRectGetMaxX(imgPhoto.frame) - 10 - 15 - 10, imgPhoto.frame.size.height);
    labText.text = news.content;
    
    float height = (replySize.width == 0 ? 0 : replySize.height + 5) + 50 + 10 + 20;
    
    [line setFrame:CGRectMake(25, 17, 1, height - 17)];
}

+ (CGFloat)getCellHeightWithForCellDic:(HWPropertyNewsClass *)news
{
    UIFont *font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    CGSize replySize;
    if (IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName : font};
        replySize = [news.replyContent boundingRectWithSize:CGSizeMake(CONSTRAINED_WIDTH, CGFLOAT_MAX) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    else
    {
        replySize = [news.replyContent sizeWithFont:font constrainedToSize:CGSizeMake(CONSTRAINED_WIDTH, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    float height = (replySize.width == 0 ? 0 : replySize.height + 5) + 50 + 10 + 20;
    
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
