//
//  UITableViewCell(FixUITableViewCellAutolayoutIHope).m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-19.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "UITableViewCell+FixUITableViewCellAutolayoutIHope.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UITableViewCell (FixUITableViewCellAutolayoutIHope)

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

@end
