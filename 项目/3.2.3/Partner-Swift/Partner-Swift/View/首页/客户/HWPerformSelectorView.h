//
//  HWPerformSelectorView.h
//  Partner-Swift
//
//  Created by gusheng on 15/2/20.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWPerformSelectorView : UIView
- (void)execMessage:(SEL)aSel withObject:(id)param afterDelay:(NSTimeInterval)interval;
@end
