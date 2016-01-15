//
//  HWNewUserBindViewController.h
//  Community
//
//  Created by caijingpeng.haowu on 15/1/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HWWeChatBindTelephoneView.h"
@interface HWNewUserBindViewController : HWBaseViewController

@property (nonatomic, strong)HWWeChatAccountModel *weChatAccount;
@property (nonatomic, strong)UIViewController *bindPopViewController;
@property (nonatomic, strong)NSString *telephoneNum;
@property (nonatomic, assign)BOOL isBind;
@property (nonatomic, assign)BOOL isGuest;

@end
