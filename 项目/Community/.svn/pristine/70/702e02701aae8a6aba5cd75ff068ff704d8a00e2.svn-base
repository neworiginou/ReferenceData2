//
//  HWPublicRepairImgView.m
//  Community
//
//  Created by niedi on 15/6/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWPublicRepairImgView.h"
#import "WXImageView.h"
#import "HWPublicRepairScroView.h"

@interface HWPublicRepairImgView ()<HWPublicRepairScroViewDelegate, UIScrollViewDelegate>
{
    NSArray *_imgUrlArr;
    NSMutableArray *_imgVArr;
    NSMutableArray *_usedImgVArr;
    CGFloat kWidth;
    CGFloat kHeight;
    CGFloat subWidth;
    CGFloat subHeight;
    CGFloat gap;
    
    UIScrollView *_showScroView;
    UIPageControl *_pageCtr;
    UIView *_superV;
}
@end

@implementation HWPublicRepairImgView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        kWidth = 235.0f * kScreenRate;
        kHeight = 155.0f * kScreenRate;
        subWidth = 75.0f * kScreenRate;
        subHeight = 75.0f * kScreenRate;
        gap = 5.0f * kScreenRate;
        [self initSubImg];
        self.clipsToBounds = YES;
        _usedImgVArr = [NSMutableArray array];
    }
    return self;
}

- (void)initSubImg
{
    _imgVArr = [NSMutableArray array];
    for (int i = 0; i < 6; i++)
    {
        WXImageView *img = [[WXImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.hidden = YES;
        [_imgVArr addObject:img];
        img.clipsToBounds = YES;
        [self addSubview:img];
    }
}

- (void)setImgUrlArr:(NSArray *)imgUrlArr superView:(UIView *)superV
{
    [_usedImgVArr removeAllObjects];
    _superV = superV;
    
    if (imgUrlArr != _imgUrlArr)
    {
        _imgUrlArr = imgUrlArr;
    }
    
    [self showOrHideSubImg:_imgUrlArr.count];
    
    if (_imgUrlArr.count > 0)
    {
        if (_imgUrlArr.count == 2 || _imgUrlArr.count == 3)
        {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, subHeight + 20);
        }
        else if (_imgUrlArr.count == 0)
        {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 15);
        }
        else
        {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, kHeight + 20);
        }
        [self loadUI];
    }
}

- (void)loadUI
{
    if (_imgUrlArr.count == 1)
    {
        WXImageView *img = [_imgVArr pObjectAtIndex:0];
        img.frame = CGRectMake(0, 10, kWidth, kHeight);
        
        __block WXImageView *weakimg = img;
        
        [weakimg setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:[_imgUrlArr pObjectAtIndex:0]]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (error == nil)
            {
                img.image = image;
            }
            else
            {
                img.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
            }
        }];
        
        img.touchBlock = ^{
            [self performSelector:@selector(showImgScrollAnimation:) withObject:weakimg];
        };
        [_usedImgVArr addObject:img];
    }
    else if (_imgUrlArr.count == 2 || _imgUrlArr.count == 4)
    {
        for (int i = 0; i < _imgUrlArr.count; i++)
        {
            WXImageView *img = [_imgVArr pObjectAtIndex:i];
            img.frame = CGRectMake((subWidth + gap) * (i % 2), 10 + (subHeight + gap) * (i / 2), subWidth, subHeight);
            
            __block WXImageView *weakimg = img;
            
            [weakimg setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:[_imgUrlArr pObjectAtIndex:i]]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                if (error == nil)
                {
                    img.image = image;
                }
                else
                {
                    img.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
                }
            }];
            
            img.touchBlock = ^{
                [self performSelector:@selector(showImgScrollAnimation:) withObject:weakimg];
            };
            [_usedImgVArr addObject:img];
        }
    }
    else
    {
        for (int i = 0; i < _imgUrlArr.count; i++)
        {
            WXImageView *img = [_imgVArr pObjectAtIndex:i];
            img.frame = CGRectMake((subWidth + gap) * (i % 3), 10 + (subHeight + gap) * (i / 3), subWidth, subHeight);
            
            __block WXImageView *weakimg = img;
            
            [weakimg setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:[_imgUrlArr pObjectAtIndex:i]]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                if (error == nil)
                {
                    img.image = image;
                }
                else
                {
                    img.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
                }
            }];
            
            img.touchBlock = ^{
                [self performSelector:@selector(showImgScrollAnimation:) withObject:weakimg];
            };
            [_usedImgVArr addObject:img];
        }
    }
}

