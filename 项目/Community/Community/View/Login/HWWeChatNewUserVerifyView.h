//
//  HWWeChatNewUserVerifyView.h
//  Community
//
//  Created by caijingpeng.haowu on 15/1/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"

@protocol HWWeChatNewUserVerifyViewDelegate <NSObject>

@optional

// 发送 按钮 回调
- (void)didConfirmVerifyCode;

// 发送短信回调
- (void)didSendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients;

@end

@interface HWWeChatNewUserVerifyView : HWBaseRefreshView <UITextFieldDelegate>
{
    HWTextField *_codeTF;
    UIButton *_confirmBtn;
}

@property (nonatomic, strong) HWWeChatAccountModel *weChatAccount;
@property (nonatomic, strong) NSString *telephoneStr;
@property (nonatomic, strong) NSString *shangxingMessagePhone;
@property (nonatomic, assign) id<HWWeChatNewUserVerifyViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame telephoneNum:(NSString *)telNum;

@end
