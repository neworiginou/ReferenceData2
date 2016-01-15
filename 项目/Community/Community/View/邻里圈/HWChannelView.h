//
//  HWChannelView.h
//  Community
//
//  Created by zhangxun on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWChannelModel.h"

#import "HWChannelNewCell.h"
#import "HWChannelVoiceCell.h"

#import "HWNoFoundPicView.h"

#import "HWDetailViewController.h"
#import "HWPersonalHomePageVC.h"

@protocol HWChannelViewDelegate <NSObject>

@optional
- (void)pushController:(id)controller;
- (void)popViewController;
- (void)doLikeWithIndex:(NSIndexPath *)index;
- (void)changeListWithString:(NSString *)string;
- (void)changeNavTitle:(NSString *)string;
- (void)didAddChannel;
- (void)pushToDetailViewController:(NSString *)topicId resourceType:(detailResource)type isChuanChuanMen:(BOOL)isChuan personalVC:(UIViewController *)personalVC channelId:(NSString *)channelId;

@end

@interface HWChannelView : HWBaseRefreshView<HWChannelNewCellDelegate,HWChannelVoiceCellDelegate>
{
    NSIndexPath *_currentIndex;
    UIView *_headerView;
}

@property (nonatomic,strong)UIImageView *bannerImgView;
@property (nonatomic, strong) UIView *bannerView;
@property (nonatomic,strong)HWNoFoundPicView *nofoundView;
@property (nonatomic,strong)HWChannelModel *channelModel;
@property (nonatomic,strong)NSString *range;
@property (nonatomic,strong)NSString *bannerIcon;
@property (nonatomic,strong)NSString *bannerUrl;
@property (nonatomic, strong) NSIndexPath *currentIndex;
@property (nonatomic,weak) id <HWChannelViewDelegate>delegate;

@property (nonatomic, strong) NSArray *chuanChuanMenVillageIdArr;   //串串门villageId数组
@property (nonatomic, assign) NSUInteger lastvillageArrIndex;      //串串门上一个小区ID在数组的下标
@property (nonatomic, assign) BOOL isChangedVillageId;
@property (nonatomic, strong) NSString *currentVillageId;    //当前串串门儿所在的VillageId;
@property (nonatomic, assign) BOOL chuanChuanMenCanNotHandle;   //是否是串串门儿（是否可操作）默认可操作

@property (nonatomic, strong) NSString *userId;     //个人主页 - 个人主题列表userId
@property (nonatomic, weak) UIViewController *personalVC; //个人主页Vc 点击头像调回用

@property (nonatomic, assign) BOOL isPersonalTopic; //是否个人话题    头像不可点击
@property (nonatomic, assign) BOOL isTopicList;     //是否是话题列表 话题列表不显示话题按钮

@property (nonatomic, weak) UIViewController *superVC;

- (void)queryListData;
- (void)changeChuanChuanMenVillageIdQuery;

- (void)changeLike:(NSString *)likeCount isPrise:(NSString *)isPrise;
- (void)changeComment:(NSString *)commentCount;
- (void)selectChannel:(HWChannelModel *)channelMode;

- (void)refreshList;


- (void)downloadingAudio:(NSNotification *)notification;

- (void)downloadAudioFinish:(NSNotification *)notificaiton;

- (void)downloadAudioFailed:(NSNotification *)notificaiton;

- (void)startPlayNotification:(NSNotification *)notificaiton;

- (void)pausePlayNotification:(NSNotification *)notificaiton;

- (void)stopPlayNotification:(NSNotification *)notificaiton;

@end
