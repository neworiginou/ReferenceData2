//
//  HWRCustomSiftView.h
//  Community
//
//  Created by hw500029 on 15/1/16.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：自定义弹出筛选
//
//  修改记录
//      李中强 2015-01-21 添加代理
//

#import <UIKit/UIKit.h>

@class HWRCustomSiftView;

@protocol HWRCustomSiftViewDelegate <NSObject>

- (void)siftView:(HWRCustomSiftView *)siftView didSelectedIndex:(NSInteger)index;

@end

@interface HWRCustomSiftView : UIView
{
    UIView *dependView;
}

@property (nonatomic ,strong) UIView *clearView;
@property (nonatomic ,strong) UIView *backView;
@property (nonatomic ,strong) NSArray *titleArr;
@property (nonatomic ,strong) UIImageView *backImageView;
@property (nonatomic, assign) id<HWRCustomSiftViewDelegate> delegate;


/**
 *	@brief	初始化方法 设置 需要的选项   并将所依赖的view传入  选择框会根据传入view相对showView的位置显示在view下方
 *
 *	@param 	titles 	标题
 *	@param 	view 	依赖的view
 *
 *	@return
 */
- (id)initWithTitle:(NSArray *)titles image:(NSArray *)images andDependView:(UIView *)view;

/**
 *	@brief	设置显示的view
 *
 *	@param 	showView
 *
 *	@return
 */
- (void)showInView:(UIView *)showView byOffsetY:(CGFloat)offsetY;

/**
 *	@brief	设置按钮不可用
 *
 *	@param 	index
 *
 *	@return
 */
- (void)setInactiveButtonIndex:(NSInteger)index;

/**
 *	@brief	设置按钮可用
 *
 *	@param 	index
 *
 *	@return
 */
- (void)setActiveButtonIndex:(NSInteger)index;

@end
