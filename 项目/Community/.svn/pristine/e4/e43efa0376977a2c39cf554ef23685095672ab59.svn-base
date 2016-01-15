//
//  HWPersonDynamicCustomBackGroundView.m
//  Community
//
//  Created by hw500027 on 15/1/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：自定义view 显示文字+语音，文字+图片，纯文字主题
//  修改记录：
//	姓名      日期         修改内容
//  陆晓波    2015-01-15   添加自定义语音播放按钮
//  陆晓波    2015-01-19   去除语音播放按钮,UI调整
//  陆晓波    2015-01-21   默认加载图片修改
//  陆晓波    2015-01-22   UI调整
//  陆晓波    2015-02-02   UI调整

#define ORIGINX 25  //x轴起始点
#define IMGVIEW_BETWEEN_LABEL 9 //图片与文本距离

#import "HWPersonDynamicCustomBackGroundView.h"
#import "HWSoundPlayButton.h"

@implementation HWPersonDynamicCustomBackGroundView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self loadCustomBackGroundView];
    }
    return self;
}

-(void)loadCustomBackGroundView
{
    self.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3.0f;
    
    UIImageView* leftQuotationImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"quotation01"]];
    leftQuotationImgV.frame = CGRectMake(8, 10, leftQuotationImgV.frame.size.width, leftQuotationImgV.frame.size.height);
    [self addSubview:leftQuotationImgV];
    
    UIImageView* rightQuotationImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"quotation02"]];
    rightQuotationImgV.frame = CGRectMake(self.frame.size.width - 22, 35, rightQuotationImgV.frame.size.width, rightQuotationImgV.frame.size.height);
    [self addSubview:rightQuotationImgV];
    
    _topicContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(ORIGINX, 10, 0, 0)];
    [self addSubview:_topicContentLabel];
    
    _topicImgV = [[UIImageView alloc]initWithFrame:CGRectMake(ORIGINX, 6, 62, 41.5f)];
    [self addSubview:_topicImgV];
}

/**
 *	@brief	自定义view 显示纯文字内容
 *
 *	@param 	topicContentStr 主题内容
 *
 *	@return	N/A
 */
-(void)setTopicContent:(NSString*)topicContentStr
{
    _topicImgV.hidden = YES;
    CGFloat strWidth = self.frame.size.width - 22 - ORIGINX - IMGVIEW_BETWEEN_LABEL;
    CGSize strHeight = [Utility calculateStringHeight:topicContentStr font:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13] constrainedSize:CGSizeMake(strWidth, 1000)];
    
    _topicContentLabel.frame = CGRectMake(ORIGINX, 12, strWidth + 2, strHeight.height);
    _topicContentLabel.textColor = THEME_COLOR_TEXT;
    _topicContentLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
    _topicContentLabel.text = topicContentStr;
    _topicContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _topicContentLabel.numberOfLines = 2;
    [_topicContentLabel sizeToFit];
}

/**
 *	@brief	自定义view 显示文字+图片
 *
 *	@param 	topicContentStr 	主题内容
 *	@param 	imageUrl 	图片Url
 *
 *	@return	N/A
 */
-(void)setTopicContent:(NSString*)topicContentStr withImage:(NSURL*)imageUrl
{
    _topicImgV.hidden = NO;
    _topicImgV.frame = CGRectMake(ORIGINX, 7, 62, 41.5f);
    __weak UIImageView *weakImgV = _topicImgV;
    [_topicImgV setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType)
     {
         if (error != nil)
         {
             weakImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
         }
         else
         {
             weakImgV.image = image;
         }
     }];
    
    //22为 右引号 距 自定义view右边距 距离
    CGFloat strWidth = self.frame.size.width - CGRectGetMaxX(_topicImgV.frame) - IMGVIEW_BETWEEN_LABEL * 2 - 22;
    CGSize strHeight = [Utility calculateStringHeight:topicContentStr font:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13] constrainedSize:CGSizeMake(strWidth, 1000)];
    
    _topicContentLabel.frame = CGRectMake( CGRectGetMaxX(_topicImgV.frame) + IMGVIEW_BETWEEN_LABEL - 2, 12, strWidth + 8, strHeight.height);
    _topicContentLabel.textColor = THEME_COLOR_TEXT;
    _topicContentLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
    _topicContentLabel.text = topicContentStr;
    _topicContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _topicContentLabel.numberOfLines = 2;
    [_topicContentLabel sizeToFit];
}

/**
 *	@brief	自定义view 显示文字+语音
 *
 *	@param 	topicContentStr 	主题内容
 *	@param 	soundUrl 	语音URL
 *	@param 	soundTime 	语音时长
 *	@param 	indexPath 	cell的indexpath
 *
 *	@return	N/A
 */
-(void)setTopicContent:(NSString*)topicContentStr withSound:(NSString*)soundUrl withSoundTime:(NSString*)soundTime withIndexPath:(NSIndexPath*)indexPath

{
    _topicImgV.hidden = YES;
    CGFloat strWidth = self.frame.size.width / 2 - ORIGINX;
    CGSize strHeight = [Utility calculateStringHeight:topicContentStr font:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13] constrainedSize:CGSizeMake(strWidth, 1000)];
    
    _topicContentLabel.frame = CGRectMake(ORIGINX, 12, strWidth + 2, strHeight.height);
    _topicContentLabel.textColor = THEME_COLOR_TEXT;
    _topicContentLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
    _topicContentLabel.text = topicContentStr;
    _topicContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _topicContentLabel.numberOfLines = 2;
    [_topicContentLabel sizeToFit];
    
//    HWSoundPlayButton *soundBtn = [[HWSoundPlayButton alloc] initWithTitle:soundTime];
//    [soundBtn setSoundBtnUrl:soundUrl andIndex:indexPath];
//    soundBtn.frame = CGRectMake(CGRectGetMaxX(topicContentLabel.frame) + 20, topicContentLabel.frame.origin.y , soundBtn.frame.size.width, soundBtn.frame.size.height);
//    _playSoundUrl = soundUrl;
//    _aIndexPath = indexPath;
//    [soundBtn addTarget:self action:@selector(toPlay) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:soundBtn];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
