//
//  MyLayer.h
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/9.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
typedef enum {
    Top,
    Bottom,
    Left,
    Right
}Type;
@interface MyLayer : CAShapeLayer
@property (nonatomic, assign)int tag;
@property (nonatomic, assign)Type type;
- (void)animationStart;
- (void)animationEnd;
@end
