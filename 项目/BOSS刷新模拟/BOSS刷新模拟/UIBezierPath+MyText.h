//
//  UIBezierPath+MyText.h
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/12.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (MyText)
+(UIBezierPath *)bezierPathWithText:(NSString *)text attributes:(NSDictionary *)attrs;
+ (NSMutableArray *)layers;
+ (void)setLayers:(NSMutableArray *)layers;
+ (CGFloat)number;
+ (void)setNumber:(CGFloat)number;
@end
