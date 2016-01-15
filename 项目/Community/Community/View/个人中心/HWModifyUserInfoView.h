//
//  HWModifyUserInfoView.h
//  Community
//
//  Created by caijingpeng.haowu on 15/1/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWPersonInfoHeadView.h"
@class HWModifyUserInfoView;
@protocol HWModifyUserInfoViewDelegate <NSObject>

- (void)userInfoViewEditHeadPhoto;
- (void)didSelectLogout;
- (void)didSelectChangeNickname;
- (void)didSelectChangeGender;
- (void)didSelectChangeFavorate;
- (void)didSelectBindWeixin:(HWModifyUserInfoView *)modifyUserInfoView isBindTel:(BOOL)isBindTel;
- (void)didSelectBindMobile;
- (void)didSelectAuthenticate:(NSString *)type isWuYeAuth:(BOOL)isWuYeAuth;
@end

@interface HWModifyUserInfoView : HWBaseRefreshView<HWPersonInfoHeadViewDelegate>
{
    HWPersonInfoHeadView *personInfoView;
}

@property (nonatomic, strong) id<HWModifyUserInfoViewDelegate> delegate;

- (void)refreshUserInfo;

@end
