//
//  UITextField(FixAutoLayout).m
//  Partner-Swift
//
//  Created by lizhongqiang on 15/3/17.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "UITextField+FixAutoLayout.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UITextField(FixAutoLayout)

+ (void)load
{
    Method existing = class_getInstanceMethod(self, @selector(layoutSubviews));
    Method new = class_getInstanceMethod(self, @selector(_autolayout_replacementLayoutSubviews));
    
    method_exchangeImplementations(existing, new);
}

- (void)_autolayout_replacementLayoutSubviews
{
    [super layoutSubviews];
    [self _autolayout_replacementLayoutSubviews]; // not recursive due to method swizzling
    [super layoutSubviews];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
