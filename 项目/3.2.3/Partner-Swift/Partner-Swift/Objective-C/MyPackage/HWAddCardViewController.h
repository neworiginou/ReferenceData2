//
//  HWAddCardViewController.h
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-24.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWRefreshBaseViewController.h"
#import "Define-OC.h"

@interface HWAddCardViewController : HWRefreshBaseViewController<UITextFieldDelegate>

@property (nonatomic, assign) LogicLine logic;
@property (nonatomic, strong) UIViewController *popToViewController;

@end
