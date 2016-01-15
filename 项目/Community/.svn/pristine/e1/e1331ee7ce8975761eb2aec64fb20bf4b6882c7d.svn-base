//
//  ETShowBigImageView.h
//  etonkids-iphone
//
//  Created by CaiJingPeng on 13-7-17.
//  Copyright (c) 2013年 wpf. All rights reserved.
//

/**
 *	@file   ETShowBigImageView
 *  @brief  显示大图
 *  @author
 *  @version 2.2
 *  @date   2013-09-03
 */

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "ETZoomScrollView.h"

@class ETShowBigImageView;

@protocol ETShowBigImageViewDelegate <NSObject>


@optional
- (void)didSelectedTencentShareImage:(UIImage *) image;


/**
 *	@brief  点击分享回调方法.
 *
 *	@param 	image 	分享的图片.
 *	@param 	shareType 	分享的类型.
 *	@param 	shareCOn 	分享的内容.
 */
- (void)didSelectedShareImage:(UIImage *)image shareType:(int)shareType content:(NSString *)shareCOn;

//-(void)didSelectedTencentShareImage:(UIImage *)image;

/// 点击返回 回调.
- (void)didClickBackButton;

- (void)didSingleTapImageView:(ETShowBigImageView *)bImgView;

@end


@interface ETShowBigImageView:UIView<UIScrollViewDelegate,UIActionSheetDelegate,ETZoomScrollViewDelegate>
{
    int originShowNum;
    UILabel *item;
    MBProgressHUD *saveHUD;
    
//    WeiboSignIn *_weiboSignIn;
//    TCWBEngine   *weiboEngine;
    UIScrollView *scrollV ;
    CGFloat width;
    UIPageControl *pageCtr;
}

@property (nonatomic, retain) NSArray *imgUrlArr;
@property (nonatomic, retain) UIScrollView *imgSV;
@property (nonatomic,retain)NSString *content;
@property (nonatomic, retain) NSArray *smallImgArr;
@property (nonatomic, retain) NSMutableArray *imgVArr;
@property(nonatomic,retain)UIButton *leftButton;
@property(nonatomic,retain)UIButton *rightButton;
@property(nonatomic, assign) id<ETShowBigImageViewDelegate> delegate;

//- (id)initWithFrame:(CGRect)frame AndShowImageNum:(int)num dataArr:(NSArray *)array;

/**
 *	@brief  初始化显示大图的view
 *
 *	@param 	frame 	view大小.
 *	@param 	num 	当前显示的第几张图片.
 *	@param 	array 	图片数组.
 *	@param 	content 	要分享的内容.
 *
 *	@return	返回实例.
 */
- (id)initWithFrame:(CGRect)frame AndShowImageNum:(int)num dataArr:(NSArray *)array content:(NSString *)content;



/**
 *	@brief  刷新设备方向
 *
 *	@param 	orientation 	设备方向
 */
- (void)reloadFrame:(UIInterfaceOrientation)orientation;


@end
