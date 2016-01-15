//
//  HWAnnouncementViewController.h
//  Community
//
//  Created by zhangxun on 14-9-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  邻里圈详情（物业公告）
//
#import "HWRefreshBaseViewController.h"
#import "HWNeighbourItemClass.h"
//#import "HWNeighbourButton.h"
#import "HWNeighbourDetailCell.h"
#import "HWPraiseView.h"
#import "HWCustomSiftView.h"


@interface HWAnnouncementViewController : HWRefreshBaseViewController<UIActionSheetDelegate,HWNeighbourDetailCellDelegate,UITextFieldDelegate,UITextViewDelegate,HWPraiseViewDelegate,SWTableViewCellDelegate,HWCustomSiftViewDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>

{
    UITextView *_commentTF;
    UIView *_commentV;
    UIButton *_commentButton;
    
    UIView *_headerV;
    HWNeighbourItemClass *_cardInfo;
    NSString *_reportId;
    NSString *_reportType;
    
    NSString *_cardId;
    
    BOOL _isPush;
    
    NSIndexPath *_longPressIndex;
    
    UIView *_coverView;
    
    BOOL _isAllowCopy;
    
    UILabel *_commentAtLabel;       //@某人
    NSString *_commentAtStr;        //@人
    NSString *_commentAtId;         //被@人id
    
    HWPraiseView *praise;
    NSString *replyIdDelete;                    //要删除的replyid
    NSString *reportReplyId;                    //要举报的id
    NSString *selectViewRangeStr;               //选择可见范围
    NSIndexPath *currentCellIndexPath;          //当前cell的索引
}

//@property (nonatomic,strong)HWNeighbourButton *leftNeighbourbutton;
//@property (nonatomic,strong)HWNeighbourButton *rightNeighbourButton;
@property (nonatomic,assign)detailResource resourceType;

- (id)initWithCardInfo:(HWNeighbourItemClass *)cardInfo;
- (id)initWithCardId:(NSString *)cardId;

@end
