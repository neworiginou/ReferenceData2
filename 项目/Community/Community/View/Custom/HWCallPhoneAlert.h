//
//  CallPhoneAlert.h
//  CallPhoneAlert
//
//  Created by lizhongqiang on 14-8-27.
//  Copyright (c) 2014年 Lizhongqiang. All rights reserved.
//
//  条形 下滑显示 toast 提示框
//

#import <UIKit/UIKit.h>

@interface HWCallPhoneAlert : UIView
{
    UILabel *label;
    UIButton *btnClose;
}

@property(nonatomic,copy)void(^hideAlert)();

- (id)initWithMessage:(NSString *)message closeEnable:(BOOL)close;
- (void)show;

@end