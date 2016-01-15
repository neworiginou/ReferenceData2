//
//  MyHeader.m
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/8.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "MyHeader.h"
#import "AnimationView.h"
#define kWidth 27.5
@interface MyHeader ()
@property (nonatomic, strong)AnimationView *animationView;
@end
@implementation MyHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //self.backgroundColor = [UIColor greenColor];
        AnimationView *animationView =[[AnimationView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kWidth)];
        animationView.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds)/2.f, CGRectGetHeight(self.frame)-kWidth/2);
        //animationView.backgroundColor = [UIColor colorWithRed:193/255.f green:199/255.f blue:199/255.f alpha:1.0];
        self.animationView = animationView;
        [self addSubview:animationView];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startAnimations) name:@"startAnimation" object:nil];
    }
    return self;
}

- (void)startAnimations{
    if (self.state == MJRefreshStateRefreshing) {
        self.animationView.animationStart = YES;
        [self.animationView startAnimations];
    }
    
}
- (void)refreshHeaderView:(CGFloat)contentOffY{
    [self.animationView refreshAnimationView:contentOffY];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    
//}


@end
