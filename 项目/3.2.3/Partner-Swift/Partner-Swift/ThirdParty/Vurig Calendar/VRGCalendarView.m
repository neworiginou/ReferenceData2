//
//  VRGCalendarView.m
//  Vurig
//
//  Created by in 't Veen Tjeerd on 5/8/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//
//  功能描述：日历控件
//
//  魏远林    2015-02-28    修改部分颜色、以及字体（搜索WYL）
//
//
#import "VRGCalendarView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSDate+convenience.h"
#import "NSMutableArray+convenience.h"
#import "UIView+convenience.h"
#import "Define-OC.h"

@implementation VRGCalendarView
@synthesize currentMonth,delegate,labelCurrentMonth, animationView_A,animationView_B;
@synthesize markedDates,markedColors,calendarHeight,selectedDate,markedSchoolDates,markedSummerDates;
@synthesize markedqueqinDates,markedBudengDates;
#pragma mark - Select Date
-(void)selectDate:(int)date {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:self.currentMonth];
    [comps setDay:date];
//    NSLog(@"a=%@",self.currentMonth);
//    NSLog(@"b=%d",date);
   // NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
   
    self.selectedDate = [gregorian dateFromComponents:comps];
    [gregorian release];
//    NSInteger interval = [zone secondsFromGMTForDate: self.selectedDate];
//    
//    NSDate *localeDate = [self.selectedDate  dateByAddingTimeInterval: interval];
    
    int selectedDateYear = [selectedDate year];
    int selectedDateMonth = [selectedDate month];
    
    int currentMonthYear = [currentMonth year];
    int currentMonthMonth = [currentMonth month];
    
    if (selectedDateYear < currentMonthYear) {
        [self showPreviousMonth];
    } else if (selectedDateYear > currentMonthYear) {
        [self showNextMonth];
    } else if (selectedDateMonth < currentMonthMonth) {
        [self showPreviousMonth];
    } else if (selectedDateMonth > currentMonthMonth) {
        [self showNextMonth];
    } else {
        [self setNeedsDisplay];
    }

//    NSLog(@"%@",self.selectedDate);
    if ([delegate respondsToSelector:@selector(calendarView:dateSelected:)])
        [delegate calendarView:self dateSelected:self.selectedDate];
}

#pragma mark - Mark Dates
//NSArray can either contain NSDate objects or NSNumber objects with an int of the day.
- (void)markDates:(NSArray *)dates
{
    self.markedDates = dates;
//    NSMutableArray *colors = [[NSMutableArray alloc] init];
//    
//    for (int i = 0; i<[dates count]; i++) {
//        [colors addObject:[UIColor colorWithHexString:@"0x383838"]];
//    }
//    
//    self.markedColors = [NSArray arrayWithArray:colors];
//    [colors release];
    
    [self setNeedsDisplay];
}
- (void)markqueqinDates:(NSArray *)dates {
    self.markedqueqinDates=dates;
    
    [self setNeedsDisplay];
    
}

- (void)markedBuDengDates:(NSArray *)dates {
    self.markedBudengDates = dates;
    [self setNeedsDisplay];
}


- (void)markSchoolDates:(NSArray *)dates
{
    self.markedSchoolDates = dates;
    [self setNeedsDisplay];
}

//NSArray can either contain NSDate objects or NSNumber objects with an int of the day.
-(void)markDates:(NSArray *)dates withColors:(NSArray *)colors {
    self.markedDates = dates;
    self.markedColors = colors;
    
    [self setNeedsDisplay];
}

#pragma mark - Set date to now
-(void)reset {

//     NSTimeZone *zone = [NSTimeZone systemTimeZone];
//        NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];
//    
//        NSDate *localeDate = [[NSDate date]  dateByAddingTimeInterval: interval];
    

    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           NSDayCalendarUnit) fromDate: [NSDate date]];
    self.currentMonth = [gregorian dateFromComponents:components]; //clean month
    [gregorian release];

//    NSLog(@"%@",self.currentMonth);
    [self updateSize];
    [self setNeedsDisplay];
    [delegate calendarView:self switchedToYear:[currentMonth year] switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:NO];
    
//    NSLog(@"%@",self.selectedDate);
    if ([delegate respondsToSelector:@selector(calendarView:dateSelected:)])
        [delegate calendarView:self dateSelected:self.currentMonth];

    
