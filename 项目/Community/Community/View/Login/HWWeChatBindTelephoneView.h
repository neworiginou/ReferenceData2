//
//  HWWeChatBindTelephoneView.h
//  Community
//
//  Created by caijingpeng.haowu on 15/1/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"

@protocol HWWeChatBindTelephoneViewDelegate <NSObject>

@optional
// 选择跳过绑定手机号 直接选择小区
- (void)didSkipBindSelectVillage;

// 发送手机号成功 跳转发送验证码
- (void)didSendVerifyCodePhone:(NSString *)phoneNum shangxingNum:(NSString *)shangxingNum;
//手机号码已经是考拉用户
- (void)didHaveRegister:(NSString *)telNumber;
@end

@interface HWWeChatBindTelephoneView : HWBaseRefreshView <UITextFieldDelegate>
{
    HWTextField *_telephoneTF;
    UIButton *_skipBtn;
}

@property (nonatomic, strong) HWWeChatAccountModel *weChatAccount;
@property (nonatomic, assign) id<HWWeChatBindTelephoneViewDelegate> delegate;
@property (nonatomic, strong) NSString * telNumber;
@property (nonatomic, assign) BOOL isBind;
@property (nonatomic, assign) BOOL isGuest;
@end
