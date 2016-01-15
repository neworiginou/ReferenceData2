//
//  CustomSegmentControl.h
//  TableTest
//
//  Created by caijingpeng.haowu on 14-11-17.
//  Copyright (c) 2014年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomSegmentControl;

@protocol CustomSegmentControlDelegate <NSObject>

- (void)segmentControl:(CustomSegmentControl *)sControl didSelectSegmentIndex:(int)index;

@optional
- (void)doubleClickGestureRecognizer;

@end

@interface CustomSegmentControl : UIView
{
    NSMutableArray *buttons;
}

@property (nonatomic, assign) int selectedIndex;
@property(nonatomic,strong)UIView * lab;
@property (nonatomic, assign) id<CustomSegmentControlDelegate> delegate;

- (id)initWithTitles:(NSArray *)titleArr;
- (void)setSelectedIndex:(int)aSelectedIndex;

@end
