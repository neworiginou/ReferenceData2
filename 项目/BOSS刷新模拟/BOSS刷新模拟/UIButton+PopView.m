//
//  UIButton+PopView.m
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/11.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "UIButton+PopView.h"
#import <objc/runtime.h>

#define CustomButton(direction,mySelector,offSet)\
({UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];\
[btn setBackgroundColor:(direction)?[UIColor whiteColor]:[UIColor colorWithRed:71/255.f green:192/255.f blue:182/255.f alpha:1.0]];\
btn.frame = CGRectMake(offSet, ((direction)?0:(frame.size.height-arrowSize.height)/2)+arrowSize.height, frame.size.width, (frame.size.height-arrowSize.height)/2.0);\
[btn setTitleColor:(!direction)?[UIColor whiteColor]:[UIColor colorWithRed:71/255.f green:192/255.f blue:182/255.f alpha:1.0] forState:UIControlStateNormal];\
btn.titleLabel.font = [UIFont systemFontOfSize:14.1];\
UIRectCorner corners = 0;\
switch (direction) {\
case 1:\
corners=UIRectCornerTopLeft|UIRectCornerTopRight;\
break;\
case 0:\
corners = UIRectCornerBottomLeft|UIRectCornerBottomRight;\
break;\
}\
UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:corners  cornerRadii:CGSizeMake(radius, radius)];\
CAShapeLayer *clipShapelayer = [CAShapeLayer layer];\
clipShapelayer.path = clipPath.CGPath;\
btn.layer.mask = clipShapelayer;\
[btn addTarget:self action:mySelector forControlEvents:UIControlEventTouchUpInside];\
[popView addSubview:btn];\
(btn);})

@implementation UIButton (PopView)

+ (void)setMyFrame:(CGRect)myFrame{
    objc_setAssociatedObject(self, _cmd, [NSValue valueWithCGRect:myFrame], OBJC_ASSOCIATION_ASSIGN);
}
+ (CGRect)myFrame{
    NSValue *value = (NSValue *)objc_getAssociatedObject(self, @selector(setMyFrame:));
    
    return [value CGRectValue];
}
- (BOOL)animated{
    return [objc_getAssociatedObject(self, @selector(setAnimated:)) boolValue];
}
- (void)setAnimated:(BOOL)animated{
    objc_setAssociatedObject(self, _cmd, @(animated), OBJC_ASSOCIATION_ASSIGN);
}
- (UIButton *)downBtn{
    return objc_getAssociatedObject(self, @selector(setDownBtn:));
}
- (void)setDownBtn:(UIButton *)downBtn{
    objc_setAssociatedObject(self, _cmd, downBtn, OBJC_ASSOCIATION_ASSIGN);
}
- (UIButton *)upBtn{
    return objc_getAssociatedObject(self, @selector(setUpBtn:));
}
- (void)setUpBtn:(UIButton *)upBtn{
    objc_setAssociatedObject(self, _cmd, upBtn, OBJC_ASSOCIATION_ASSIGN);
}
- (UIView *)popView{
    
    UIView *view = objc_getAssociatedObject(self, @selector(setPopView:));
  
    return view;
}
- (void)setPopView:(UIView *)popView{
//    popView.autoresizesSubviews = YES;
    popView.layer.masksToBounds = YES;
    objc_setAssociatedObject(self, _cmd, popView, OBJC_ASSOCIATION_RETAIN);
    UIImage *image = nil;
    
    CGFloat offSet = 3;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGRect frame = [self class].myFrame;
    popView.frame = CGRectMake(frame.origin.x-offSet, frame.origin.y-offSet, frame.size.width+2*offSet, frame.size.height+2*offSet);
#if 1
    CGPoint arrowPoint = CGPointMake(CGRectGetWidth(frame)/2,0);//
    CGSize arrowSize = CGSizeMake(13, 8);
    CGFloat radius = 7;
    
    UIGraphicsBeginImageContext(frame.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, 0, frame.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0,1};//--colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0
    NSArray *colors = @[(__bridge id)[UIColor whiteColor].CGColor,(__bridge id)[UIColor colorWithRed:234/255.f green:234/255.f blue:234/255.f alpha:1.0].CGColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, locations);
    CGColorSpaceRelease(colorSpace);
    
    CGContextSaveGState(ctx);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:arrowPoint];
    [path addLineToPoint:CGPointMake(arrowPoint.x-arrowSize.width/2, arrowPoint.y+arrowSize.height)];
    
    
    CGPoint center1 = CGPointMake(radius, 0+arrowSize.height+radius);
    [path addLineToPoint:CGPointMake(center1.x, center1.y-radius)];
    [path addArcWithCenter:center1 radius:radius startAngle:M_PI*3/2.0 endAngle:M_PI clockwise:NO];
