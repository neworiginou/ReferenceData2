//
//  HWInviteCustomRecordDetailView.h
//  Community
//
//  Created by niedi on 15/6/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWInviteCustomRecordModel.h"

@protocol HWInviteCustomRecordDetailViewDelegate <NSObject>

- (void)showRightNavBtnWithCardId:(NSString *)cardId;

- (void)reExtendWithModel:(HWInviteCustomRecordModel *)model;

@end



@interface HWInviteCustomRecordDetailView : HWBaseRefreshView

@property (nonatomic, weak) id<HWInviteCustomRecordDetailViewDelegate> delegate;
@property (nonatomic, weak) UIViewController *fatherVC;

- (instancetype)initWithFrame:(CGRect)frame withModel:(HWInviteCustomRecordModel *)model;


@end
