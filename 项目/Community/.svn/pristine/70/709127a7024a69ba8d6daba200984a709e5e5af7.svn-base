//
//  HWCustomSegmentControl.h
//  Community
//
//  Created by wuxiaohong on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWCustomSegmentControl;

@protocol HWCustomSegmentControlDelegate <NSObject>

- (void)segmentControl:(HWCustomSegmentControl *)sControl didSelectSegmentIndex:(int)index;

@end

@interface HWCustomSegmentControl : UIView
{
    NSMutableArray *buttons;
}

@property (nonatomic, assign) int selectedIndex;
@property(nonatomic,strong)UIView * lab;
@property (nonatomic, assign) id<HWCustomSegmentControlDelegate> delegate;

- (id)initWithTitles:(NSArray *)titleArr fram:(CGRect)fram;;
- (void)setSelectedIndex:(int)aSelectedIndex;

@end
