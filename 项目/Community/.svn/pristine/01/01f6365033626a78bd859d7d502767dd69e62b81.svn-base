//
//  ALBBOpenAccountPluginServiceProtocol.h
//  ALBBOpenAccountPluginAdapter
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 14/11/26.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ALBBOpenAccount/ALBBOpenAccountSDK.h>


#pragma -mark SDK 回调Code定义

typedef enum{
    /** 用户取消了登录 */
    OPENACCOUNT_LOGIN_CANCELLED=10000,
} ALBBOpenAccountCode;

@protocol ALBBOpenAccountUIService <NSObject>
- (void)showLoginWithConfiguration:(void (^)(UINavigationBar *navigationBar, BOOL *hidesBar))configuration
                           success:(ALBBOpenAccountSuccessCallback)success
                           failure:(ALBBOpenAccountFailedCallback)failure;

- (void)showLoginInNavigationController:(UINavigationController *)navigationController
                                success:(ALBBOpenAccountSuccessCallback)success
                                failure:(ALBBOpenAccountFailedCallback)failure;

- (void)showRegisterInNavigationController:(UINavigationController *)navigationController
                                   success:(ALBBOpenAccountSuccessCallback)success
                                   failure:(ALBBOpenAccountFailedCallback)failure;

- (void)showFindPasswordInNavigationController:(UINavigationController *)navigationController
                                       success:(ALBBOpenAccountSuccessCallback)success
                                       failure:(ALBBOpenAccountFailedCallback)failure;
@end
