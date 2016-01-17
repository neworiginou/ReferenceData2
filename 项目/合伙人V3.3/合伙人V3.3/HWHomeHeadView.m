//
//  HWHomeHeadView.m
//  合伙人V3.3
//
//  Created by lizhongqiang on 16/1/16.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "HWHomeHeadView.h"
#import "FLAdView.h"
#import "UIButton+CustomPosition.h"
#define kButtonWidth (120/2.0)
#define kButtonNumber (3)
#define FONTNAME                            @"Helvetica Neue"
#define FONT(fontSize)                      [UIFont fontWithName:FONTNAME size:fontSize]
@interface HWHomeHeadView ()<FLAdViewDelegate>
@property (nonatomic, strong)FLAdView *sclView;
@end
@implementation HWHomeHeadView

- (FLAdView *)sclView{
    if(_sclView == nil){
        _sclView = [[FLAdView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 540/2.0)];
        _sclView.imageArray = @[@"http://f.hiphotos.baidu.com/image/pic/item/faedab64034f78f01afda9627a310a55b2191ca8.jpg",@"http://f.hiphotos.baidu.com/image/pic/item/faedab64034f78f01afda9627a310a55b2191ca8.jpg",@"http://f.hiphotos.baidu.com/image/pic/item/faedab64034f78f01afda9627a310a55b2191ca8.jpg"];
        _sclView.location = PageControlCenter;//设置pagecontrol的位置
        _sclView.currentPageColor = [UIColor redColor];//选中pagecontrol的颜色
        _sclView.normalColor = [UIColor yellowColor];//未选中的pagecontol的颜色
        _sclView.chageTime = 3.0f;//定时时间 默认3秒
        _sclView.flDelegate = self;//图片点击事件delegate
        
    }
    return _sclView;
}
- (void)imageTaped:(UIImageView *)imageView{
    self.imageTaped(imageView);
}
- (UIButton *)button:(NSString *)title image:(NSString *)name frame:(CGRect)frame{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = FONT(12.7);
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    btn.frame = frame;
    return btn;
}
-(instancetype)init{
    if(self = [super init]){
        [self addSubview:self.sclView];
        NSLog(@"%f",kButtonNumber*kButtonWidth);
        CGFloat spaceX = ([UIScreen mainScreen].bounds.size.width - kButtonNumber*kButtonWidth)/(kButtonNumber);
        CGRect frame = CGRectMake(spaceX/2, CGRectGetMaxY(self.sclView.frame)+13, kButtonWidth, kButtonWidth+50/2.0);
        [self addSubview:[self button:@"抢客" image:@"phone" frame:frame]];
        
        frame.origin.x = CGRectGetMaxX(frame) + spaceX;
        [self addSubview:[self button:@"动态" image:@"phone" frame:frame]];
        
        frame.origin.x = CGRectGetMaxX(frame) + spaceX;
        [self addSubview:[self button:@"积分抽奖" image:@"phone" frame:frame]];
    }
    return self;
}
@end