//    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    
//    NSInteger interval = [zone secondsFromGMTForDate: self.currentMonth];
//    
//    NSDate *localeDate = [self.currentMonth  dateByAddingTimeInterval: interval];
//    if ([delegate respondsToSelector:@selector(calendarView:dateSelected:)])
//        [delegate calendarView:self dateSelected:localeDate];
}

#pragma mark - Next & Previous
-(void)showNextMonth {
    if (isAnimating) return;
    self.markedDates=nil;
    self.markedqueqinDates=nil;
    self.markedSchoolDates = nil;
    self.markedBudengDates = nil;
    isAnimating=YES;
    prepAnimationNextMonth=YES;
    
    [self setNeedsDisplay];
    
    int lastBlock = [currentMonth firstWeekDayInMonth]+[currentMonth numDaysInMonth]-1;
    int numBlocks = [self numRows]*7;
    BOOL hasNextMonthDays = lastBlock<numBlocks;
    
    //Old month
    float oldSize = self.calendarHeight;
    UIImage *imageCurrentMonth = [self drawCurrentState];
    
    //New month
    self.currentMonth = [currentMonth offsetMonth:1];
    if ([delegate respondsToSelector:@selector(calendarView:switchedToYear:switchedToMonth:targetHeight:animated:)]) [delegate calendarView:self switchedToYear:[currentMonth year] switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:YES];
    prepAnimationNextMonth=NO;
    [self setNeedsDisplay];

    UIImage *imageNextMonth = [self drawCurrentState];
//    float targetSize = fmaxf(oldSize, self.calendarHeight);
    UIView *animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, kVRGCalendarViewTopBarHeight, kVRGCalendarViewWidth, self.frame.size.height -kVRGCalendarViewTopBarHeight)];
    [animationHolder setClipsToBounds:YES];
    [self addSubview:animationHolder];
    [animationHolder release];
    
    //Animate
    animationView_A = [[UIImageView alloc] initWithImage:imageCurrentMonth];
    animationView_B = [[UIImageView alloc] initWithImage:imageNextMonth];
    [animationHolder addSubview:animationView_A];
    [animationHolder addSubview:animationView_B];
    
//    if (hasNextMonthDays)
//    {
//        animationView_B.frameY = animationView_A.frameY + animationView_A.frameHeight - (kVRGCalendarViewDayHeight+3);
//    }
//    else
//    {
//    animationView_A.frameHeight = animationView_A.frameHeight;
        animationView_B.frameY = animationView_A.frameY + animationView_A.frameHeight;
//    }
    
    //Animation
    __block VRGCalendarView *blockSafeSelf = self;
    [UIView animateWithDuration:.35
                     animations:^{
                         [self updateSize];
                         //blockSafeSelf.frameHeight = 100;
//                         if (hasNextMonthDays) {
//                             animationView_A.frameY = -animationView_A.frameHeight + kVRGCalendarViewDayHeight;
//                         } else {
                             animationView_A.frameY = -animationView_A.frameHeight;
//                         }
                         animationView_B.frameY = 0;
                     }
                     completion:^(BOOL finished) {
                         [animationView_A removeFromSuperview];
                         [animationView_B removeFromSuperview];
                         blockSafeSelf.animationView_A=nil;
                         blockSafeSelf.animationView_B=nil;
                         isAnimating=NO;
                         [animationHolder removeFromSuperview];
                     }
     ];
}

-(void)showPreviousMonth {
    if (isAnimating) return;
    isAnimating=YES;
    self.markedDates=nil;
    self.markedqueqinDates=nil;
    self.markedSchoolDates = nil;
    self.markedBudengDates = nil;
    //Prepare current screen
    prepAnimationPreviousMonth = YES;
    [self setNeedsDisplay];
    BOOL hasPreviousDays = [currentMonth firstWeekDayInMonth]>1;
    float oldSize = self.calendarHeight;
    UIImage *imageCurrentMonth = [self drawCurrentState];
    
    //Prepare next screen
    self.currentMonth = [currentMonth offsetMonth:-1];
    if ([delegate respondsToSelector:@selector(calendarView:switchedToYear:switchedToMonth:targetHeight:animated:)]) [delegate calendarView:self switchedToYear:[currentMonth year] switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:YES];
    prepAnimationPreviousMonth=NO;
    [self setNeedsDisplay];
    UIImage *imagePreviousMonth = [self drawCurrentState];
    
    float targetSize = fmaxf(oldSize, self.calendarHeight);
    UIView *animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, kVRGCalendarViewTopBarHeight, kVRGCalendarViewWidth, self.frame.size.height - kVRGCalendarViewTopBarHeight)];
    
    [animationHolder setClipsToBounds:YES];
    [self addSubview:animationHolder];
    [animationHolder release];
    
    animationView_A = [[UIImageView alloc] initWithImage:imageCurrentMonth];
    animationView_B = [[UIImageView alloc] initWithImage:imagePreviousMonth];
    [animationHolder addSubview:animationView_A];
    [animationHolder addSubview:animationView_B];
    
