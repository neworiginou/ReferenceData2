//
//  HWDetailViewController.h
//  Community
//
//  Created by zhangxun on 14-9-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  邻里圈详情（非物业公告）
//
#import "HWRefreshBaseViewController.h"
#import "HWNeighbourItemClass.h"
#import "HWNeighbourButton.h"
#import "HWNeighbourDetailCell.h"
#import "HWChannelButton.h"
#import "HWSoundPlayButton.h"
#import "HWPraiseView.h"
#import "HWCustomSiftView.h"
#import "HWAddChannelViewController.h"



@protocol HWDetailViewControllerDelete <NSObject>

- (void)deleteCardWithCardIndex:(NSIndexPath *)index;
//邻里圈回传代理
- (void)setChannel:(HWChannelModel *)model;

@optional
- (void)deleteChannelWithCardIndex:(NSIndexPath *)index;

- (void)changeLike:(NSDictionary *)dict;

- (void)changeComment:(NSDictionary *)dict;

@end


@interface HWDetailViewController : HWRefreshBaseViewController<UIActionSheetDelegate,HWNeighbourDetailCellDelegate,UITextViewDelegate,UIAlertViewDelegate,SWTableViewCellDelegate,HWPraiseViewDelegate,HWCustomSiftViewDelegate,HWAddChannelViewControllerDelegate,UIGestureRecognizerDelegate>

{
    //从列表页拿到的标签内容
    HWNeighbourItemClass *_cardInfo;
    
    UITextView *_commentTF;
    UIView *_commentV;
    UIButton *_commentButton;       //发送按钮
    UILabel *_commentAtLabel;       //@某人
    NSString *_commentAtStr;        //@人
    NSString *_commentAtId;         //被@人id

    //从列表页传过来的index
    NSIndexPath *_cardIndex;
    NSString *_cardId;
    BOOL _isPush;
    UIView *_tagV;
    
    UIView *_realHeaderView;
    
    //0主题1评论
    NSString *_reportId;
    NSString *_reportType;
    
    //0主题1评论
    NSString *_deleteId;
    NSString *_deleteType;
    
    HWChannelButton *_channelBtn;
    
    
    HWNeighbourDetailCell *_detailCell;
    
    NSIndexPath *_longPressIndex;
    HWSoundPlayButton *_playButton;
    UIActivityIndicatorView *_activityView;
    
    UIView *_coverView;
    
    BOOL _isAllowCopy;
    
    HWPraiseView *praise;
    NSString *replyIdDelete;                    //要删除的replyid
    NSString *reportReplyId;                    //要举报的id
    NSString *selectViewRangeStr;               //选择可见范围
    NSIndexPath *currentCellIndexPath;          //当前cell的索引
}

@property (nonatomic, assign) BOOL isShouldCommentTFBecomeFirstResponse;
@property (nonatomic,assign)BOOL animate;
@property (nonatomic,assign)PlayMode detailPlayMode;
@property (nonatomic,assign)id <HWDetailViewControllerDelete>delegate;
@property (nonatomic,assign)detailResource resourceType;
@property (nonatomic, assign) BOOL chuanChuanMenCanNotHandle;   //串串门不可操作 yes为不可操作
@property (nonatomic, weak) UIViewController *personalVC; //是否是个人主页跳进来的，是就在点头像时pop到个人主页

@property (nonatomic, strong) NSString *channelId;

- (id)initWithCardInfo:(HWNeighbourItemClass *)cardInfo index:(NSIndexPath *)index;
- (id)initWithCardId:(NSString *)cardId;

@end