//    [path addLineToPoint:CGPointMake(center1.x-radius, center1.y)];
    
    CGPoint center2 = CGPointMake(20*offSet+radius, CGRectGetHeight(frame)-radius);
    [path addLineToPoint:CGPointMake(center2.x-radius,center2.y)];
    [path addArcWithCenter:center2 radius:radius startAngle:M_PI endAngle:M_PI/2.0 clockwise:NO];
    
    
    CGPoint center3 = CGPointMake(CGRectGetWidth(frame)-radius, CGRectGetHeight(frame)-radius);
    [path addLineToPoint:CGPointMake(center3.x, center3.y+radius)];
    
    [path addArcWithCenter:center3 radius:radius startAngle:M_PI/2 endAngle:0 clockwise:NO];
    
    
    CGPoint center4 = CGPointMake(CGRectGetWidth(frame)-radius,0+arrowSize.height+radius);
    [path addLineToPoint:CGPointMake(center4.x+radius,center4.y)];
    [path addArcWithCenter:center4 radius:radius startAngle:0 endAngle:M_PI*3/2.0 clockwise:NO];
    
    [path addLineToPoint:CGPointMake(arrowPoint.x+arrowSize.width/2, arrowSize.height+arrowPoint.y)];
    [path addLineToPoint:arrowPoint];
    
    [[UIColor whiteColor]setFill];
    [path fill];
    shapeLayer.path = path.CGPath;
    CGContextRestoreGState(ctx);
    
    //CGContextDrawLinearGradient(ctx, gradient, CGPointMake(10, 40), CGPointMake(10, 40.49), 0);
    CGGradientRelease(gradient);
    
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //popLayer.backgroundColor = [UIColor yellowColor].CGColor;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    [popView.layer addSublayer:shapeLayer];
    //popView.layer.backgroundColor = [UIColor colorWithPatternImage:image].CGColor;
#endif
    //popLayer.mask = shapeLayer;---注意:如果想下面的阴影设置成功，则需要不修剪layer层，这是因为阴影是超出layer的frame的，而mask或者maskToBounds会修剪掉超出layer-frame以外的
    shapeLayer.shadowRadius = 1.0;
    shapeLayer.shadowOpacity = 0.5;
    shapeLayer.shadowOffset = CGSizeMake(0, 0);
    shapeLayer.shadowColor = [UIColor grayColor].CGColor;//UIViewAutoresizingNone
    
   
    [[UIApplication sharedApplication].keyWindow addSubview:popView];

    
    UIButton *down = CustomButton(0, @selector(downBtnAction),0);
    
    UIButton *up = CustomButton(1, @selector(upBtnAction),0);
    
    [up setTitle:@"iOS" forState:UIControlStateNormal];
    
    [down setTitle:@"管理求职意向" forState:UIControlStateNormal];
    
    popView.transform = CGAffineTransformMakeScale(0.0, 0.0);

//    
//    down.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
//    up.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.downBtn =down;
    self.upBtn = up;
}
- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
  
    if(selected){
        [self show];
    }else{
        [self dismiss];
    }
    
}
- (void)show{
    
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.popView.transform = CGAffineTransformIdentity;
        CGRect frame = self.popView.frame;
        frame.size.height = 90;//UIButton.myFrame.size.height;
        self.popView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)dismiss{
    
   
    [UIView animateWithDuration:0.5 animations:^{
                 CGRect frame = self.popView.frame;
                frame.size.height = 0;
                self.popView.frame = frame;
        self.popView.transform = CGAffineTransformMakeScale(0.00000001, 0.00000001);

    }];
   
}
- (void)downBtnAction{
    NSLog(@"%s",__func__);
}
- (void)upBtnAction{
    
}
@end
