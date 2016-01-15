//
//  HWPersonDynamicRefreshCell.m
//  Community
//
//  Created by hw500027 on 15/1/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：个人动态详情cell
//  修改记录：
//	姓名    日期         修改内容
//  陆晓波  2015-01-14   添加填充数据方法
//  陆晓波  2015-01-15   自定义_titleView显示文本+语音时，方法修改
//  陆晓波  2015-01-16   加载@我的数据时，增加判断未读状态
//  陆晓波  2015-01-17   实现填充 个人动态-赞 的数据
//  陆晓波  2015-01-19   个人动态-评论UI调整 加载图片方法修改
//  陆晓波  2015-01-20   语音播放按钮添加通知
//  陆晓波  2015-01-21   语音播放按钮修改
//  陆晓波  2015-01-22   判断图文，纯文字，语音方法修改
//  陆晓波  2015-01-23   _replyLabel宽度修改
//  陆晓波  2015-01-26   UI修改，bug修改，填充数据字段修改
//  陆晓波  2015-01-28   _nameLabel 16改为15，NICKNAME_WITH_TIMELABEL_DISTANCE 3改为5
//  陆晓波  2015-01-29   @我的，字段修改
//  陆晓波  2015-01-30   判断主题内容条件修改，releaseType == 0,23:图片、文字 2,25:音频 剩下全文字
//  陆晓波  2015-02-02   增加判断。自己给自己点赞时，隐藏红点

#define NICKNAME_WITH_TIMELABEL_DISTANCE 5  //昵称与日期间距
#define XDISTANCE 10                        //x轴方向间距
#define YDISTANCE 15                        //y轴方向间距

#import "HWPersonDynamicRefreshCell.h"
#import "HWSoundPlayButton.h"

@implementation HWPersonDynamicRefreshCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //头像
        _iconImgV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 35, 35)];
        _iconImgV.backgroundColor = [UIColor lightGrayColor];
        _iconImgV.layer.masksToBounds = YES;
        _iconImgV.layer.cornerRadius = 17.5f;
        [self.contentView addSubview:_iconImgV];
        
        //名称
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImgV.frame) + XDISTANCE, _iconImgV.frame.origin.y, 150 , THEME_FONT_BIG)];
        _nameLabel.backgroundColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        [self.contentView addSubview:_nameLabel];
        
        //时间
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImgV.frame) + XDISTANCE, CGRectGetMaxY(_nameLabel.frame) + NICKNAME_WITH_TIMELABEL_DISTANCE , 150 , THEME_FONT_SMALL13)];
        _timeLabel.backgroundColor = [UIColor whiteColor];
        _timeLabel.textColor = THEME_COLOR_TEXT;
        _timeLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
        [self.contentView addSubview:_timeLabel];
        
        //回复
        _replyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_iconImgV.frame), CGRectGetMaxY(_iconImgV.frame) + YDISTANCE ,kScreenWidth - CGRectGetMinX(_iconImgV.frame) * 2 , THEME_FONT_BIG)];
        _replyLabel.backgroundColor = [UIColor whiteColor];
        _replyLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        _replyLabel.textColor = THEME_COLOR_SMOKE;
        [self.contentView addSubview:_replyLabel];
        
        //主题
        _titleView = [[HWPersonDynamicCustomBackGroundView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_iconImgV.frame), CGRectGetMaxY(_replyLabel.frame) + YDISTANCE , kScreenWidth - 30, 55)];
        [self.contentView addSubview:_titleView];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0 , 155.0f - 0.5f , kScreenWidth , 0.5f)];
        _line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:_line];
        
        //未读信息红点
        _redPoint = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"unread03"]];
        _redPoint.frame = CGRectMake(kScreenWidth - _redPoint.image.size.width - 15 , 20 , _redPoint.image.size.width , _redPoint.image.size.height);
        [_redPoint.layer setCornerRadius:5.0f];
        [_redPoint.layer setMasksToBounds:YES];
        [self.contentView addSubview:_redPoint];
        //默认未读信息红点为隐藏
        _redPoint.hidden = YES;
        
        //播放语音按钮
        _soundPlayButton = [[HWSoundPlayButton alloc]initWithTitle:@"99" isBig:NO];
        _soundPlayButton.hidden = YES;
        [_soundPlayButton addTarget:self action:@selector(doPlay) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:_soundPlayButton];
    }
    return self;
}

/**
 *	@brief	加载 个人动态-@我的
 *
 *	@param 	model 个人动态model
 *
 *	@return	N/A
 */
- (void)setMineTypeInfo:(HWPersonDynamicModel *)model

