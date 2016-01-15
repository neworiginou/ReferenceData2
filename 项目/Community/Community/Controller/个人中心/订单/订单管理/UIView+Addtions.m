//
//  UIView+Addtions.m
//  weibo1
//
//  Copyright (c) 2014年 yang. All rights reserved.
//

#import "UIView+Addtions.h"

@implementation UIView (Addtions)
- (UIViewController *)viewController{
   
    UIResponder *next = self.nextResponder;
    do{
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController*) next;
        }
        next = next.nextResponder;
    
    }while (next !=nil);
    
    return nil;
}

    
@end
