//
//  HWPerformSelectorView.m
//  Partner-Swift
//
//  Created by gusheng on 15/2/20.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWPerformSelectorView.h"

@implementation HWPerformSelectorView

- (void)execMessage:(SEL)aSel withObject:(id)param afterDelay:(NSTimeInterval)interval
{
    if(aSel != nil && [self respondsToSelector:aSel])
    {
        if(interval > 0.0)
            [self performSelector:aSel withObject: param afterDelay:interval];
        else
            [self performSelector:aSel withObject: param];
    }
}

@end