{
    //下载图片
    __weak UIImageView *weakImgV = _iconImgV;
    [_iconImgV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:model.headUrl]] placeholderImage:[UIImage imageNamed:@"head_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType)
     {
         if (error != nil)
         {
             weakImgV.image = [UIImage imageNamed:@"head_placeholder"];
         }
         else
         {
             weakImgV.image = image;
         }
     }];
    
    _nameLabel.text = model.nickName;
    [_nameLabel sizeToFit];
    
    _replyLabel.text = model.replyContent;
    [_replyLabel sizeToFit];
    _replyLabel.frame = CGRectMake(_replyLabel.frame.origin.x, _replyLabel.frame.origin.y, kScreenWidth - CGRectGetMinX(_iconImgV.frame) * 2, _replyLabel.frame.size.height);
    
    _timeLabel.text = model.createTimeStr;
    [_timeLabel sizeToFit];
    
    // 0,23:图片、文字 2,25:音频 剩下全文字
    if ([model.releaseType isEqual:@"2"] || [model.releaseType isEqual:@"25"])
    {
        //文字+语音
        NSString *sendSoundUserStr = [NSString stringWithFormat:@"%@发表了一段语音",model.topicNickName];
        [_titleView setTopicContent:sendSoundUserStr withSound:model.topicAttUrl withSoundTime:model.soundTime withIndexPath:self.indexPath];
        
        //播放语音按钮
        [_soundPlayButton setTitle:model.soundTime.length > 0 ?[NSString stringWithFormat:@"%@\"",model.soundTime]:@"" forState:UIControlStateNormal];
        _soundPlayButton.center = CGPointMake(_titleView.frame.size.width / 5 * 3 + 11, _titleView.frame.size.height / 2);
        _soundUrl = model.topicAttUrl;
        _soundPlayButton.hidden = NO;
        
        [_soundPlayButton setSoundBtnUrl:model.topicAttUrl andIndex:_indexPath];
        if (model.itemPlayMode == DownloadingPlayMode)
        {
            _soundPlayButton.buttonStatus = buttonStatusStop;
        }
        else if (model.itemPlayMode == PlayingPlayMode)
        {
            _soundPlayButton.buttonStatus = buttonStatusPlay;
        }
        else if (model.itemPlayMode == StopPlayMode)
        {
            _soundPlayButton.buttonStatus = buttonStatusStop;
        }
    }
    else if ([model.releaseType isEqual:@"0"] || [model.releaseType isEqual:@"23"])
    {
        //文字+图片
        _soundPlayButton.hidden = YES;
        NSString *attUrl = [Utility imageDownloadUrl:model.topicAttUrl];
        [_titleView setTopicContent:model.topicContent withImage:[NSURL URLWithString:attUrl]];
    }
    else
    {
        //纯文字
        _soundPlayButton.hidden = YES;
        [_titleView setTopicContent:model.topicContent];
    }
    //"isRead": 是否已读0，未读；1，已读。 未读时，显示红点
    if ([model.isRead isEqualToString:@"0"])
    {
        _redPoint.hidden = NO;
    }
    else
    {
        _redPoint.hidden = YES;
    }
}

/**
 *	@brief	加载 个人动态评论
 *
 *	@param 	model 个人动态model
 *
 *	@return	N/A
 */