//    if (hasPreviousDays) {
//        animationView_B.frameY = animationView_A.frameY - (animationView_B.frameHeight-kVRGCalendarViewDayHeight) + 3;
//    } else {
        animationView_B.frameY = animationView_A.frameY - animationView_B.frameHeight;
//    }
    
    __block VRGCalendarView *blockSafeSelf = self;
    [UIView animateWithDuration:.35
                     animations:^{
                         [self updateSize];
                         
//                         if (hasPreviousDays) {
//                             animationView_A.frameY = animationView_B.frameHeight-(kVRGCalendarViewDayHeight);
//                             
//                         } else {
                             animationView_A.frameY = animationView_B.frameHeight;
//                         }
                         
                         animationView_B.frameY = 0;
                     }
                     completion:^(BOOL finished) {
                         [animationView_A removeFromSuperview];
                         [animationView_B removeFromSuperview];
                         blockSafeSelf.animationView_A=nil;
                         blockSafeSelf.animationView_B=nil;
                         isAnimating=NO;
                         [animationHolder removeFromSuperview];
                     }
     ];
}


#pragma mark - update size & row count
-(void)updateSize {
//    self.frameHeight = self.calendarHeight;
    [self setNeedsDisplay];
}

- (float)calendarHeight {
    return kVRGCalendarViewTopBarHeight + [self numRows]*(kVRGCalendarViewDayHeight+2)+1 + 10;
}

-(int)numRows {
    float lastBlock = [self.currentMonth numDaysInMonth]+([self.currentMonth firstWeekDayInMonth]-1);
    return ceilf(lastBlock/7);
}

