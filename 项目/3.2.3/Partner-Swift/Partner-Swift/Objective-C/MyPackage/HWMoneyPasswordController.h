//
//  HWMoneyPasswordController.h
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-7-4.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseViewControllerOC.h"
#import "Define-OC.h"

typedef enum{
    
    Modify_First_OldPassword = 0,
    Modify_Second_NewPassword,
    Modify_Third_NewPassword,
    Forgot_First_NewPassword,
    Forgot_Second_NewPassword,
    Confirm_Password
    
}PasswordModel;

typedef enum{
    
    Setting_Password = 1,
    SettingConfirm_Password = 2

}InfoMode;

@interface HWMoneyPasswordController : HWBaseViewControllerOC<UITextViewDelegate,UIAlertViewDelegate>

@property (nonatomic, assign) PasswordModel pwdModel; // 此页面包含修改密码，忘记密码，验证密码功能，用该变量区分功能
@property (nonatomic, strong) NSString *moneyNewPwd;
@property (nonatomic, strong) NSMutableDictionary *tiYongInfoDic;
@property (nonatomic, strong) NSDictionary *bankInfo;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *totalMoney;
@property (nonatomic, assign) LogicLine logic;
@property (nonatomic, strong) UIViewController * popToViewController;
@property (nonatomic, strong) NSMutableDictionary *unBindCardInfo;
@property (nonatomic, assign) InfoMode tishiMode;

@end