- (void)setCommentTypeInfo:(HWPersonDynamicModel *)model
{
    //下载图片
    __weak UIImageView *weakImgV = _iconImgV;
    [_iconImgV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:model.replyUserHeadUrl]] placeholderImage:[UIImage imageNamed:@"head_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType)
     {
         if (error != nil)
         {
             weakImgV.image = [UIImage imageNamed:@"head_placeholder"];
         }
         else
         {
             weakImgV.image = image;
         }
     }];
    
    _nameLabel.text = model.replyUserNickName;
    [_nameLabel sizeToFit];
    
    _replyLabel.text = model.replyContent;
    [_replyLabel sizeToFit];
    _replyLabel.frame = CGRectMake(_replyLabel.frame.origin.x, _replyLabel.frame.origin.y, kScreenWidth - CGRectGetMinX(_iconImgV.frame) * 2, _replyLabel.frame.size.height);
    
    _timeLabel.text = model.replyCreateTimeStr;
    [_timeLabel sizeToFit];
    
    // 0,23:图片、文字 2,25:音频 剩下全文字
    if ([model.releaseType isEqual:@"2"] || [model.releaseType isEqual:@"25"])
    {
        //文字+语音
        NSString *sendSoundUserStr = [NSString stringWithFormat:@"%@发表了一段语音",model.topicUserNickName];
        [_titleView setTopicContent:sendSoundUserStr withSound:model.topicAttUrl withSoundTime:model.soundTime withIndexPath:self.indexPath];
        
        //播放语音按钮
        _soundPlayButton.center = CGPointMake(_titleView.frame.size.width / 5 * 3 + 11, _titleView.frame.size.height / 2);
        _soundUrl = model.topicAttUrl;
        _soundPlayButton.hidden = NO;
        [_soundPlayButton setTitle:model.soundTime.length > 0 ?[NSString stringWithFormat:@"%@\"",model.soundTime]:@"" forState:UIControlStateNormal];
        [_soundPlayButton setSoundBtnUrl:model.topicAttUrl andIndex:_indexPath];
        if (model.itemPlayMode == DownloadingPlayMode)
        {
            _soundPlayButton.buttonStatus = buttonStatusStop;
        }
        else if (model.itemPlayMode == PlayingPlayMode)
        {
            _soundPlayButton.buttonStatus = buttonStatusPlay;
        }
        else if (model.itemPlayMode == StopPlayMode)
        {
            _soundPlayButton.buttonStatus = buttonStatusStop;
        }
    }
    else if ([model.releaseType isEqual:@"0"] || [model.releaseType isEqual:@"23"])
    {
        //文字+图片
        _soundPlayButton.hidden = YES;
        NSString *attUrl = [Utility imageDownloadUrl:model.topicAttUrl];
        [_titleView setTopicContent:model.topicContent withImage:[NSURL URLWithString:attUrl]];
    }
    else
    {
        //纯文字
        _soundPlayButton.hidden = YES;
        [_titleView setTopicContent:model.topicContent];
    }
    //"isRead": 是否已读0，未读；1，已读。 未读时，显示红点
    if ([model.replyUserId isEqualToString:[HWUserLogin currentUserLogin].userId])
    {
        _redPoint.hidden = YES;
    }
    else
    {
        if ([model.isRead isEqualToString:@"0"])
        {
            _redPoint.hidden = NO;
        }
        else
        {
            _redPoint.hidden = YES;
        }
    }
}

/**
 *	@brief	加载 个人动态赞
 *
 *	@param 	model 个人动态model
 *
 *	@return	N/A
 */
- (void)setLikeTypeInfo:(HWPersonDynamicModel *)model
{
    //如果当前用户id = 发送人用户id
    if ([[HWUserLogin currentUserLogin].userId isEqualToString:model.sendPraiseUserId])
    {
        _replyLabel.text = @"你赞了这条主题";
    }
    else
    {
        _replyLabel.text = @"赞了你的主题";
    }
    
    //下载图片
    __weak UIImageView *weakImgV = _iconImgV;
    [_iconImgV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:model.sendPraiseHeadUrl]] placeholderImage:[UIImage imageNamed:@"head_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType)
     {
         if (error != nil)
         {
             weakImgV.image = [UIImage imageNamed:@"head_placeholder"];
         }
         else
         {
             weakImgV.image = image;
         }
     }];
    
    _nameLabel.text = model.sendPraiseNickName;
    [_nameLabel sizeToFit];
    _timeLabel.text = model.createTimeStr;
    [_timeLabel sizeToFit];
    
    // 0,23:图片、文字 2,25:音频 剩下全文字
    if ([model.releaseType isEqual:@"2"] || [model.releaseType isEqual:@"25"])
    {
        //文字+语音
        NSString *sendSoundUserStr = [NSString stringWithFormat:@"%@发表了一段语音",model.receivePraiseNickName];
        [_titleView setTopicContent:sendSoundUserStr withSound:model.topicAttUrl withSoundTime:model.soundTime withIndexPath:self.indexPath];
        
        //播放语音按钮
        _soundPlayButton.center = CGPointMake(_titleView.frame.size.width / 5 * 3 + 11, _titleView.frame.size.height / 2);
        _soundUrl = model.topicAttUrl;
        _soundPlayButton.hidden = NO;
        [_soundPlayButton setTitle:model.soundTime.length > 0 ?[NSString stringWithFormat:@"%@\"",model.soundTime]:@"" forState:UIControlStateNormal];
        [_soundPlayButton setSoundBtnUrl:model.topicAttUrl andIndex:_indexPath];
        if (model.itemPlayMode == DownloadingPlayMode)
        {
            _soundPlayButton.buttonStatus = buttonStatusStop;
        }
        else if (model.itemPlayMode == PlayingPlayMode)
        {
            _soundPlayButton.buttonStatus = buttonStatusPlay;
        }
        else if (model.itemPlayMode == StopPlayMode)
        {
            _soundPlayButton.buttonStatus = buttonStatusStop;
        }
    }
    else if ([model.releaseType isEqual:@"0"] || [model.releaseType isEqual:@"23"])
    {
        //文字+图片
        _soundPlayButton.hidden = YES;
        NSString *attUrl = [Utility imageDownloadUrl:model.topicAttUrl];
        [_titleView setTopicContent:model.topicContent withImage:[NSURL URLWithString:attUrl]];
    }
    else
    {
        //纯文字
        _soundPlayButton.hidden = YES;
        [_titleView setTopicContent:model.topicContent];
    }
    //"isRead":  0，未读；1，已读 未读时，显示红点
    if ([model.isRead isEqualToString:@"0"])
    {
        _redPoint.hidden = NO;
        
        //如果发赞人id == 当前用户id，即自己给自己点赞时，隐藏红点
        if ([model.sendPraiseUserId isEqual:[HWUserLogin currentUserLogin].userId])
        {
            _redPoint.hidden = YES;
        }
    }
    else
    {
        _redPoint.hidden = YES;
    }
}

