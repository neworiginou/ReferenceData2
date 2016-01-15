//
//  AnimationView.h
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/8.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLayer.h"

@interface AnimationView : UIView

@property (nonatomic, assign)BOOL animationStart;
- (void)refreshAnimationView:(CGFloat)contentOffY;
- (void)startAnimations;
@end
