//
//  DCycleBanner.m
//  Community
//
//  Created by niedi on 15/5/4.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "DCycleBanner.h"

@interface DCycleBanner ()<UIScrollViewDelegate>
{
    NSUInteger _bannerTotalImgCount;
    
    float _scroTimerInterval;
    UIScrollView *_scroView;
    UIPageControl *_pageCtr;
    NSTimer *_timer;
    NSMutableArray *_totalImgViewArray;
}

@end

@implementation DCycleBanner

+ (instancetype)cycleBannerWithFrame:(CGRect)frame bannerImgCount:(NSUInteger)bannerImgCount
{
    return [[self alloc] initWithFrame:frame bannerImgCount:bannerImgCount];
}

- (instancetype)initWithFrame:(CGRect)frame bannerImgCount:(NSUInteger)bannerImgCount
{
    if (self = [super initWithFrame:frame])
    {
        _scroTimerInterval = 4.0f;
        _bannerTotalImgCount = bannerImgCount;
        _totalImgViewArray = [[NSMutableArray alloc] init];
    }
    if (bannerImgCount == 0)
    {
        return nil;
    }
    return self;
}

#pragma mark - loadUI
- (void)loadUI
{
    NSUInteger imgCount = _bannerTotalImgCount;
    if (_bannerTotalImgCount > 1)
    {
        imgCount += 2;
    }
    
    _scroView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scroView.showsHorizontalScrollIndicator = NO;
    _scroView.pagingEnabled = YES;
    _scroView.delegate = self;
    _scroView.contentSize = CGSizeMake(CGRectGetWidth(_scroView.frame) * imgCount, 0);
    [self addSubview:_scroView];
    
    CGFloat scrWidth = CGRectGetWidth(_scroView.frame);
    CGFloat scrHeight = CGRectGetHeight(_scroView.frame);
    _pageCtr = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scroView.frame) - 20, scrWidth, 20)];
    _pageCtr.numberOfPages =   _bannerTotalImgCount == 1 ? 0 : _bannerTotalImgCount;
    [self addSubview:_pageCtr];
    
    for (int i = 0; i < imgCount; i++)// 合并了_bannerTotalImgCount==1的情况
    {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(scrWidth * i, 0, scrWidth, scrHeight);
        
        if (self.ImageViewAtIndex)
        {
            if (i == 0)
            {
                self.ImageViewAtIndex(imgView, _bannerTotalImgCount - 1);
            }
            else if (i == _bannerTotalImgCount + 1)
            {
                self.ImageViewAtIndex(imgView, 0);
            }
            else
            {
                self.ImageViewAtIndex(imgView, i - 1);
            }
        }
        
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bannerImgViewClick:)];
        [imgView addGestureRecognizer:tap];
        
        [_totalImgViewArray addObject:imgView];
        [_scroView addSubview:imgView];
    }
}

#pragma mark - 自定义滚动时间间隔
- (void)setScroTimeInterval:(float)interval
{
    _scroTimerInterval = interval;
    if (!_timer)
    {
        [self loadUI];
    }
    else
    {
        [_timer invalidate];
        _timer = nil;
        [self initTimer];
        [self setTimerFire:YES];
    }
}

#pragma mark - Timer
- (void)initTimer
{
    _timer = [[NSTimer alloc] initWithFireDate:[NSDate distantFuture] interval:_scroTimerInterval target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction
{
    [_scroView setContentOffset:CGPointMake(_scroView.contentOffset.x + _scroView.frame.size.width, 0) animated:YES];
}

- (void)setTimerFire:(BOOL)isFire
{
    if (!_timer)
    {
        [self loadUI];
    }
    if (_bannerTotalImgCount > 1)
    {
        if (!_timer)
        {
            [self initTimer];
        }
        if (isFire)
        {
            _timer.fireDate = [NSDate distantPast];
        }
        else
        {
            _timer.fireDate = [NSDate distantFuture];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_bannerTotalImgCount > 1)
    {
        float contentOffsetX = scrollView.contentOffset.x;
        float scroWidth = CGRectGetWidth(scrollView.frame);
        NSUInteger currentPageIndex = 0;
        if (contentOffsetX < scroWidth)  //首位
        {
            currentPageIndex = _bannerTotalImgCount - 1;
        }
        else if (contentOffsetX >= scroWidth * (_bannerTotalImgCount + 1))   //末位
        {
            currentPageIndex = 0;
        }
        else
        {
            currentPageIndex = contentOffsetX / scroWidth - 1;
        }
        _pageCtr.currentPage = currentPageIndex;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _timer.fireDate = [NSDate distantFuture];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self setScrollViewContentOffsetWhenAnimationOrDrugEnded];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self setScrollViewContentOffsetWhenAnimationOrDrugEnded];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self setScrollViewContentOffsetWhenAnimationOrDrugEnded];
}

#pragma mark - 动画或拖拽结束时 更改偏移量
- (void)setScrollViewContentOffsetWhenAnimationOrDrugEnded
{
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:_scroTimerInterval];
    float contentOffsetX = _scroView.contentOffset.x;
    float scroWidth = CGRectGetWidth(_scroView.frame);
    if (contentOffsetX >= scroWidth * (_bannerTotalImgCount + 1)) //末位
    {
        _scroView.contentOffset = CGPointMake(scroWidth, 0);
    }
    else if (contentOffsetX < scroWidth)
    {
        _scroView.contentOffset = CGPointMake(scroWidth * _bannerTotalImgCount, 0);
    }
}

#pragma mark - 图片点击事件
- (void)bannerImgViewClick:(UITapGestureRecognizer *)tap
{
    if (self.imageTapAction)
    {
        UIImageView *imgView = (UIImageView *)tap.view;
        NSUInteger index = [_totalImgViewArray indexOfObject:imgView];
        if (index == 0)// 合并了_bannerTotalImgCount==1的情况
        {
            index = _bannerTotalImgCount - 1;
        }
        else if (index == _bannerTotalImgCount + 1)
        {
            index = 0;
        }
        else
        {
            index = index - 1;
        }
        self.imageTapAction(index);
    }
}


@end
