//
//  CalendarViewController.m
//  PUClient
//
//  Created by lizhongqiang on 15/7/29.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "CalendarViewController.h"
#import "NSDate+FSExtension.h"
#define UIColorWithRGB(r,g,b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.]

@interface CalendarViewController ()<FSCalendarDataSource,FSCalendarDelegate>

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"签到";

    self.HeadDateLabel.text = @"日期";
    
    self.calendar.flow = FSCalendarFlowVertical;
    
    self.calendar.myHeader = self.HeadDateLabel;
    
    self.calendar.delegate = self;
    self.calendar.dataSource = self;
    
    CALayer *linLayer = [CALayer layer];
    linLayer.frame = CGRectMake(0, self.HeadDateLabel.bounds.size.height - 0.7, [UIScreen mainScreen].bounds.size.width, 0.7);
    linLayer.backgroundColor = UIColorWithRGB(206, 206, 206).CGColor;
    [self.HeadDateLabel.layer addSublayer:linLayer];
}
- (BOOL)calendar:(FSCalendar *)calendarView hasEventForDate:(NSDate *)date
{
    return date.fs_day == 3&&date.fs_month == 7;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
