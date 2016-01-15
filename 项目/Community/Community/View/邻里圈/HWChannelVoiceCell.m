//
//  HWChannelVoiceCell.m
//  Community
//
//  Created by zhangxun on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWChannelVoiceCell.h"
#import "HWLikeButton.h"

#define kTagViewTag 345
#define kTagLabelTag 456
#define kLeftMargin 15


@implementation HWChannelVoiceCell

@synthesize playButton,backView,hasDownload;
@synthesize currentItem;
@synthesize activityView;
@synthesize indexPath;
@synthesize bottomView;
//@synthesize channelButton;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 155)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    
//    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5f)];
//    lineV.backgroundColor = THEME_COLOR_LINE;
//    [backView addSubview:lineV];
    
    self.headerImgV = [[UIImageView alloc] initWithFrame:CGRectMake(9, 12.5f, 41, 41)];
    self.headerImgV.layer.cornerRadius = 20.5f;
    self.headerImgV.layer.masksToBounds = YES;
    self.headerImgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImgClick)];
    [self.headerImgV addGestureRecognizer:tap];
    [backView addSubview:self.headerImgV];
    
    self.NickNameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headerImgV.frame) + 10, CGRectGetMinY(self.headerImgV.frame) + 4, kScreenWidth - (CGRectGetMaxX(self.headerImgV.frame) + 10) - 15, 20)];
    self.NickNameLab.backgroundColor = [UIColor clearColor];
    self.NickNameLab.font = [UIFont fontWithName:FONTNAME size:16];
    self.NickNameLab.textColor = THEME_COLOR_SMOKE;
    [backView addSubview:self.NickNameLab];
    
    self.publishTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(self.NickNameLab.frame.origin.x, CGRectGetMaxY(self.NickNameLab.frame), self.NickNameLab.frame.size.width, 15)];
    self.publishTimeLab.backgroundColor = [UIColor clearColor];
    self.publishTimeLab.font = [UIFont fontWithName:FONTNAME size:12];
    self.publishTimeLab.textColor = THEME_COLOR_TEXT;
    [backView addSubview:self.publishTimeLab];
    
    self.channelButton = [[HWChannelButton alloc] init];
    [backView addSubview:_channelButton];
    
    playButton = [[HWSoundPlayButton alloc]initWithTitle:@"12" isBig:YES];
    [playButton addTarget:self action:@selector(doPlay) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:playButton];
    hasDownload = NO;
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [backView addSubview:activityView];
    
    self.activityView.center = CGPointMake((kScreenWidth - 30) / 2.0, 150 / 2.0f);
    [self.activityView startAnimating];
    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:bottomView];
    
    return self;
}

- (void)doSel
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kSetSelected object:_index];
}