/**
 *	@brief	加载 个人动态主题
 *
 *	@param 	model 个人动态model
 *
 *	@return	N/A
 */
- (void)setThemeTypeInfo:(HWPersonDynamicModel *)model
{
    //下载图片
    __weak UIImageView *weakImgV = _iconImgV;
    [_iconImgV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:model.headUrl]] placeholderImage:[UIImage imageNamed:@"head_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType)
    {
        if (error != nil)
        {
            weakImgV.image = [UIImage imageNamed:@"head_placeholder"];
        }
        else
        {
            weakImgV.image = image;
        }
    }];
    
    _nameLabel.text = model.nickName;
    [_nameLabel sizeToFit];
    _timeLabel.text = model.createTimeStr;
    [_timeLabel sizeToFit];
    
    // 0,23:图片、文字 2,25:音频 剩下全文字
    if ([model.releaseType isEqual:@"2"] || [model.releaseType isEqual:@"25"])
    {
        //文字+语音
        NSString *sendSoundUserStr = [NSString stringWithFormat:@"%@发表了一段语音",model.nickName];
        [_titleView setTopicContent:sendSoundUserStr withSound:model.topicAttUrl withSoundTime:model.soundTime withIndexPath:self.indexPath];
        
        //播放语音按钮
        _soundPlayButton.center = CGPointMake(_titleView.frame.size.width / 5 * 3 + 11, _titleView.frame.size.height / 2);
        _soundUrl = model.topicAttUrl;
        _soundPlayButton.hidden = NO;
        [_soundPlayButton setTitle:model.soundTime.length > 0 ?[NSString stringWithFormat:@"%@\"",model.soundTime]:@"" forState:UIControlStateNormal];
        [_soundPlayButton setSoundBtnUrl:model.topicAttUrl andIndex:_indexPath];
        if (model.itemPlayMode == DownloadingPlayMode)
        {
            _soundPlayButton.buttonStatus = buttonStatusStop;
        }
        else if (model.itemPlayMode == PlayingPlayMode)
        {
            _soundPlayButton.buttonStatus = buttonStatusPlay;
        }
        else if (model.itemPlayMode == StopPlayMode)
        {
            _soundPlayButton.buttonStatus = buttonStatusStop;
        }
    }
    else if ([model.releaseType isEqual:@"0"] || [model.releaseType isEqual:@"23"])
    {
        _soundPlayButton.hidden = YES;
        //文字+图片
        NSString *attUrl = [Utility imageDownloadUrl:model.topicAttUrl];
        [_titleView setTopicContent:model.topicContent withImage:[NSURL URLWithString:attUrl]];
    }
    else
    {
        //纯文字
        [_titleView setTopicContent:model.topicContent];
        _soundPlayButton.hidden = YES;
    }
    _titleView.frame = CGRectMake(CGRectGetMinX(_iconImgV.frame), CGRectGetMaxY(_replyLabel.frame) + 15 - 30, kScreenWidth - 30, 55);
    _line.frame = CGRectMake(0, 155.0f - 0.5f - 30.0f, kScreenWidth, 0.5f);
    
    _redPoint.hidden = YES;
}

- (void)doPlay
{
    //_soundUrl = @"file/downloadByKey.do?mKey=54bce387e4b074eb157b9a4b&key=1a638978-2947-4cb6-8dab-2a12f2960fb3";
    HWAudioManager *customerAudio = [HWAudioManager shareAudioManager];
    [customerAudio playAudioUrl:[NSURL URLWithString:[Utility imageDownloadUrl:_soundUrl]] forIndexPath:_indexPath];
    NSLog(@"_soundUrl==%@",_soundUrl);
}

+ (CGFloat)getCellHeight:(NSDictionary *)info
{
    return 1;
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
