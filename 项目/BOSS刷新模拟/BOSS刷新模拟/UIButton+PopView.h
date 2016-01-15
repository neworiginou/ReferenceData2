//
//  UIButton+PopView.h
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/11.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (PopView)
@property (nonatomic, strong)UIView *popView;
@property (nonatomic, assign)BOOL animated;
@property (nonatomic, strong)UIButton *downBtn;
@property (nonatomic, strong)UIButton *upBtn;
+ (CGRect)myFrame;
+ (void)setMyFrame:(CGRect)myFrame;
- (void)dismiss;
- (void)show;
//- (CAShapeLayer *)popLayer;
@end
