//
//  FLAdView.m
//  ImageTest
//
//  Created by apple on 15/5/5.
//  Copyright (c) 2015年 fengling2300. All rights reserved.
//

#import "FLAdView.h"


@implementation FLAdView{
    FLScrollView *flScroll;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        flScroll = [[FLScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        flScroll.imgDelegate = self;
        [self addSubview:flScroll];
        [self addSubview:flScroll.pageControl];
    }
    return self;
}

- (void)willMoveToWindow:(UIWindow *)newWindow{
    [self resetImage];
}

-(void)setImageArray:(NSArray *)imageArray{
    flScroll.imageArray = imageArray;
    _imageArray = imageArray;
}

-(void)setChageTime:(NSTimeInterval)chageTime{
    flScroll.chageTime = chageTime;
    _chageTime = chageTime;
}

-(void)setCurrentPageColor:(UIColor *)currentPageColor{
    flScroll.pageControl.currentPageIndicatorTintColor = currentPageColor;
    _currentPageColor = currentPageColor;
}

-(void)setNormalColor:(UIColor *)normalColor{
    flScroll.pageControl.pageIndicatorTintColor = normalColor;
    _normalColor = normalColor;
}

-(void)setLocation:(PageControlLocation)location{
    flScroll.location = location;
    _location = location;
}

-(void)resetImage{
    [flScroll setContentOffset:CGPointMake(self.frame.size.width, 0)];
    flScroll.pageControl.currentPage = 0;
}

-(void)scrollImageTaped:(UIImageView *)imageView{
    [self.flDelegate imageTaped:imageView];
}

@end
