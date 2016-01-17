//
//  FLScrollView.m
//  ImageTest
//
//  Created by apple on 15-4-23.
//  Copyright (c) 2015年 fengling2300. All rights reserved.
//

#import "FLScrollView.h"
#import "UIImageView+WebCache.h"
#define kOffY (147/2.0)
@implementation FLScrollView{
    CGRect myFrame;
    NSTimer *scrollTimer;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        myFrame              = frame;
        self.pagingEnabled   = YES;
        self.bounces         = NO;
        self.delegate        = self;
        self.backgroundColor = [UIColor redColor];
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, myFrame.origin.y + myFrame.size.height-20, myFrame.size.width, 20)];
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetImage) name:UIApplicationDidBecomeActiveNotification object:nil];
        
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)resetImage{
    [self setContentOffset:CGPointMake(myFrame.size.width, 0)];
    self.pageControl.currentPage = 0;
}

-(void)setChageTime:(NSTimeInterval)chageTime{
    if (scrollTimer) {
        [scrollTimer invalidate];
        scrollTimer = nil;
    }
    scrollTimer = [NSTimer scheduledTimerWithTimeInterval:chageTime target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    _chageTime = chageTime;
}

-(void)changeImage{
    CGPoint contentOffset = self.contentOffset;
    contentOffset.x = contentOffset.x+myFrame.size.width;
    [self setContentOffset:contentOffset animated:YES];
//    CGRect rect = CGRectMake(contentOffset.x, myFrame.origin.y, myFrame.size.width, myFrame.size.height);
//    [self scrollRectToVisible:rect animated:YES];
}

-(void)setImageArray:(NSArray *)imageArray{
    _pageControl.numberOfPages = imageArray.count;
    _pageControl.frame = CGRectMake(0, myFrame.origin.y + myFrame.size.height-kOffY, 20*imageArray.count, 20);
    self.location = _location;
    [self setContentSize:CGSizeMake((imageArray.count+2)*myFrame.size.width, myFrame.size.height)];
    [self setContentOffset:CGPointMake(myFrame.size.width, 0)];
    
    UIImageView *firstImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, myFrame.size.width, myFrame.size.height)];
    firstImage.contentMode = UIViewContentModeScaleToFill;
    [firstImage setImageWithURL:[imageArray firstObject] placeholderImage:nil];
    [self addSubview:firstImage];
    for (int i = 0; i<imageArray.count; i++) {
        TapImageView *tapImage =[[TapImageView alloc]initWithFrame:CGRectMake((i+1)*myFrame.size.width, 0, myFrame.size.width, myFrame.size.height)];
        tapImage.tag = i+10;
        tapImage.delegate = self;
        tapImage.contentMode = UIViewContentModeScaleToFill;
        [tapImage setImageWithURL:imageArray[i] placeholderImage:nil];
        [self addSubview:tapImage];
    }
    UIImageView *lastImage = [[UIImageView alloc]initWithFrame:CGRectMake((imageArray.count+1)*myFrame.size.width, 0, myFrame.size.width, myFrame.size.height)];
    [lastImage setImageWithURL:[imageArray lastObject] placeholderImage:nil];
    lastImage.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:lastImage];
    scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    
    _imageArray = imageArray;
}

-(void)imageViewTaped:(id)sender{
    [self.imgDelegate scrollImageTaped:sender];
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [scrollTimer invalidate];
    scrollTimer = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1{
    scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    if (scrollView1.contentOffset.x == 0) {
        scrollView1.contentOffset = CGPointMake(_imageArray.count*myFrame.size.width, 0);
    }else if(scrollView1.contentOffset.x >= (_imageArray.count+1)*myFrame.size.width){
        scrollView1.contentOffset = CGPointMake(myFrame.size.width, 0);
    }
    _pageControl.currentPage = scrollView1.contentOffset.x/myFrame.size.width-1;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView1{
    if (scrollView1.contentOffset.x == 0) {
        scrollView1.contentOffset = CGPointMake(_imageArray.count*myFrame.size.width, 0);
    }else if(scrollView1.contentOffset.x >= (_imageArray.count+1)*myFrame.size.width){
        scrollView1.contentOffset = CGPointMake(myFrame.size.width, 0);
    }
    _pageControl.currentPage = scrollView1.contentOffset.x/myFrame.size.width-1;
}

-(void)setLocation:(PageControlLocation)location{
    if (location == PageControlCenter) {
        _pageControl.frame = CGRectMake(myFrame.size.width/2-10*_imageArray.count, myFrame.origin.y + myFrame.size.height-kOffY, 20*_imageArray.count, 20);
    }else if(location == PageControlLeft){
        _pageControl.frame = CGRectMake(0, myFrame.origin.y + myFrame.size.height-kOffY, 20*_imageArray.count, 20);
    }else if(location == PageControlRight){
        _pageControl.frame = CGRectMake(myFrame.size.width - 20*_imageArray.count, myFrame.origin.y + myFrame.size.height-kOffY, 20*_imageArray.count, 20);
    }
    _location = location;
}

@end
