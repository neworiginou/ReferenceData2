//
//  HWProNewsSoundCell.m
//  Community
//
//  Created by lizhongqiang on 14-9-3.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWProNewsSoundCell.h"
#import "HWAudioManager.h"
#import "HWAudioButton.h"
#import "AppDelegate.h"

#define CONSTRAINED_WIDTH   (kScreenWidth - 42 - 15)
#define MARGIN_LEFT         42

@implementation HWProNewsSoundCell
{
    UIView *soundView;              //播放声音
    UILabel *labName;               //用户名
    UILabel *labSound;              //
    UIImageView *line;                   //
    UILabel *labelTime;             //
    HWAudioButton *audioButton;
    UIImageView *lineTop;
    UILabel *replyLab;
}

@synthesize indexPath;
@synthesize news;

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
        
        line = [[UIImageView alloc] initWithFrame:CGRectMake(25, 17, 1, 80 - 17)];
        line.image = [Utility imageWithColor:THEME_COLOR_LINE andSize:line.frame.size];
//        [line setBackgroundColor:THEME_COLOR_LINE];
        [self.contentView addSubview:line];
        
        labelTime = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, 3, 200, 15)];
        [labelTime setBackgroundColor:[UIColor clearColor]];
        [labelTime setTextColor:THEME_COLOR_TEXT];
        [labelTime setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
//        [labelTime setText:@"2014-09-10 10:40"];    //根据时间戳
        [self.contentView addSubview:labelTime];
        
        replyLab = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, CGRectGetMaxY(labelTime.frame) + 2, CONSTRAINED_WIDTH, 0)];
        replyLab.textColor = THEME_COLOR_TEXT;
        replyLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        replyLab.backgroundColor = [UIColor clearColor];
        replyLab.numberOfLines = 0;
        replyLab.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:replyLab];
        
        
        audioButton = [HWAudioButton buttonWithType:UIButtonTypeCustom];
        [audioButton setBackgroundImage:[UIImage imageNamed:@"property_voice"] forState:UIControlStateNormal];
        audioButton.frame = CGRectMake(MARGIN_LEFT, 0, 94, 25);
        audioButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:12.0f];
        [audioButton setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
        [audioButton addTarget:self action:@selector(toPlay) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:audioButton];
        
        
    }
    return self;
}


- (void)setNews:(HWPropertyNewsClass *)aNews
{
    
    news = aNews;
    
    labelTime.text = [Utility getMinTimeWithTimestamp:aNews.createTime];
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
    
    int totalTime = news.soundTime.intValue;
//    int totalTime = [[NSString stringWithFormat:@"%@",news.soundTime] intValue];
    if (totalTime > 60)
    {
        [audioButton setTitle:[NSString stringWithFormat:@"%d'%d\"", totalTime / 60, totalTime % 60] forState:UIControlStateNormal];
    }
    else
    {
        [audioButton setTitle:[NSString stringWithFormat:@"%d\"", totalTime] forState:UIControlStateNormal];
    }
    [audioButton setPlayMode:news.audioPlayMode];
    audioButton.frame = CGRectMake(MARGIN_LEFT,
                                   (replySize.width == 0 ? 5 : (replySize.height + 5)) + 20,
                                   94,
                                   25);
    float height = (replySize.width == 0 ? 5 : (replySize.height + 5)) + 20 + 10 + 25;
    [line setFrame:CGRectMake(25, 17, 1, height - 17)];
}

- (void)toPlay
{
    if (news.url.length == 0)
    {
        AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
        [Utility showToastWithMessage:@"无语音数据" inView:appDel.window];
        return;
    }
    
    HWAudioManager *customerAudio = [HWAudioManager shareAudioManager];
    [customerAudio playAudioUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@/hw-sq-app-web/%@&key=%@",kUrlBase ,news.url, [HWUserLogin currentUserLogin].key]] forIndexPath:self.indexPath];
    
}

+ (CGFloat)getCellHeightWithForCellDic:(HWPropertyNewsClass *)news
{
    CGSize replySize;
    if (IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]};
        replySize = [news.replyContent boundingRectWithSize:CGSizeMake(CONSTRAINED_WIDTH, CGFLOAT_MAX) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    else
    {
        replySize = [news.replyContent sizeWithFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG] constrainedToSize:CGSizeMake(CONSTRAINED_WIDTH, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    float height = (replySize.width == 0 ? 5 : (replySize.height + 5)) + 20 + 10 + 25;
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
