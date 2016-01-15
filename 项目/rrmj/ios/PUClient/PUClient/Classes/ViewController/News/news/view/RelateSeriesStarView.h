//
//  RelateSeriesStarView.h
//  PUClient
//
//  Created by RRLhy on 15/8/13.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RelateSeriesStarView : UIView

@property (nonatomic, assign)BOOL isShowing;

@property (nonatomic, copy)void(^seriesAction)(NSInteger seriesId);

@property (nonatomic, copy)void(^starAction)(NSInteger starId);

- (instancetype)initWithFrame:(CGRect)frame seriesArray:(NSArray*)series starsArray:(NSArray*)star;

- (void)configureWithSeries:(NSArray*)series stars:(NSArray*)star;

- (void)showForAnimation;

- (void)hiddenForAnimation;

@end
