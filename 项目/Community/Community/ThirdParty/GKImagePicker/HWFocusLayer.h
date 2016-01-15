//
//  HWFocusLayer.h
//  camera
//
//  Created by caijingpeng.haowu on 14-9-3.
//  Copyright (c) 2014年 caijingpeng.haowu. All rights reserved.
//
//  焦点view

#import <QuartzCore/QuartzCore.h>

@interface HWFocusLayer : CALayer
{
    CALayer *_bigCircle;
    CALayer *_smallCircle;
}

- (void)startAnimate;

@end