#pragma mark - Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{       
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    self.selectedDate=nil;
    
    //Touch a specific day
    
    if (touchPoint.y > kVRGCalendarViewTopBarHeight)
    {
        int marginLeft = (kVRGCalendarViewWidth - kVRGCalendarViewDayWidth * 7) / 2.0f;
        
        float xLocation = touchPoint.x - marginLeft;
        
        if (xLocation < 0 || xLocation > (kVRGCalendarViewWidth - marginLeft*2)) {
            return;
        }
        
        float yLocation = touchPoint.y - kVRGCalendarViewTopBarHeight - kVRGCalendarViewDayHeight + 5;
        
        int column = floorf(xLocation / (kVRGCalendarViewDayWidth));
        int row = floorf(yLocation / (kVRGCalendarViewDayHeight));
        
        int blockNr = (column + 1) + row * 7;
        int firstWeekDay = [self.currentMonth firstWeekDayInMonth] - 1; //-1 because weekdays begin at 1, not 0
        int date = blockNr - firstWeekDay;
        [self selectDate:date];
        return;
    }
    
    self.markedDates=nil;
    self.markedColors=nil;  
    
    CGRect rectArrowLeft = CGRectMake(0, 0, 50, 40);
    CGRect rectArrowRight = CGRectMake(self.frame.size.width-50, 0, 50, 40);
    
    //Touch either arrows or month in middle
    if (CGRectContainsPoint(rectArrowLeft, touchPoint)) {
        [self showPreviousMonth];
    } else if (CGRectContainsPoint(rectArrowRight, touchPoint)) {
        [self showNextMonth];
    } else if (CGRectContainsPoint(self.labelCurrentMonth.frame, touchPoint)) {
        //Detect touch in current month
        
        int currentMonthIndex = [self.currentMonth month];
        int todayMonth = [[NSDate date] month];
        [self reset];
        if ((todayMonth!=currentMonthIndex) && [delegate respondsToSelector:@selector(calendarView:switchedToYear:switchedToMonth:targetHeight:animated:)]) [delegate calendarView:self switchedToYear:[currentMonth year]  switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:NO];
    }
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect
{
    int firstWeekDay = [self.currentMonth firstWeekDayInMonth]-1; //-1 because weekdays begin at 1, not 0
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM,yyyy"];
    
//    NSString *lan= NSLocalizedString(@"Lanague", @"2");

//    if([lan isEqualToString:@"1"])
//    {
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//    }
//    else
//    {
//        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CH"];
//    }

    
    NSString *dateStr = [formatter stringFromDate:self.currentMonth];
    NSArray *dateArray = [dateStr componentsSeparatedByString:@","];
    NSString *monthStr = [dateArray objectAtIndex:0];
    NSString *yearStr = [dateArray objectAtIndex:1];
    if ([monthStr isEqualToString:@"January"]) {
        monthStr = @"一月";
    }
    else if ([monthStr isEqualToString:@"February"]){
        monthStr = @"二月";
    }
    else if ([monthStr isEqualToString:@"March"]){
        monthStr = @"三月";
    }
    else if ([monthStr isEqualToString:@"April"]){
        monthStr = @"四月";
    }
    else if ([monthStr isEqualToString:@"May"]){
        monthStr = @"五月";
    }
    else if ([monthStr isEqualToString:@"June"]){
        monthStr = @"六月";
    }
    else if ([monthStr isEqualToString:@"July"]){
        monthStr = @"七月";
    }
    else if ([monthStr isEqualToString:@"August"]){
        monthStr = @"八月";
    }
    else if ([monthStr isEqualToString:@"September"]){
        monthStr = @"九月";
    }
    else if ([monthStr isEqualToString:@"October"]){
        monthStr = @"十月";
    }
    else if ([monthStr isEqualToString:@"November"]){
        monthStr = @"十一月";
    }
    else if ([monthStr isEqualToString:@"December"]){
        monthStr = @"十二月";
    }

    labelCurrentMonth.text = [NSString stringWithFormat:@"%@,%@",yearStr,monthStr];

//    NSLog(@"%@",[formatter stringFromDate:self.currentMonth]);

    [labelCurrentMonth sizeToFit];
    labelCurrentMonth.frameX = roundf(self.frame.size.width/2 - labelCurrentMonth.frameWidth/2);
    labelCurrentMonth.frameY = (40 - labelCurrentMonth.frameHeight) / 2.0f;
    [formatter release];
    [currentMonth firstWeekDayInMonth];
    
    CGContextClearRect(UIGraphicsGetCurrentContext(),rect);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rectangle = CGRectMake(0, 0, self.frame.size.width, kVRGCalendarViewTopBarHeight);
    CGContextAddRect(context, rectangle);
    CGContextSetFillColorWithColor(context, THEME_COLOR_ORANGE_NORMAL.CGColor);
    CGContextFillPath(context);
    
    CGRect rectangleBar = CGRectMake(0, kVRGCalendarViewTopBarHeight - 3,self.frame.size.width,3);
    CGContextAddRect(context, rectangleBar);
    //WYL
//    CGContextSetFillColorWithColor(context, THEME_COLOR_RED_NORMAL.CGColor);
    CGContextSetFillColorWithColor(context, UIColorFromRGB(0xff7302).CGColor);
    CGContextFillPath(context);
    
    //Arrows
    int arrowSize = 12;
    int xmargin = 15;
    int ymargin = (40 - arrowSize) / 2.0f;
    
    //Arrow Left
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, xmargin+arrowSize/1.5, ymargin);
    CGContextAddLineToPoint(context,xmargin+arrowSize/1.5, ymargin+arrowSize);
    CGContextAddLineToPoint(context,xmargin, ymargin+arrowSize/2);
    CGContextAddLineToPoint(context,xmargin+arrowSize/1.5, ymargin);
    
    CGContextSetFillColorWithColor(context, 
                                   [UIColor whiteColor].CGColor);
    CGContextFillPath(context);
    
    //Arrow right
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.frame.size.width-(xmargin+arrowSize/1.5), ymargin);
    CGContextAddLineToPoint(context,self.frame.size.width-xmargin,ymargin+arrowSize/2);
    CGContextAddLineToPoint(context,self.frame.size.width-(xmargin+arrowSize/1.5),ymargin+arrowSize);
    CGContextAddLineToPoint(context,self.frame.size.width-(xmargin+arrowSize/1.5), ymargin);
    
    CGContextSetFillColorWithColor(context, 
                                   [UIColor whiteColor].CGColor);
    CGContextFillPath(context);
    
    int numRows = [self numRows];
    
    
    
    //Grid background
    float gridHeight = self.frameHeight - kVRGCalendarViewTopBarHeight;
    CGRect rectangleGrid = CGRectMake(0, kVRGCalendarViewTopBarHeight, self.frame.size.width, gridHeight);
    CGContextAddRect(context, rectangleGrid);
    //WYL
