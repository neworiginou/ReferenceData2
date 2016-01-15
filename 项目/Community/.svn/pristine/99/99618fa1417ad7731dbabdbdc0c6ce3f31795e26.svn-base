//
//  HWCutPriceView.h
//  Community
//
//  Created by lizhongqiang on 15/4/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWProductDetailModel.h"
#import "HWBargainButton.h"
#import "HWJoinedActivityModel.h"

@protocol HWCutPriceViewDelegate <NSObject>

- (void)backClick;
- (void)shareUrl:(NSString *)strUrl shareImage:(UIImage *)image ShareContent:(NSString *)strContent;
- (void)pushViewControllerWithDelegate:(UIViewController *)vc;
- (void)toBindMobile;
- (void)popToDetailViewController;
- (void)popToDetailViewControllerWithFefresh;
@end




@interface HWCutPriceView : HWBaseRefreshView<UITextFieldDelegate,HWBargainButtonDelegate,UIAlertViewDelegate>
{
    HWProductDetailModel *detailModel;
    UITextField *txtField;
    UILabel *timeLabel;                         //倒计时时间
    NSString *poundageStr;                      //手续费
    NSTimer *_theTimer;
    long _theTime;
    
    UIImageView *_imageTop;
    UIButton *_btnShare;
    HWBargainButton *btnCut;
    UIView *emptyView;
    HWJoinedActivityModel *activityModel;
    UIImageView *_smallImageTop;
}

@property (nonatomic, strong) UIButton *btnShare;
@property (nonatomic, strong) id <HWCutPriceViewDelegate> delegate;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic) BOOL *isHistory;
- (id)initWithFrame:(CGRect)frame productId:(NSString *)proId joinActivity:(HWJoinedActivityModel *)joinModel;
- (void)getRemainTimes;
@end