- (void)rebuildWithInfo:(HWChannelItemClass *)neighbourClass indexPath:(NSIndexPath *)index
{
    //    [self rollBack];
    self.currentItem = neighbourClass;
    _index = index;
    
    if (self.isPersonalTopic)
    {
        self.headerImgV.userInteractionEnabled = NO;
    }
    
    if ([neighbourClass.isAnonymous isEqualToString:@"1"])
    {
        self.headerImgV.image = [UIImage imageNamed:@"head_1"];
    }
    else
    {
        NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/hw-sq-app-web/%@&key=%@",kUrlBase,neighbourClass.headUrl,[HWUserLogin currentUserLogin].key]];
        __weak UIImageView *blockImgV = self.headerImgV;
        [self.headerImgV setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"head_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
            if (error)
            {
                NSLog(@"Error : load image fail.");
                blockImgV.image = [UIImage imageNamed:@"head_placeholder"];
            }
            else
            {
                blockImgV.image = image;
                if (cacheType == 0)
                {
                    CATransition *transition = [CATransition animation];
                    transition.duration = 1.0f;
                    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                    transition.type = kCATransitionFade;
                    [blockImgV.layer addAnimation:transition forKey:nil];
                }
            }
        }];
    }
    self.NickNameLab.text = neighbourClass.nickName;
    if (neighbourClass.nickName.length == 0)
    {
        self.NickNameLab.text = @"无名的考拉";
    }
    if ([neighbourClass.isAnonymous isEqualToString:@"1"])
    {
        self.NickNameLab.text = @"某人";
    }
    if ([neighbourClass.userId isEqualToString:@"1"])
    {
        self.NickNameLab.text = @"考拉君";
    }
    self.publishTimeLab.text = neighbourClass.createTimeStr;//[Utility getTimeStampToStrRule:neighbourClass.createTime];
    
    BOOL isMine = NO;
    if ([neighbourClass.userId isEqualToString:[HWUserLogin currentUserLogin].userId])
    {
        isMine = YES;
    }
    if (self.isTopicList)
    {
        _channelButton.hidden = YES;
    }
    else if (isMine || neighbourClass.channelName.length > 0)
    {
        if (neighbourClass.channelName.length > 0)
        {
            [_channelButton setString:neighbourClass.channelName];
            [_channelButton addTarget:self action:@selector(doChannel) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            [_channelButton setString:@"+添加话题"];
            [_channelButton addTarget:self action:@selector(doChannel) forControlEvents:UIControlEventTouchUpInside];
        }
        _channelButton.frame = CGRectMake(kScreenWidth - 15 - _channelButton.frame.size.width, 20, _channelButton.frame.size.width, _channelButton.frame.size.height);
    }
    else
    {
        _channelButton.hidden = YES;
    }
    
    
    //MYP add
    NSString *timeStr = [NSString stringWithFormat:@"%@\"",neighbourClass.soundTime];
    [playButton setTitle:timeStr forState:UIControlStateNormal];
    
    
    [playButton setSoundBtnUrl:neighbourClass.mongodbKey andIndex:index];
    [playButton setString:neighbourClass.soundTime];
    playButton.center = CGPointMake(kScreenWidth / 2.0, 34 + 47);
    if (neighbourClass.itemPlayMode == DownloadingPlayMode)
    {
        //        [playButton setBackgroundImage:nil forState:UIControlStateNormal];
        playButton.buttonStatus = buttonStatusStop;
        [self.activityView startAnimating];
    }
    else if (neighbourClass.itemPlayMode == PlayingPlayMode)
    {
        //        [playButton setBackgroundImage:[UIImage imageNamed:@"sound4"] forState:UIControlStateNormal];
        playButton.buttonStatus = buttonStatusPlay;
        [self.activityView stopAnimating];
    }
    else if (neighbourClass.itemPlayMode == StopPlayMode)
    {
        //        [playButton setBackgroundImage:[UIImage imageNamed:@"sound1"] forState:UIControlStateNormal];
        playButton.buttonStatus = buttonStatusStop;
        [self.activityView stopAnimating];
    }
//    BOOL isMine = YES;
//    if (isMine) {
//        [channelButton setString:@"aaaa"];
//        channelButton.frame = CGRectMake(15, 40, channelButton.frame.size.width, channelButton.frame.size.height);
//    }else
//    {
//        channelButton.hidden = NO;
//    }
    [self recreatBottomViewWithModel:neighbourClass];
}


- (void)recreatBottomViewWithModel:(HWChannelItemClass *)model
{
    bottomView.frame = CGRectMake(0, backView.frame.size.height - kBottomHeight, kScreenWidth, kBottomHeight);
    NSString *likeCount = model.praiseCount;
    NSString *repeatCount = model.replyCount;
    for (UIView *view in bottomView.subviews) {
        if ([view isKindOfClass:[UIView class]] || [view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kLeftMargin, 0, kScreenWidth - kLeftMargin * 2, kBottomHeight)];
//    label.textColor = THEME_COLOR_GRAY_MIDDLE;
//    
//    if ([model.villageId isEqualToString:[HWUserLogin currentUserLogin].villageId])
//    {
//        label.text = @"邻居";
//        label.textColor = THEME_COLOR_ORANGE;
//    }else if (model.villageName.length > 0)
//    {
//        label.text = model.villageName;
//    }
//    else if (model.areaName.length > 0)
//    {
//        label.text = model.areaName;
//    }
//    else
//    {
//        label.text = [NSString stringWithFormat:@"%@热门",[HWUserLogin currentUserLogin].cityName];
//    }
//    label.font = [UIFont systemFontOfSize:THEME_FONT_SMALL];
//    [bottomView addSubview:label];
    
    HWLikeButton *rightButton = [HWLikeButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"bb"] forState:UIControlStateHighlighted];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"bb"] forState:UIControlStateNormal];
    if ([currentItem.hasPraise isEqualToString:@"1"])
    {
        [rightButton setImage:[UIImage imageNamed:@"like_hi"] forState:UIControlStateNormal];
    }
    else
    {
        [rightButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    }
    [rightButton setTitle:likeCount forState:UIControlStateNormal];
    //MYP add
    if ([likeCount intValue] > 99)
    {
        [rightButton setTitle:@"99+" forState:UIControlStateNormal];
    }
    [rightButton setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, -5)];
    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 2)];
    //    float right = [self getWidthWithCount:praiseCount];
    rightButton.frame = CGRectMake(9, 0, 60, 31);
    [rightButton addTarget:self action:@selector(doLike:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:rightButton];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"bb"] forState:UIControlStateHighlighted];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"bb"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"reviewd"] forState:UIControlStateNormal];
    [leftButton setTitle:repeatCount forState:UIControlStateNormal];
    [leftButton setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, -5)];
    [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 2)];
    //    float left = [self getWidthWithCount:repeatCount];
    leftButton.frame = CGRectMake(CGRectGetMaxX(rightButton.frame) + 20, 0, 60, 31);
    //    [leftButton addTarget:self action:@selector(doComment) forControlEvents:UIControlEventTouchUpInside];
    leftButton.userInteractionEnabled = NO;
    
