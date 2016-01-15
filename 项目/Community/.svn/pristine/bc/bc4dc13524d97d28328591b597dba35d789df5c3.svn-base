//
//  HWWeChatOldUserBindView.h
//  Community
//
//  Created by caijingpeng.haowu on 15/1/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"

@protocol HWWeChatOldUserBindViewDelegate <NSObject>

@optional
- (void)didGetUserInfoByAccount:(NSString *)account password:(NSString *)pwd;
- (void)didBindMobileSuccess;
- (void)didPopRootVC;
//没有注册考拉账号
- (void)didNotRegister:(NSString *)telNumber;
@end

@interface HWWeChatOldUserBindView : HWBaseRefreshView <UITextFieldDelegate>
{
//    HWTextField *_telephoneTF;
    HWTextField *_pwdTF;
}

@property (nonatomic, strong)HWWeChatAccountModel *weChatAccount;
@property (nonatomic, assign)id<HWWeChatOldUserBindViewDelegate> delegate;
@property (nonatomic, strong) NSString * telNumber;
@property (nonatomic, assign)BOOL isGuest;
@end