//    CGContextSetFillColorWithColor(context, THEME_COLOR_BACKGROUND_2.CGColor);
    CGContextSetFillColorWithColor(context, CD_BackGroundColor.CGColor);
    CGContextFillPath(context);
    
    //Weekdays
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
//    if([lan isEqualToString:@"1"])
//    {
          dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        // dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CH"];
//    }
//    else
//    {
//         dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CH"];
//    }
   
    dateFormatter.dateFormat=@"EEEE";
    //always assume gregorian with monday first
    NSMutableArray *weekdays = [[NSMutableArray alloc] initWithArray:[dateFormatter shortStandaloneWeekdaySymbols]];
    
//    NSLog(@"%@",weekdays);
    
    [weekdays moveObjectFromIndex:0 toIndex:6];
    
    CGContextSetFillColorWithColor(context, 
                                   THEME_COLOR_ORANGE_NORMAL.CGColor);
    int marginLeft = (kVRGCalendarViewWidth - kVRGCalendarViewDayWidth * 7) / 2.0f;
    
    for (int i =0; i<[weekdays count]; i++)
    {
        NSString *weekdayValue = (NSString *)[weekdays objectAtIndex:i];
        weekdayValue = [weekdayValue uppercaseString];
        UIFont *font = [UIFont fontWithName:FONTNAME size:12 - 2];
//        NSLog(@"%@",weekdayValue);
        //WYL
//        if ([weekdayValue isEqualToString:@"MON"])
//        {
//            weekdayValue = @"周一";
//        }
//        else if ([weekdayValue isEqualToString:@"TUE"])
//        {
//            weekdayValue = @"周二";
//        }
//        else if ([weekdayValue isEqualToString:@"WED"])
//        {
//            weekdayValue = @"周周三";
//        }
//        else if ([weekdayValue isEqualToString:@"THU"])
//        {
//            weekdayValue = @"周四";
//        }
//        else if ([weekdayValue isEqualToString:@"FRI"])
//        {
//            weekdayValue = @"周五";
//        }
//        else if ([weekdayValue isEqualToString:@"SAT"])
//        {
//            weekdayValue = @"周六";
//        }
//        else if ([weekdayValue isEqualToString:@"SUN"])
//        {
//            weekdayValue = @"周日";
//        }

        //如果是周六或者周末，字体颜色设置为红色
        if ([weekdayValue isEqualToString:@"SAT"] || [weekdayValue isEqualToString:@"SUN"])
        {
            CGContextSetFillColorWithColor(context,
                                           [UIColor redColor].CGColor);
        }
        [weekdayValue drawInRect:CGRectMake(i*(kVRGCalendarViewDayWidth) + marginLeft,kVRGCalendarViewTopBarHeight + 8, kVRGCalendarViewDayWidth, 20) withFont:font lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
    }
    
    CGContextSetAllowsAntialiasing(context, NO);
    
    
    
    //Grid white lines
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:243/255.0f green:240/255.0f blue:237/255.0f alpha:1.0f].CGColor);
//    CGContextBeginPath(context);
//    CGContextMoveToPoint(context, 13, kVRGCalendarViewTopBarHeight+6);
//    CGContextAddLineToPoint(context, kVRGCalendarViewWidth - 13, kVRGCalendarViewTopBarHeight+6);
//    for (int i = 0; i<8; i++) {
//        CGContextMoveToPoint(context, i*(kVRGCalendarViewDayWidth+1)+i*1 + 13 , kVRGCalendarViewTopBarHeight + 5);
//        CGContextAddLineToPoint(context, i*(kVRGCalendarViewDayWidth+1)+i*1 + 13 , kVRGCalendarViewTopBarHeight + gridHeight - 5);
//        
//        //rows
//        CGContextMoveToPoint(context, 13, kVRGCalendarViewTopBarHeight+i*(kVRGCalendarViewDayHeight+1)+i*1 + 5);
//        CGContextAddLineToPoint(context, kVRGCalendarViewWidth - 13, kVRGCalendarViewTopBarHeight+i*(kVRGCalendarViewDayHeight+1)+i*1 + 5);
//        
////        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:243/255.0f green:240/255.0f blue:237/255.0f alpha:1.0f].CGColor);
//    }
//    
//    CGContextStrokePath(context);
//    
    CGContextSetAllowsAntialiasing(context, YES);
    
    //Draw days
    CGContextSetFillColorWithColor(context, 
                                   [UIColor colorWithHexString:@"0x383838"].CGColor);

    
    int numBlocks = numRows*7;
    NSDate *previousMonth = [self.currentMonth offsetMonth:-1];
    int currentMonthNumDays = [currentMonth numDaysInMonth];
    int prevMonthNumDays = [previousMonth numDaysInMonth];
    
    int selectedDateBlock = ([selectedDate day]-1)+firstWeekDay;
    
    //prepAnimationPreviousMonth nog wat mee doen
    
    //prev next month
    BOOL isSelectedDatePreviousMonth = prepAnimationPreviousMonth;
    BOOL isSelectedDateNextMonth = prepAnimationNextMonth;
    
    if (self.selectedDate!=nil) {
        isSelectedDatePreviousMonth = ([selectedDate year]==[currentMonth year] && [selectedDate month]<[currentMonth month]) || [selectedDate year] < [currentMonth year];
        
        if (!isSelectedDatePreviousMonth) {
            isSelectedDateNextMonth = ([selectedDate year]==[currentMonth year] && [selectedDate month]>[currentMonth month]) || [selectedDate year] > [currentMonth year];
        }
    }
    
    if (isSelectedDatePreviousMonth) {
        int lastPositionPreviousMonth = firstWeekDay-1;
        selectedDateBlock=lastPositionPreviousMonth-([selectedDate numDaysInMonth]-[selectedDate day]);
    } else if (isSelectedDateNextMonth) {
        selectedDateBlock = [currentMonth numDaysInMonth] + (firstWeekDay-1) + [selectedDate day];
    }
    
    
    NSDate *todayDate = [NSDate date];
    int todayBlock = -1;
    
