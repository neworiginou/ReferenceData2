//
//  UIAlertView+Block.h
//  MoreHouse
//
//  Created by caijingpeng.haowu on 14/12/24.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void(^CompleteBlock) (NSInteger buttonIndex);

@interface UIAlertView (Block)

// 用Block的方式回调，这时候会默认用self作为Delegate
- (void)showAlertViewWithCompleteBlock:(CompleteBlock) block;

@end

