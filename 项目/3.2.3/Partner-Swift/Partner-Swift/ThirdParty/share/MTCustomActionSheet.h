//
//  MTCustomActionSheet.h
//  etonkids-iphone
//
//  Created by CaiJingPeng on 13-8-6.
//  Copyright (c) 2013年 wpf. All rights reserved.
//

/**
 *	@file   MTCustomActionSheet
 *  @brief  自定义action sheet
 *  @author
 *  @version 2.2
 *  @date   2013-09-03
 */

#import <UIKit/UIKit.h>
#import "SRMonthPicker.h"

@class MTCustomActionSheet;

@protocol MTCustomActionSheetDelegate <NSObject>

@optional
- (void)actionSheet:(MTCustomActionSheet *)actionSheet didClickButtonByIndex:(int)index;
- (void)actionSheet:(MTCustomActionSheet *)actionSheet didClickButtonByIndex:(int)index selectDate:(NSDate *)date;
- (void)actionSheet:(MTCustomActionSheet *)actionSheet didClickButtonByIndex:(int)index selectMonthDate:(NSDate *)date;
@end

@interface MTCustomActionSheet : UIView
{
    UIView *mainView;
    UIButton *cancelBtn;
    NSInteger count;
    UIDatePicker *datepicker;
    SRMonthPicker *monthDatePicker;
}

@property (nonatomic, strong) id<MTCustomActionSheetDelegate> delegate;

@property (nonatomic, retain) NSMutableArray *buttons;
@property (nonatomic, retain) UIDatePicker *datepicker;


/**
 *	@brief  初始化action sheet.
 *
 *	@param 	frame 	view 大小.
 *	@param 	imgArr 	图片列表.
 *	@param 	nameArr 	名字列表.
 *	@param 	orientation 	旋转方向.
 *
 *	@return	返回实例.
 */
//- (id)initWithFrame:(CGRect)frame andImageArray:(NSArray *)imgArr nameArray:(NSArray *)nameArr orientation:(UIInterfaceOrientation)orientation;
- (id)initWithFrame:(CGRect)frame picturesArray:(NSArray *)imgArr titleArray:(NSArray *)nameArr orientation:(UIInterfaceOrientation)orientation;

- (id)initWithFrame:(CGRect)frame andImageArr:(NSArray *)imgArr nameArray:(NSArray *)nameArr orientation:(UIInterfaceOrientation)orientation;


- (id)initWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

-(id)initWithSRMonthPicker:(NSDate *)date;

- (id)initWithDatePicker:(NSDate *)date;

/**
 *	@brief  指定显示在某个view上.
 *
 *	@param 	view 	显示的view.
 */
- (void)showInView:(UIView *)view;


- (void)doCancel:(id)sender;
/**
 *	@brief  刷新实例显示方向.
 *
 *	@param 	orientation 	显示的方向.
 */
- (void)reloadFrame:(UIInterfaceOrientation)orientation;


@end
