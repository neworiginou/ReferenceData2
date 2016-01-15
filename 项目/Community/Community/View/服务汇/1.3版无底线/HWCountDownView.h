//
//  HWCountDownView.h
//  Community
//
//  Created by niedi on 15/5/7.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

//首页砍价倒计时view :   "222 : 32 : 33"

#import <UIKit/UIKit.h>

@interface HWCountDownView : UIView


+ (instancetype)countDownViewFrame:(CGRect)frame first:(NSString *)str0 second:(NSString *)str1 third:(NSString *)str2; //初始化 长度： 2~3; 2; 2

- (void)setStr:(NSString *)str0 second:(NSString *)str1 third:(NSString *)str2; //设置字符，不需要更改的可传nil



@end

//eg.
/*
 HWCountDownView *countDownView = [HWCountDownView countDownViewFrame:CGRectMake(10, 10, 0, 0) first:@"323" second:@"14" third:@"33"];
 [countDownView setStr:@"32" second:@"43" third:@"42"] //设置字符，传nil不改变字符;
 [tableViewHeaderView addSubview:countDownView];
 */