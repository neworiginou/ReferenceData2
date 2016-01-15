//
//  HWShareView.h
//  Community
//
//  Created by WeiYuanlin on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWShareViewDelegate <NSObject>

@optional
/**
 *	@brief	该代理fenxiauan方法是在点击分享的按钮时候，隐藏-邀请朋友页面的父View
 *
 *	@return	N/A
 */
- (void)removeSuperView;

@end

/**
 *	@brief	枚举出三种分享的来源
 */
typedef enum {
    gameOneClickSpread = 0,//游戏一键推广分享
    gameSingleGameSpread,//游戏单个分享
    inviteFriend,//邀请好友分享
    tianTianTuan,//天天团分享商品
}ShareSource;

@interface HWShareView : UIView<UMSocialUIDelegate>

@property (nonatomic, strong) NSString *gameId;
@property (nonatomic, strong) NSString *shareTitle;
@property (nonatomic, strong) NSString *shareContent;
@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, strong) NSString *copiesUrl;//复制url链接的
@property (nonatomic, strong) NSString *shareUrl;//分享的链接
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) UIViewController *presentController;
@property (nonatomic, readwrite) ShareSource shareSource;     //区分分享来源    埋点用 niedi


@property (nonatomic, assign) id <HWShareViewDelegate>delegate;
- (id)initWithShareTitile:(NSString *)title content:(NSString *)content image:(UIImage *)image shareUrl:(NSString *)urlStr;

- (void)showInView:(UIView *)view presentController:(UIViewController *)controller;


@end
