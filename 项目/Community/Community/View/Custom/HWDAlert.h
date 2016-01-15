//
//  HWDAlert.h
//  HWCustomAlertView
//
//  Created by D on 14/12/15.
//  Copyright (c) 2014年 D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"

@class HWDAlert;

@protocol HWDAlertDelegate <NSObject>

@optional

- (void)alertView:(HWDAlert *)alertView secretStr:(NSString *)secret;

@end

@interface HWDAlert : UIView<UITextViewDelegate>

@property(nonatomic, copy)void(^returanPayPassward)(NSString *passwardStr);

@property (nonatomic, strong) UIView * handleView;
@property (nonatomic, readwrite) double money;
@property (nonatomic, strong) NSString * secretStr;
@property (nonatomic, readwrite) BOOL isSingleCustomView;
@property (nonatomic, readwrite) BOOL isShowing;
@property (nonatomic, weak) id<HWDAlertDelegate> delegate;


- (instancetype)initWithOtherViewHight:(CGFloat)height;
- (void)loadUI;
- (void)btnClick:(UIButton *)button;

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
+ (CGSize)calculateStringHeight:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize;


- (void)show;
@end