//    NSLog(@"currentMonth month = %i day = %i, todaydate day = %i",[currentMonth month],[currentMonth day],[todayDate month]);
    
    if ([todayDate month] == [currentMonth month] && [todayDate year] == [currentMonth year]) {
        todayBlock = [todayDate day] + firstWeekDay - 1;
    }
    
//    int marginLeft = (kVRGCalendarViewWidth - kVRGCalendarViewDayWidth * 7) / 2.0f;
    
    for (int i = 0; i < numBlocks; i++)
    {
        int targetDate = i;
        int targetColumn = i%7;
        int targetRow = i/7;
        int targetX = targetColumn * (kVRGCalendarViewDayWidth) + marginLeft;
        int targetY = kVRGCalendarViewTopBarHeight + targetRow * (kVRGCalendarViewDayHeight) + 8 + kVRGCalendarViewDayHeight - 5;
        
        CGRect rectangleGrid = CGRectMake(targetX,targetY,kVRGCalendarViewDayWidth,kVRGCalendarViewDayHeight);
        CGContextAddRect(context, rectangleGrid);
        
    
        // BOOL isCurrentMonth = NO;
        if (i<firstWeekDay) { //previous month
            
            CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
            CGContextFillPath(context);
            
            targetDate = (prevMonthNumDays-firstWeekDay)+(i+1);
//            NSString *hex = (isSelectedDatePreviousMonth) ? @"0x383838" : @"aaaaaa";
            
            CGContextSetFillColorWithColor(context, 
                                           TITLE_COLOR_99.CGColor);
        } else if (i>=(firstWeekDay+currentMonthNumDays)) { //next month
            
            CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
            CGContextFillPath(context);
            
            targetDate = (i + 1) - (firstWeekDay+currentMonthNumDays);
//            NSString *hex = (isSelectedDateNextMonth) ? @"0x383838" : @"aaaaaa";
            CGContextSetFillColorWithColor(context,
                                           TITLE_COLOR_99.CGColor);
        } else { //current month
            // isCurrentMonth = YES;
            
            CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
            CGContextFillPath(context);
            targetDate = (i - firstWeekDay) + 1;
            //WYL
//            CGContextSetFillColorWithColor(context,
//                                           [UIColor blackColor].CGColor);
            CGContextSetFillColorWithColor(context,
                                           TITLE_COLOR_66.CGColor);
        }
        
        NSString *date = [NSString stringWithFormat:@"%i",targetDate];

        //draw selected date
//        if (selectedDate && i == selectedDateBlock)
//        {
//            CGRect rectangleGrid = CGRectMake(targetX + 4,targetY - 8,kVRGCalendarViewDayHeight,kVRGCalendarViewDayHeight);
////            CGContextAddRect(context, rectangleGrid);
//            CGContextAddEllipseInRect(context, rectangleGrid);
//            CGContextSetFillColorWithColor(context, THEME_COLOR_GREEN_NORMAL.CGColor);
//            CGContextFillPath(context);
//            
//            CGContextSetFillColorWithColor(context, 
//                                           [UIColor whiteColor].CGColor);
//        }
        if (todayBlock == i)
        {
            //WYL
//            CGRect rectangleGrid = CGRectMake(targetX + 4 + 2,targetY - 8 + 2,kVRGCalendarViewDayHeight - 4,kVRGCalendarViewDayHeight - 4);
            CGRect rectangleGrid = CGRectMake(targetX + 4 + 2,targetY - 6 + 2,kVRGCalendarViewDayHeight - 4,kVRGCalendarViewDayHeight - 4);
            //            CGContextAddRect(context, rectangleGrid);
            CGContextAddEllipseInRect(context, rectangleGrid);
            //WYL
//            CGContextSetFillColorWithColor(context, THEME_COLOR_GREEN_NORMAL.CGColor);
            CGContextSetFillColorWithColor(context, UIColorFromRGB(0x37ca6b).CGColor);//今日选中绿色
            CGContextFillPath(context);
            
            CGContextSetFillColorWithColor(context,
                                           [UIColor whiteColor].CGColor);
        }
        //WYL
//        [date drawInRect:CGRectMake(targetX, targetY, kVRGCalendarViewDayWidth, kVRGCalendarViewDayHeight) withFont:[UIFont fontWithName:FONTNAME size:12] lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
        [date drawInRect:CGRectMake(targetX, targetY, kVRGCalendarViewDayWidth, kVRGCalendarViewDayHeight) withFont:[UIFont fontWithName:FONTNAME size:15] lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
    }
    
    //Draw markings
    if (!self.markedDates || isSelectedDatePreviousMonth || isSelectedDateNextMonth) return;
    
    for (int i = 0; i < [self.markedDates count]; i++)
    {
        id markedDateObj = [self.markedDates objectAtIndex:i];
        
        int targetDate;
        if ([markedDateObj isKindOfClass:[NSNumber class]])
        {
            targetDate = [(NSNumber *)markedDateObj intValue];
        }
        else if ([markedDateObj isKindOfClass:[NSDate class]])
        {
            NSDate *date = (NSDate *)markedDateObj;
            targetDate = [date day];
        }
        else
        {
            continue;
        }
        
//        int targetColumn = i%7;
//        int targetRow = i/7;
//        int targetX = targetColumn * (kVRGCalendarViewDayWidth) + marginLeft;
//        int targetY = kVRGCalendarViewTopBarHeight + targetRow * (kVRGCalendarViewDayHeight) + 8 + kVRGCalendarViewDayHeight - 5;
        
        int targetBlock = firstWeekDay + (targetDate-1);
        int targetColumn = targetBlock%7;
        int targetRow = targetBlock/7;

        int targetX = targetColumn * (kVRGCalendarViewDayWidth) + marginLeft;
        int targetY = kVRGCalendarViewTopBarHeight + targetRow * (kVRGCalendarViewDayHeight) + 8 + kVRGCalendarViewDayHeight - 5;
        //WYL
//        CGRect rectangleGrid = CGRectMake(targetX + 4 + 2,targetY - 8 + 2,kVRGCalendarViewDayHeight - 4,kVRGCalendarViewDayHeight - 4);
        CGRect rectangleGrid = CGRectMake(targetX + 4 + 2,targetY - 6 + 2,kVRGCalendarViewDayHeight - 4,kVRGCalendarViewDayHeight - 4);
        //            CGContextAddRect(context, rectangleGrid);
        CGContextAddEllipseInRect(context, rectangleGrid);
//        CGContextAddArc(context, targetX + 4, targetY - 8, kVRGCalendarViewDayHeight / 2.0f, 0, M_PI * 2, 0);
//        CGContextSetFillColorWithColor(context, THEME_COLOR_GREEN_NORMAL.CGColor);
//        CGContextFillPath(context);
        CGContextSetStrokeColorWithColor(context, THEME_COLOR_ORANGE_NORMAL.CGColor);
        CGContextStrokePath(context);
        
//        CGContextSetFillColorWithColor(context,
//                                       [UIColor whiteColor].CGColor);
        
//        int targetBlock = firstWeekDay + (targetDate-1);
//        int targetColumn = targetBlock%7;
//        int targetRow = targetBlock/7;
//        
//        int targetX = targetColumn * (kVRGCalendarViewDayWidth+2) +45;
//        int targetY = kVRGCalendarViewTopBarHeight + targetRow * (kVRGCalendarViewDayHeight+2)+8;
//    // 图片
//        
//        
//        CGRect rectangle = CGRectMake(targetX,targetY,9,9);
//        UIImage *imageGreen=[UIImage imageNamed:@"greenPoint.png"];
//        [imageGreen drawInRect:rectangle];
//       // CGContextAddRect(context, rectangle);
//        
//      //  UIColor *color;
//        if (selectedDate && selectedDateBlock==targetBlock) {
//           // color = [UIColor whiteColor];
//            UIImage *imageGreen=[UIImage imageNamed:@"greenPoint.png"];
//            [imageGreen drawInRect:rectangle];
//        }  else if (todayBlock==targetBlock) {
//            UIImage *imageGreen=[UIImage imageNamed:@"greenPoint.png"];
//            [imageGreen drawInRect:rectangle];
//           // color = [UIColor whiteColor];
//        } else {
//           // color  = (UIColor *)[markedColors objectAtIndex:i];
//            UIImage *imageGreen=[UIImage imageNamed:@"greenPoint.png"];
//            [imageGreen drawInRect:rectangle];
//        }
//        
//        
//       // CGContextSetFillColorWithColor(context, color.CGColor);
//        CGContextFillPath(context);
    }
    
    

    
}

