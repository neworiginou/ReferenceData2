//
//  HWChannelVoiceCell.h
//  Community
//
//  Created by zhangxun on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWAnimateBaseCell.h"

#import "HWAudioManager.h"
#import "HWSoundPlayButton.h"
#import "HWChannelButton.h"
#import "HWChannelItemClass.h"


@protocol HWChannelVoiceCellDelegate <NSObject>

- (void)doLike:(BOOL)isLike WithIndex:(NSIndexPath *)index;
- (void)showChannelWithIndex:(NSIndexPath *)index;
- (void)addChannelWithIndex:(NSIndexPath *)index;
- (void)popToPersonalHomePageVC;
- (void)showPersonalHomePageWithIndex:(NSIndexPath *)index;

@end

@interface HWChannelVoiceCell : HWAnimateBaseCell

{
    UIView *_tagV;
    NSIndexPath *_index;
}

@property (nonatomic,strong)UIView *backView;
@property (nonatomic, strong) UIImageView *headerImgV;
@property (nonatomic, strong) UILabel *NickNameLab;
@property (nonatomic, strong) UILabel *publishTimeLab;
@property (nonatomic,strong)HWSoundPlayButton *playButton;
@property (nonatomic,assign)BOOL hasDownload;

@property (nonatomic,strong)HWChannelItemClass *currentItem;
@property (nonatomic,strong)UIActivityIndicatorView *activityView;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic,strong)HWChannelButton *channelButton;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,assign)id <HWChannelVoiceCellDelegate>delegate;
@property (nonatomic, assign) BOOL chuanChuanMenCanNotHandle; //串串门不可操作标志变量
@property (nonatomic, assign) BOOL isTopicList;     //是否是某话题列表 话题列表不显示话题按钮
@property (nonatomic, assign) BOOL isPersonalTopic; //是否是个人主页主题 头像不可点击

- (void)rebuildWithInfo:(HWChannelItemClass *)neighbourClass indexPath:(NSIndexPath *)index;

- (void)doPlay;

@end
