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
 *  左边按钮
 */
@property (nonatomic,retain)UIButton * leftBtn;
/**
 *  title
 */
@property (nonatomic,retain)UILabel  * titleLabel;
/**
 *  右边按钮
 */
@property (nonatomic,retain)UIButton * rightBtn;
/**
 *  navbar
 */
@property (nonatomic,retain) UIImageView * navImage;

/**
 *  导航栏标题为图片
 */
@property (nonatomic,strong)UIImageView * titleImage;
/**
 *  父视图
 */
@property (nonatomic,retain)UIViewController * fatherController;
/**
 *  loading动画
 */
@property (nonatomic,strong)UIImageView * gifImageView;
/**
 *  提示label
 */
@property (nonatomic,retain)UILabel * reminderLabel;

/**
 *  但前是否有网
 */
@property (nonatomic,assign)BOOL  isNetWork;




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
/**
 *  右边按钮
 */
- (void)rightBtnClick;

@end
