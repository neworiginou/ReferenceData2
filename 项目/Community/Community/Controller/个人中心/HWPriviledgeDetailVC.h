//
//  HWPriviledgeDetailVC.h
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWPriviledgeDetailModel.h"
#import "HWPriviledgeDetailTableViewCell.h"
#import "HWBaseViewController.h"
#import "MTCustomActionSheet.h"

#define kPriviledgeHeaderHeight         ((130 * kScreenRate) + 156 + 13)
#define kPriviledgeBackgroundHeight     ((130 * kScreenRate) + 115 + 13)
#define kPriviledgeDetailImageV         (130 * kScreenRate)
#define kPriviledgeDetailTop 10
#define kPriviledgeDetailLeft 10

@interface HWPriviledgeDetailVC : HWBaseViewController<UITableViewDataSource,UITableViewDelegate,MTCustomActionSheetDelegate,UIAlertViewDelegate>
{
    UITableView *priviledgeDetailTableV;
    HWPriviledgeDetailModel *priviledgeModel;
    UIView *noActivityTimeTV;
    UIImageView *priviledgeIV;
    UILabel *toLabel;
    NSTimer *timer;//活动倒计时计时器
    int activityNum;//倒计时数目
    HWPriviledgeDetailModel *_priviledgeModel;
    UIView *activityTimeIV;
    UILabel *priviledgeLabel;
    UILabel *brandLabel;
    UILabel *startDateLabel;
    UILabel *endDateLabel;
    UILabel *priviledgeTicketNumLabel;
    UILabel *noPriviledgeTicketNumLabel;
    UIButton *brandBtn;
    NSString *priviledgeId;
    UILabel *shopLabel;
    BOOL shareType;//yes代表有优惠劵no代表无优惠劵
    UIView *headerView;
    
}
@property(nonatomic,strong)UIView *activityTimeIV;
@property(nonatomic,strong)UIView *noActivityTimeTV;
@property(nonatomic,strong)UILabel *hourLabel;
@property(nonatomic,strong)UILabel *minitueLabel;
@property(nonatomic,strong)UILabel *secondLabel;
@property(nonatomic,strong)UILabel *priviledgeTicketNumLabel;
@property(nonatomic,strong)UILabel *noPriviledgeTicketNumLabel;
@property(nonatomic,strong)UILabel *priviledgeLabel;
@property(nonatomic,strong)UILabel *brandLabel;
@property(nonatomic,strong)UILabel *startDateLabel;
@property(nonatomic,strong)UILabel *endDateLabel;
@property(nonatomic,strong)UIButton *shareBtn;
@property(nonatomic,strong)NSString *priviledgeId;
@property(nonatomic,strong)UIImageView *priviledgeIV;
@property(nonatomic,copy)void(^refershPriviledgeData)(NSString *privilledgeId);

@end
