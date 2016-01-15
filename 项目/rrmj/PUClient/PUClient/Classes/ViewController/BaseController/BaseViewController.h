//
//  BaseViewController.h
//  PUClient
//
//  Created by RRLhy on 15/7/17.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
/**
 *  重写返回反方
 */
- (void)popViewController;
/**
 *  返回到当前视图控制器第一个controller
 */
- (void)popRootViewController;
/**
 *  为登录的情况下，跳转到登录界面
 */
- (void)skipToLoginVc;
/**
 *  请求网络数据
 */
- (void)requestData;

@end