//    UIView *lineV1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5f)];
//    lineV1.backgroundColor = THEME_COLOR_LINE;
//    [bottomView addSubview:lineV1];
    
//    UIView *lineV2 = [[UIView alloc]initWithFrame:CGRectMake(0, 44.5f, kScreenWidth, 0.5f)];
//    lineV2.backgroundColor = THEME_COLOR_LINE;
//    [bottomView addSubview:lineV2];
    
    [bottomView addSubview:leftButton];
}

- (float)getWidthWithCount:(NSString *)string
{
    if (IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:THEME_FONT_SMALL]};
        CGRect rect = [string boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil];
        return rect.size.width;
    }else
    {
        CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:THEME_FONT_SMALL]];
        return size.width;
    }
}

//赞
- (void)doLike:(HWLikeButton *)btn
{
    //    检测网络
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    
    if ([r currentReachabilityStatus] == NotReachable) {
        [Utility showToastWithMessage:@"无网络连接！" inView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    
    if ([currentItem.hasPraise isEqualToString:@"0"])
    {
        currentItem.hasPraise = @"1";
        currentItem.praiseCount = [NSString stringWithFormat:@"%d",[currentItem.praiseCount intValue] + 1];
        if ([currentItem.praiseCount intValue] > 99)
        {
            [btn setTitle:@"99+" forState:UIControlStateNormal];
        }
        else
        {
            [btn setTitle:currentItem.praiseCount forState:UIControlStateNormal];
        }
        [btn setLike:YES];
        [self performSelector:@selector(doLikeDelay:) withObject:@"1" afterDelay:0.5f];
        
    }
    else
    {
        currentItem.hasPraise = @"0";
        currentItem.praiseCount = [NSString stringWithFormat:@"%d",[currentItem.praiseCount intValue] - 1];
        if ([currentItem.praiseCount intValue] > 99)
        {
            [btn setTitle:@"99+" forState:UIControlStateNormal];
        }
        else
        {
            [btn setTitle:currentItem.praiseCount forState:UIControlStateNormal];
        }
        [btn setLike:NO];
        [self performSelector:@selector(doLikeDelay:) withObject:@"0" afterDelay:0.5f];
    }
    
}

- (void)doLikeDelay:(NSString *)isLike
{
    [self.delegate doLike:[isLike boolValue] WithIndex:_index];
}

- (void)doPlay
{
    [MobClick event:@"click_bofangshengyin"];
    NSLog(@"%ld,%ld",(long)_index.section,(long)_index.row);
    HWAudioManager *customerAudio = [HWAudioManager shareAudioManager];
    [customerAudio playAudioUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@/hw-sq-app-web/file/downloadByKey.do?mKey=%@&key=%@",kUrlBase ,currentItem.mongodbKey, [HWUserLogin currentUserLogin].key]] forIndexPath:_index];
}

- (void)doChannel
{
    
    if (currentItem.channelId.length > 0)
    {
        [self.delegate showChannelWithIndex:_index];
    }
    else
    {
        [self.delegate addChannelWithIndex:_index];
    }
}

- (void)headerImgClick
{
    if ([self.currentItem.isAnonymous isEqualToString:@"1"])
    {
        if ([self.delegate isKindOfClass:[UIView class]])
        {
            UIView *view = (UIView *)self.delegate;
            [Utility showToastWithMessage:@"此用户闭关中，看看别的邻居吧~" inView:view];
        }
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(showPersonalHomePageWithIndex:)])
        {
            [self.delegate showPersonalHomePageWithIndex:_index];
        }
    }
}

@end
