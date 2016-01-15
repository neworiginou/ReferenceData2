//
//  RelateSeriesStarView.m
//  PUClient
//
//  Created by RRLhy on 15/8/13.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "RelateSeriesStarView.h"
#import "RelateSeriesBottomView.h"
#import "SeriesItem.h"
#import "StarItem.h"
#import "SeriesModel.h"
#import "ActorModel.h"

#define kShareViewHeight ([UIScreen mainScreen].bounds.size.height/2.1)
#define kSpaceX (50)
#define kScale ([UIScreen mainScreen].bounds.size.height/667.0)

@implementation RelateSeriesStarView
{
    UIButton *_cancelBtn;
    RelateSeriesBottomView *_contentView;
    UIView *_cover;
    UIScrollView * _scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame seriesArray:(NSArray*)series starsArray:(NSArray*)star;
{
    if(self = [super initWithFrame:frame])
    {
        self.frame = CGRectMake(0, Main_Screen_Height, Main_Screen_Width, Main_Screen_Height);
        
        if(_cover == nil)
        {
            _cover = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            _cover.backgroundColor = [UIColor blackColor];
            _cover.alpha = 0;
            [_cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenForAnimation)]];
            [self addSubview:_cover];
        }
    
        if (!_contentView) {
            _contentView = [[RelateSeriesBottomView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 230, Main_Screen_Width, 230)];
            [self addSubview:_contentView];
        }
        
        if (!_cancelBtn) {
            
            _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [_cancelBtn setImage:IMAGENAME(@"btn_news_close") forState:UIControlStateNormal];
            
            [_cancelBtn setFrame:CGRectMake(Main_Screen_Width - 50, Main_Screen_Height - 250, 40, 40)];
            
            [_cancelBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
            
            [_cancelBtn addTarget:self action:@selector(cancancelAction) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:_cancelBtn];
        }
       
        
        if (!_scrollView) {
            _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, Main_Screen_Width, _contentView.frame.size.height - 50)];
            [_contentView addSubview:_scrollView];
        }
    
        [self configureWithSeries:series stars:star];
    }
    return self;
}

- (void)configureWithSeries:(NSArray*)series stars:(NSArray*)star
{
    if (series==nil&&star==nil) {
        return;
    }
    
    for (UIView * view in _scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    float x1 = kSpaceX;
    if (series.count > 0) {
        for (int i = 0 ; i< series.count ; i++) {
            UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchSeries:)];
            SeriesModel * model = series[i];
            UIImageView * seriesImage = [[UIImageView alloc]initWithFrame:CGRectMake(20 + (90 + 50)*i, 20, 90, 100)];
            seriesImage.tag = [model.ID integerValue];
            
            [seriesImage sd_setImageWithURL:URL(model.postUrl) placeholderImage:IMAGENAME(@"")];
            
            seriesImage.userInteractionEnabled = YES;
            
            [seriesImage addGestureRecognizer:gesture];
            
            [_scrollView addSubview:seriesImage];
            
            UILabel * label = [[UILabel alloc]init];
            label.center = CGPointMake(seriesImage.center.x, seriesImage.center.y + 70);
            label.bounds = CGRectMake(0, 0, 100, 15);
            label.font = SYSTEMFONT(14);
            label.textAlignment = NSTextAlignmentCenter;
            label.text = model.name;
            [_scrollView addSubview:label];
            
            x1 = MaxX(seriesImage) + 50;
        }
    }
    
    float x2 = x1;
    if (star.count > 0) {
        for (int i = 0 ; i< star.count ; i++) {
            ActorModel * model = star[i];
            UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchStar:)];
            UIImageView * starImage = [[UIImageView alloc]initWithFrame:CGRectMake(x1 + (90 + 50)*i, 25, 90, 90)];
            starImage.backgroundColor = [UIColor redColor];
            starImage.layer.cornerRadius = 45;
            starImage.layer.masksToBounds = YES;
            starImage.userInteractionEnabled = YES;
            [starImage sd_setImageWithURL:URL(model.headUrl) placeholderImage:IMAGENAME(@"")];
            [starImage setTag:[model.ID integerValue]];
            [_scrollView addSubview:starImage];
            [starImage addGestureRecognizer:gesture];
            
            UILabel * label = [[UILabel alloc]init];
            label.center = CGPointMake(starImage.center.x, starImage.center.y + 70);
            label.bounds = CGRectMake(0, 0, 100, 15);
            label.font = SYSTEMFONT(14);
            label.textAlignment = NSTextAlignmentCenter;
            label.text = model.name;
            [_scrollView addSubview:label];
            
            
            x2 = MaxX(starImage) + 50;
        }
    }
    
    if (x2 > Main_Screen_Width) {
        _scrollView.contentSize = CGSizeMake(x2,_contentView.frame.size.height - 50 );
    }
    
}

- (void)cancancelAction
{
    [self hiddenForAnimation];
}

- (void)touchSeries:(UITapGestureRecognizer*)gesture
{
    UIImageView * img = (UIImageView*)gesture.view;
    if (self.seriesAction) {
         self.seriesAction(img.tag);
    }
}

- (void)touchStar:(UITapGestureRecognizer*)gesture
{
    UIImageView * img = (UIImageView*)gesture.view;
    
    if (self.starAction) {
        self.starAction(img.tag);
    }
}

- (void)showForAnimation
{
    if (_isShowing==YES) {
        return;
    }
    self.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    _cover.alpha = 0.4;
    [UIView animateWithDuration:0.3 animations:^{
    
        
    }completion:^(BOOL finished) {
        
        _isShowing = YES;
    }];
    
}
- (void)hiddenForAnimation
{
    if (_isShowing == NO) {
        return;
    }
    __weak RelateSeriesStarView * weakself = self;
    _cover.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        
        weakself.frame = CGRectMake(0, Main_Screen_Height, Main_Screen_Width, Main_Screen_Height);
        
    }completion:^(BOOL finished) {
        
        _isShowing = NO;
    }];
}

@end
