//
//  HWCustomCalendar.h
//  SY_Date
//
//  Created by caijingpeng.haowu on 15/2/18.
//  Copyright (c) 2015年 孙悦. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWCustomCalendar;

@protocol HWCustomCalendarDelegate <NSObject>

- (void)calendar:(HWCustomCalendar *)cal didSelectDate:(NSDate *)date;

@end

@interface HWCustomCalendar : UIView
{
    UIScrollView *_scrollView;
    
    int _btnSelectDate;                 //btn选择的位置
    NSMutableArray *_btnArray;
    UIView *_dateView;
    
    NSMutableArray *_changeBtnArrayR;
    NSMutableArray *_changeBtnArrayL;
    
    UIView *_changeDateR;
    UIView *_changeDateL;
    
    int _scrollDate;                    // 滑动控制中间日期
    int _btnDate;
    int _changeWeek;
    
    NSDate *_selectedDate;
    NSMutableArray *_signArray;
    NSMutableArray *_redPointArray;
    NSDate *_targetDate;
}

@property (nonatomic, weak) id<HWCustomCalendarDelegate> delegate;

- (void)setSignDate:(NSArray *)signs;
- (void)setDate:(NSDate *)date;

@end
