//
//  HWRegisterSecondViewController.h
//  Community
//
//  Created by caijingpeng.haowu on 14-8-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  校验 验证码
//

#import "HWBaseViewController.h"
#import <MessageUI/MFMessageComposeViewController.h>

@interface HWRegisterSecondViewController : HWBaseViewController<UIAlertViewDelegate, MFMessageComposeViewControllerDelegate, UITextFieldDelegate>
{
    UITextField *codeTF;
}

@property (nonatomic, strong)NSString *telephoneNum;
@property (nonatomic, strong)NSString *shangxingMessagePhone;

@end
