//
//  HWLeadPageScroll.m
//  引导页动画一
//
//  Created by lizhongqiang on 15/7/22.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "HWLeadPageScroll.h"
#import "HWAnimationPageOne.h"
#import "HWAnimationPageTwo.h"
#import "HWAnimationPageThree.h"
#define kScaleHeight ([UIScreen mainScreen].bounds.size.height/667.f)
@interface HWLeadPageScroll ()<UIScrollViewDelegate>
@property (nonatomic, strong)HWAnimationPageOne *pageOne;
@property (nonatomic, strong)HWAnimationPageTwo *pageTwo;
@property (nonatomic, strong)HWAnimationPageThree *pageThree;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIPageControl *pageCtrl;
@end
@implementation HWLeadPageScroll

- (instancetype)init
{
    if(self = [super init])
    {
        self.frame = [UIScreen mainScreen].bounds;
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:_scrollView];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _pageOne = [[HWAnimationPageOne alloc]init];
        _pageOne.frame = _scrollView.bounds;
        
        _pageTwo = [[HWAnimationPageTwo alloc]init];
        _pageTwo.frame = CGRectMake(_pageOne.frame.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
        
        _pageThree = [[HWAnimationPageThree alloc]init];
        _pageThree.frame = CGRectMake(CGRectGetMaxX(_pageTwo.frame), 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
        
        
        _scrollView.contentSize = CGSizeMake(3*_scrollView.bounds.size.width, 0);
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        [_scrollView addSubview:_pageOne];
        [_scrollView addSubview:_pageTwo];
        [_scrollView addSubview:_pageThree];
        [_pageOne startAnimation];
        
        
        _pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-47*kScaleHeight, [UIScreen mainScreen].bounds.size.width, 30*kScaleHeight)];
        [self addSubview:_pageCtrl];
        _pageCtrl.numberOfPages = 3;
        _pageCtrl.currentPageIndicatorTintColor = [UIColor colorWithRed:251/255.f green:183/255.f blue:82/255.f alpha:1.f];
        _pageCtrl.pageIndicatorTintColor = [UIColor colorWithRed:252/255.f green:228/255.f blue:195/255.f alpha:1.0];
        
    }
    return self;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat scale = scrollView.contentOffset.x/scrollView.bounds.size.width;
//    if(scale<1)
//    {
//        _pageOne.alpha = 1- (scrollView.contentOffset.x/scrollView.bounds.size.width);
//    }
//    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat scale = scrollView.contentOffset.x/scrollView.bounds.size.width;
    
    _pageCtrl.currentPage = scale;
    if(scale>=1&&scale<2)
    {
        _pageCtrl.currentPageIndicatorTintColor = [UIColor colorWithRed:245/255.f green:103/255.f blue:99/255.f alpha:1.f];
        _pageCtrl.pageIndicatorTintColor = [UIColor colorWithRed:252/255.f green:204/255.f blue:204/255.f alpha:1.0];
    }
    if(scale >= 2)
    {
        _pageCtrl.currentPageIndicatorTintColor = [UIColor colorWithRed:95/255.f green:184/255.f blue:247/255.f alpha:1.f];
        _pageCtrl.pageIndicatorTintColor = [UIColor colorWithRed:196/255.f green:228/255.f blue:252/255.f alpha:1.0];
    }
    
    if(scale>=1&&scale<2&&!_pageTwo.isAnimating)
    {
        [_pageTwo startAnimation];
    }
    if(scale>=2&&!_pageThree.isAnimating)
    {
        [_pageThree startAnimation];
    }
    if(scale <1 && !_pageOne.isAnimating)
    {
        [_pageOne startAnimation];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
   
}
@end
