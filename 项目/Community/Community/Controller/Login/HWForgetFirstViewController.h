//
//  HWForgetViewController.h
//  Community
//
//  Created by caijingpeng.haowu on 14-8-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  忘记密码 校验 验证码
//

#import "HWBaseViewController.h"

@interface HWForgetFirstViewController : HWBaseViewController<UITextFieldDelegate>

@property (nonatomic, strong)NSString *telephoneNum;
@property (nonatomic, assign)BOOL isChangePwd;
@property (nonatomic, strong)UIViewController *popToViewController;

@end