#pragma mark - Draw image for animation
- (UIImage *)drawCurrentState
{
    float targetHeight = self.frameHeight;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(kVRGCalendarViewWidth, targetHeight-kVRGCalendarViewTopBarHeight), YES, [UIScreen mainScreen].scale);
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(c, 0, -kVRGCalendarViewTopBarHeight);    // <-- shift everything up by 40px when drawing.
    [self.layer renderInContext:c];
    UIImage* viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

#pragma mark - Init
- (id)init {
//    NAVIHEIGHT + (ios7 ? 20 : 0)
    self = [super initWithFrame:CGRectMake(15, 10, kVRGCalendarViewWidth, 255)];
    if (self) {
        self.contentMode = UIViewContentModeTop;
        self.clipsToBounds=YES;
        
        self.selectedDate = [NSDate date];
        
        isAnimating = NO;
        labelCurrentMonth = [[UILabel alloc] initWithFrame:CGRectMake(34, (IOS7 ? 20 : 0), kVRGCalendarViewWidth - 68, 40)];
        [self addSubview:labelCurrentMonth];
        labelCurrentMonth.backgroundColor=[UIColor clearColor];
        labelCurrentMonth.font = [UIFont fontWithName:FONTNAME size:13];
        labelCurrentMonth.textColor = [UIColor whiteColor];
        labelCurrentMonth.textAlignment = NSTextAlignmentCenter;
        
        [self performSelector:@selector(reset) withObject:nil afterDelay:0.1]; //so delegate can be set after init and still get called on init
        //        [self reset];
    }
    return self;
}

- (void)dealloc {
    
    self.delegate=nil;
    self.currentMonth=nil;
    self.labelCurrentMonth=nil;
    
    self.markedDates=nil;
    self.markedColors=nil;
    self.markedSchoolDates = nil;
    self.markedBudengDates = nil;
    
    [super dealloc];
}
@end
