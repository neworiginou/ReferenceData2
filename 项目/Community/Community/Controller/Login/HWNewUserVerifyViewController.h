//
//  HWNewUserVerifyViewController.h
//  Community
//
//  Created by caijingpeng.haowu on 15/1/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWRefreshBaseViewController.h"
#import <MessageUI/MFMessageComposeViewController.h>

@interface HWNewUserVerifyViewController : HWRefreshBaseViewController<MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) NSString *telephoneStr;
@property (nonatomic, strong) NSString *shangxingMessagePhone;
@property (nonatomic, strong) HWWeChatAccountModel *weChatAccount;
@property (nonatomic, assign) BOOL isBind;
@property (nonatomic, strong)UIViewController *bindPopViewController;
@property (nonatomic, assign) BOOL isGuest;

@end