- (void)showOrHideSubImg:(NSInteger)startIndex
{
    for (int i = 0; i < startIndex; i++)
    {
        WXImageView *img = [_imgVArr pObjectAtIndex:i];
        img.hidden = NO;
    }
    
    for (int i = (int)startIndex; i < _imgVArr.count; i++)
    {
        WXImageView *img = [_imgVArr pObjectAtIndex:i];
        img.hidden = YES;
    }
}

- (void)showImgScrollAnimation:(WXImageView *)img
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    if (_showScroView)
    {
        for (UIView *subView in _showScroView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    else
    {
        _showScroView = [[UIScrollView alloc] initWithFrame:window.bounds];
        _showScroView.pagingEnabled = YES;
        _showScroView.delegate = self;
        _showScroView.backgroundColor = [UIColor clearColor];
        
        _pageCtr = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CONTENT_HEIGHT + 20, kScreenWidth, 20.0f)];
        _pageCtr.hidesForSinglePage = YES;
        _pageCtr.pageIndicatorTintColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
        _pageCtr.currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    
     NSInteger index = [_usedImgVArr indexOfObject:img];
    
    _showScroView.contentSize = CGSizeMake(kScreenWidth * _usedImgVArr.count, kScreecHeight);
    _showScroView.contentOffset = CGPointMake(index * kScreenWidth, _showScroView.frame.origin.y);
    [window addSubview:_showScroView];
    
    _pageCtr.numberOfPages = _usedImgVArr.count;
    _pageCtr.currentPage = index;
    _pageCtr.alpha = 0.0f;
    [window addSubview:_pageCtr];
    
    for (int i = 0; i < _usedImgVArr.count; i++)
    {
        HWPublicRepairScroView *tmpScroView = [[HWPublicRepairScroView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreecHeight)];
        WXImageView *tmpImg = [_usedImgVArr pObjectAtIndex:i];
        CGRect inSuperViewRect = [self convertRect:tmpImg.frame toView:_superV];
        inSuperViewRect.origin.y += 64.0f;
        [tmpScroView setContentWithFrame:inSuperViewRect];
        [tmpScroView setImage:tmpImg.image];
        tmpScroView.i_delegate = self;
        [_showScroView addSubview:tmpScroView];
        
        if (i != index)
        {
            [tmpScroView setAnimationRect];
        }
        else
        {
            [self performSelector:@selector(startAnimation:) withObject:tmpScroView afterDelay:0.1];
        }
    }
    
}

- (void)startAnimation:(HWPublicRepairScroView *)scrollow
{
    [UIView animateWithDuration:0.2 animations:^{
        _pageCtr.alpha = 1.0f;
        _showScroView.backgroundColor = [UIColor blackColor];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.6 animations:^{
        [scrollow setAnimationRect];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - HWPublicRepairScroViewDelegate
- (void)tapImageViewTappedWithObject:(id)sender
{
    HWPublicRepairScroView *tmpImgView = sender;
    
    [UIView animateWithDuration:0.2 animations:^{
        _pageCtr.alpha = 0.0f;
        _showScroView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        [tmpImgView recoverRect];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            [tmpImgView rechangeInitRdct];
        } completion:^(BOOL finished) {
            [_showScroView removeFromSuperview];
        }];
    }];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageCtr.currentPage = scrollView.contentOffset.x / kScreenWidth;
}

@end
