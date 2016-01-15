//
//  HWCustomCalendar.m
//  SY_Date
//
//  Created by caijingpeng.haowu on 15/2/18.
//  Copyright (c) 2015年 孙悦. All rights reserved.
//

#import "HWCustomCalendar.h"
#import "CalendarDateUtil.h"
#import "Partner_Swift-Swift.h"

#define TITLE_COLOR             [UIColor grayColor]
#define BUTTON_COLOR            [UIColor blackColor]
#define BUTTON_SELECT_COLOR     [UIColor whiteColor]

#define TITILE_FONT             [UIFont systemFontOfSize:14]
#define BUTTON_FONT             [UIFont systemFontOfSize:19]
#define ScreenWidth             [UIScreen mainScreen].bounds.size.width
#define MARIN_LEFT              10

@implementation HWCustomCalendar
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    CGRect defaultFrame = CGRectMake(frame.origin.x, frame.origin.y, [UIScreen mainScreen].bounds.size.width, 100);
    
    self = [super initWithFrame:defaultFrame];
    
    if (self)
    {
        _scrollDate = 0;
        _btnDate = 0;
        
        [self initBase];
        [self initDateView];
        
        [self initSwipeGestureRecognizerLeft];
        [self initSwipeGestureRecognizerRight];
    }
    
    return self;
}

- (void)initBase
{
    _btnArray = [[NSMutableArray alloc]init];
    _btnSelectDate = 0;
    _changeWeek = 0;
    _signArray = [[NSMutableArray alloc] init];
    _redPointArray = [[NSMutableArray alloc] init];
    
    _dateView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, ScreenWidth, 40)];
    _dateView.backgroundColor = [UIColor clearColor];
    
    _changeBtnArrayR = [[NSMutableArray alloc]init];
    _changeBtnArrayL = [[NSMutableArray alloc]init];
    
    _changeDateR = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth, 43, ScreenWidth, 40)];
    _changeDateL = [[UIView alloc]initWithFrame:CGRectMake(-ScreenWidth, 43, ScreenWidth, 40)];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    //    _scrollView.pagingEnabled = YES;
    //    _scrollView.userInteractionEnabled = YES; // 是否滑动
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
}

- (void)initDateView
{
    for (int i = 0; i < 7; i++)
    {
        UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth - 2 * MARIN_LEFT) / 7 * i + 10, 20, (ScreenWidth - 2 * MARIN_LEFT) / 7, 15)];
        lab.font = TITILE_FONT;
        lab.textColor = TITLE_COLOR;
        lab.backgroundColor = [UIColor clearColor];
        NSString* week;
        switch (i) {
            case 0:{
                week = @"日";
                break;
            }
            case 1:{
                week = @"一";
                break;
            }
            case 2:{
                week = @"二";
                break;
            }
            case 3:{
                week = @"三";
                break;
            }
            case 4:{
                week = @"四";
                break;
            }
            case 5:{
                week = @"五";
                break;
            }
            case 6:{
                week = @"六";
                break;
            }
            default:
                break;
        }
        lab.text = [NSString stringWithFormat:@"%@",week];
        lab.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:lab];
    }
    
    NSMutableArray* tempArr = [self switchDay];
    
    for (int i = 0; i < 7; i++)
    {
        float lwidth = (ScreenWidth - 2 * MARIN_LEFT) / 7 - 40;
        
        UIButton* lab = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth - 2 * MARIN_LEFT) / 7 * i + 10 + lwidth / 2.0f, 0, 40, 40)];
        lab.titleLabel.font = BUTTON_FONT;
        [lab setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
        lab.backgroundColor = [UIColor clearColor];
        [lab setTitle:[tempArr objectAtIndex:i] forState:UIControlStateNormal];
        [lab addTarget:self action:@selector(selectData:) forControlEvents:UIControlEventTouchUpInside];
        
        NSDate *defultDate;
        if (_targetDate != nil)
        {
            defultDate = _targetDate;
        }
        else
        {
            defultDate = [NSDate date];
        }
        
        
        if ([lab.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%ld",[CalendarDateUtil getDayWithDate:defultDate]]])
        {
            [lab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [lab setBackgroundImage:[UIImage imageNamed:@"scanning_icon"] forState:UIControlStateNormal];
            lab.tag = 0;
            _btnSelectDate = i;
        }
        
        UILabel *redPointView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame) - 8 - 7, CGRectGetMinY(lab.frame) + 4, 10, 10.0f)];
        redPointView.backgroundColor = [UIColor redColor];
        redPointView.layer.cornerRadius = 5.0f;
        redPointView.layer.masksToBounds = YES;
        redPointView.hidden = YES;
        redPointView.textColor = [UIColor whiteColor];
        redPointView.textAlignment = NSTextAlignmentCenter;
        redPointView.font = [UIFont systemFontOfSize:8];
        [_dateView addSubview:redPointView];
        
        [_redPointArray addObject:redPointView];
        
        [_btnArray addObject:lab];
        [_dateView addSubview:lab];
    }
    //设置tag
    for (int i = 0; i < _btnSelectDate; i++)
    {
        int tagInt = i - _btnSelectDate;
        UIButton* tempBtn = [_btnArray objectAtIndex:i];
        tempBtn.tag = tagInt;
    }
    for (int i = 1; i < 7 - _btnSelectDate; i++)
    {
        int tagInt = i;
        UIButton* tempBtn = [_btnArray objectAtIndex:_btnSelectDate + i];
        tempBtn.tag = tagInt;
    }
    
    
    for (int i = 0; i < 7; i++)
    {
        float lwidth = (ScreenWidth - 2 * MARIN_LEFT) / 7 - 40;
        
        UIButton* lab = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth - 2 * MARIN_LEFT) / 7 * i + 10 + lwidth / 2.0f, 0, 40, 40)];
        lab.titleLabel.font = BUTTON_FONT;
        [lab setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
        lab.backgroundColor = [UIColor clearColor];
        [lab setTitle:[tempArr objectAtIndex:i] forState:UIControlStateNormal];
        [lab addTarget:self action:@selector(selectData:) forControlEvents:UIControlEventTouchUpInside];
        if ([lab.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%d",[CalendarDateUtil getCurrentDay]]])
        {
            [lab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [lab setBackgroundImage:[UIImage imageNamed:@"scanning_icon"] forState:UIControlStateNormal];
        }
        [_changeBtnArrayR addObject:lab];
        [_changeDateR addSubview:lab];
    }
    for (int i = 0; i < 7; i++)
    {
        float lwidth = (ScreenWidth - 2 * MARIN_LEFT) / 7 - 40;
        
        UIButton* lab = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth - 2 * MARIN_LEFT) / 7 * i + 10 + lwidth / 2.0f, 0, 40, 40)];
        lab.titleLabel.font = BUTTON_FONT;
        [lab setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
        lab.backgroundColor = [UIColor clearColor];
        [lab setTitle:[tempArr objectAtIndex:i] forState:UIControlStateNormal];
        [lab addTarget:self action:@selector(selectData:) forControlEvents:UIControlEventTouchUpInside];
        if ([lab.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%d",[CalendarDateUtil getCurrentDay]]])
        {
            [lab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [lab setBackgroundImage:[UIImage imageNamed:@"scanning_icon"] forState:UIControlStateNormal];
        }
        [_changeBtnArrayL addObject:lab];
        [_changeDateL addSubview:lab];
    }
    
    [_scrollView addSubview:_changeDateR];
    [_scrollView addSubview:_changeDateL];
    [_scrollView addSubview:_dateView];
    [_dateView bringSubviewToFront:_scrollView];
}

- (void)setDate:(NSDate *)date
{
    for (UIView *subview in self.subviews)
    {
        [subview removeFromSuperview];
    }
    
    _targetDate = date;
    _scrollDate = 0;
    _btnDate = 0;
    
    [self initBase];
    [self initDateView];
    
    [self initSwipeGestureRecognizerLeft];
    [self initSwipeGestureRecognizerRight];
}

- (NSMutableArray *)switchDay
{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    
    int head = 0;
    int foot = 0;
    
    NSInteger weekNum = [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]];
    
    if (_targetDate != nil) {
        weekNum = [self weekDate:_targetDate];
    }
    
    switch (weekNum) {
        case 1:{
            head = 0;
            foot = 6;
            break;
        }
        case 2:{
            head = 1;
            foot = 5;
            break;
        }
        case 3:{
            head = 2;
            foot = 4;
            break;
        }
        case 4:{
            head = 3;
            foot = 3;
            break;
        }
        case 5:{
            head = 4;
            foot = 2;
            break;
        }
        case 6:{
            head = 5;
            foot = 1;
            break;
        }
        case 7:{
            head = 6;
            foot = 0;
            break;
        }
            
            
        default:
            break;
    }
    
//    NSLog(@"%d , %d", head, foot);
    
    //    NSLog(@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:-1]]);
    
    for (int i = -head; i < 0; i++)
    {
        NSString* str = [NSString stringWithFormat:@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:i]]];
        if (_targetDate != nil)
        {
            str = [NSString stringWithFormat:@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceDate:_targetDate WithInterval:i]]];
        }
        
        [array addObject:str];
    }
    
    if (_targetDate != nil)
    {
        [array addObject:[NSString stringWithFormat:@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceDate:_targetDate WithInterval:0]]]];
    }
    else
    {
        [array addObject:[NSString stringWithFormat:@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:0]]]];
    }
    
    
    
    //sy 添加日期
    int tempNum = 1;
    for (int i = 0; i < foot; i++)
    {
        NSString* str = [NSString stringWithFormat:@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:tempNum]]];
        
        if (_targetDate != nil)
        {
            str = [NSString stringWithFormat:@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceDate:_targetDate WithInterval:tempNum]]];
        }
        
        [array addObject:str];
        tempNum++;
    }
    
//    NSLog(@"weekArray = %ld", [array count]);
    
    return array;
}

- (NSInteger)weekDate:(NSDate *)date
{
    // 获取当前年月日和周几
    //    NSDate *_date=[NSDate date];
    NSCalendar *_calendar=[NSCalendar currentCalendar];
    NSInteger unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents *com=[_calendar components:unitFlags fromDate:date];
    NSString *_dayNum=@"";
    NSInteger dayInt = 0;
    switch ([com weekday]) {
        case 1:{
            _dayNum=@"日";
            dayInt = 1;
            break;
        }
        case 2:{
            _dayNum=@"一";
            dayInt = 2;
            break;
        }
        case 3:{
            _dayNum=@"二";
            dayInt = 3;
            break;
        }
        case 4:{
            _dayNum=@"三";
            dayInt = 4;
            break;
        }
        case 5:{
            _dayNum=@"四";
            dayInt = 5;
            break;
        }
        case 6:{
            _dayNum=@"五";
            dayInt = 6;
            break;
        }
        case 7:{
            _dayNum=@"六";
            dayInt = 7;
            break;
        }
            
            
        default:
            break;
    }
    
    _selectedDate = [CalendarDateUtil dateSinceNowWithInterval:_scrollDate + _btnDate];
    if (_targetDate != nil)
    {
        _selectedDate = [CalendarDateUtil dateSinceDate:_targetDate WithInterval:_scrollDate + _btnDate];
    }
    
//    NSLog(@"date : %@", dateStr);
    
    return dayInt;
}


- (void)initSwipeGestureRecognizerLeft
{
    UISwipeGestureRecognizer *oneFingerSwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeUp:)];
    
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_dateView addGestureRecognizer:oneFingerSwipeUp];
}

- (void)initSwipeGestureRecognizerRight
{
    UISwipeGestureRecognizer *oneFingerSwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeDown:)];
    
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionRight];
    [_dateView addGestureRecognizer:oneFingerSwipeUp];
}

- (void)oneFingerSwipeUp:(UISwipeGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:self];
    NSLog(@"Swipe up - start location: %f,%f", point.x, point.y);
    
    _scrollDate += 7;
    
    _changeWeek += 7;
    [self setBtnTitleR];
    //    [self workViewR];
    NSDateFormatter *scDateformat=[[NSDateFormatter  alloc]init];
    [scDateformat setDateFormat:@"yyyyMMdd"];
    //    NSString* scollTime = [scDateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]];
    //    [self timeHidenButton:scollTime];
    
    CGRect oldFrame = _dateView.frame;
    //    CGRect oldFrameWork = _workView.frame;
    CGRect changeFrameDate = _changeDateR.frame;
    //    CGRect changeFrameWork = _changeWorkR.frame;
    
    [UIView animateWithDuration:0.75f
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction|
                                 UIViewAnimationOptionBeginFromCurrentState)
                     animations:^(void) {
                         [_dateView setFrame:CGRectMake(-ScreenWidth, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height)];
                         //                            [_workView setFrame:CGRectMake(-ScreenWidth, oldFrameWork.origin.y, oldFrameWork.size.width, oldFrameWork.size.height)];
                         [_changeDateR setFrame:CGRectMake(0, changeFrameDate.origin.y, changeFrameDate.size.width, changeFrameDate.size.height)];
                         //                            [_changeWorkR setFrame:CGRectMake(0, changeFrameWork.origin.y, changeFrameWork.size.width, changeFrameWork.size.height)];
                     }
                     completion:^(BOOL finished) {
                         [_dateView setFrame:CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height)];
                         //                            [_workView setFrame:CGRectMake(oldFrameWork.origin.x, oldFrameWork.origin.y, oldFrameWork.size.width, oldFrameWork.size.height)];
                         [_changeDateR setFrame:changeFrameDate];
                         //                            [_changeWorkR setFrame:changeFrameWork];
                         [self setBtnTitle];
                         
                         if (_targetDate != nil)
                         {
                             [self weekDate:[CalendarDateUtil dateSinceDate:_targetDate WithInterval:_btnDate]];
                         }
                         else
                         {
                             [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate]];
                         }
                         
                         NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
                         [dateformat setDateFormat:@"yyyyMMdd"];
//                         _timeString = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]];
                         
                         [self httpFuction];
                         
                     }];
    
}
- (void)oneFingerSwipeDown:(UISwipeGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:self];
//    NSLog(@"Swipe up - start location: %f,%f", point.x, point.y);
    
    _scrollDate -= 7;
    
    _changeWeek -= 7;
    [self setBtnTitleL];
    NSDateFormatter *scDateformat=[[NSDateFormatter  alloc]init];
    [scDateformat setDateFormat:@"yyyyMMdd"];
    
    CGRect oldFrame = _dateView.frame;
    CGRect changeFrameDate = _changeDateL.frame;
    
    [UIView animateWithDuration:0.75f
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction|
                                 UIViewAnimationOptionBeginFromCurrentState)
                     animations:^(void) {
                         [_dateView setFrame:CGRectMake(ScreenWidth, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height)];
                         //                            [_workView setFrame:CGRectMake(ScreenWidth, oldFrameWork.origin.y, oldFrameWork.size.width, oldFrameWork.size.height)];
                         [_changeDateL setFrame:CGRectMake(0, changeFrameDate.origin.y, changeFrameDate.size.width, changeFrameDate.size.height)];
                         //                            [_changeWorkL setFrame:CGRectMake(0, changeFrameWork.origin.y, changeFrameWork.size.width, changeFrameWork.size.height)];
                     }
                     completion:^(BOOL finished) {
                         [_dateView setFrame:CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height)];
                         //                            [_workView setFrame:CGRectMake(oldFrameWork.origin.x, oldFrameWork.origin.y, oldFrameWork.size.width, oldFrameWork.size.height)];
                         [_changeDateL setFrame:changeFrameDate];
                         //                            [_changeWorkL setFrame:changeFrameWork];
                         [self setBtnTitle];
                         if (_targetDate != nil)
                         {
                             [self weekDate:[CalendarDateUtil dateSinceDate:_targetDate WithInterval:_btnDate]];
                         }
                         else
                         {
                             [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate]];
                         }
                         
                         NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
                         [dateformat setDateFormat:@"yyyyMMdd"];
//                         _timeString = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]];
                         
                         [self httpFuction];
                         
                     }];
    
}

- (void)setSignDate:(NSArray *)signs
{
    _signArray = (NSMutableArray *)signs;
    [self setBtnTitle];
}

- (void)setRedPoint
{
    NSInteger chooseInt = [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]] - 1;
    
    if (_targetDate != nil)
    {
        chooseInt = [self weekDate:[CalendarDateUtil dateSinceDate:_targetDate WithInterval:0]] - 1;
    }
    
    for (int i = 0; i < _redPointArray.count; i++)
    {
        UILabel *redPointView = [_redPointArray objectAtIndex:i];
        
        NSDate *date = [CalendarDateUtil dateSinceNowWithInterval:_changeWeek + i - chooseInt];
        
        if (_targetDate != nil)
        {
            date = [CalendarDateUtil dateSinceDate:_targetDate WithInterval:_changeWeek + i - chooseInt];
        }
        
        NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        
        NSString *signNum = @"0";
        
        for (int i = 0; i < _signArray.count; i++)
        {
            NSDictionary *signDic = [_signArray objectAtIndex:i];
            NSString *signDateStr = [signDic stringObjectForKey:@"dateTime"];
            NSString *signDate = [Utility getTimeWithTimestamp:signDateStr dateFormatStr:@"yyyy-MM-dd"];
            
            if ([signDate isEqualToString:[dateFormat stringFromDate:date]])
            {
                signNum = [signDic stringObjectForKey:@"count"];
            }
        }
        
        if (signNum.integerValue > 0 && ![[dateFormat stringFromDate:date] isEqualToString:[dateFormat stringFromDate:_selectedDate]])
        {
            CGSize size = [Utility calculateStringSize:signNum textFont:redPointView.font constrainedSize:CGSizeMake(1000, 10)];
            
            CGRect frame = redPointView.frame;
            frame.size.width = MAX(size.width + 4, frame.size.height);
            redPointView.frame = frame;
            redPointView.text = signNum;
            redPointView.hidden = NO;
            
        }
        else
        {
            redPointView.hidden = YES;
        }
    }
}

-(void)setBtnTitle  // 修改Btn的日期
{
    NSInteger chooseInt = [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]] - 1;
    
    if (_targetDate != nil)
    {
        chooseInt = [self weekDate:[CalendarDateUtil dateSinceDate:_targetDate WithInterval:0]] - 1;
    }
    
    for (int i = 0; i < [_btnArray count]; i++)
    {
        if (_targetDate != nil)
        {
            NSDate *date = [CalendarDateUtil dateSinceDate:_targetDate WithInterval:_changeWeek + i - chooseInt];
            [[_btnArray objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d",[CalendarDateUtil getDayWithDate:date]] forState:UIControlStateNormal];
            if ([CalendarDateUtil isEquleDate:date other:[NSDate date]])
            {
                [[_btnArray objectAtIndex:i] setTitleColor:CD_MainColor forState:UIControlStateNormal];
            }
            else
            {
                [[_btnArray objectAtIndex:i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
        else
        {
            NSDate *date = [CalendarDateUtil dateSinceNowWithInterval:_changeWeek + i - chooseInt];
            [[_btnArray objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d",[CalendarDateUtil getDayWithDate:date]] forState:UIControlStateNormal];
            if ([CalendarDateUtil isEquleDate:date other:[NSDate date]])
            {
                [[_btnArray objectAtIndex:i] setTitleColor:CD_MainColor forState:UIControlStateNormal];
            }
            else
            {
                [[_btnArray objectAtIndex:i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
        
        UIButton* tmpBtn = [_btnArray objectAtIndex:i];
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if (_btnSelectDate == i)
        {
            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tmpBtn setBackgroundImage:[UIImage imageNamed:@"scanning_icon"] forState:UIControlStateNormal];
            _btnSelectDate = i;
        }
        
    }
    
    [self setRedPoint];
    
    
}
-(void)setBtnTitleR
{
    NSInteger chooseInt = [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]] - 1;
    if (_targetDate != nil)
    {
        chooseInt = [self weekDate:[CalendarDateUtil dateSinceDate:_targetDate WithInterval:0]] - 1;
    }
    
    for (int i = 0; i < [_changeBtnArrayR count]; i++)
    {
        if (_targetDate != nil)
        {
            [[_changeBtnArrayR objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d",[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceDate:_targetDate WithInterval:_changeWeek + i - chooseInt]]] forState:UIControlStateNormal];
        }
        else
        {
            [[_changeBtnArrayR objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d",[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:_changeWeek + i - chooseInt]]] forState:UIControlStateNormal];
        }
        
        
        UIButton* tmpBtn = [_changeBtnArrayR objectAtIndex:i];
        [tmpBtn setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if (_btnSelectDate == i)
        {
            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tmpBtn setBackgroundImage:[UIImage imageNamed:@"scanning_icon"] forState:UIControlStateNormal];
            _btnSelectDate = i;
        }
    }
}
- (void)setBtnTitleL
{
    NSInteger chooseInt = [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]] - 1;
    
    if (_targetDate != nil)
    {
        chooseInt = [self weekDate:[CalendarDateUtil dateSinceDate:_targetDate WithInterval:0]] - 1;
    }
    
    for (int i = 0; i < [_changeBtnArrayL count]; i++)
    {
        if (_targetDate != nil)
        {
            [[_changeBtnArrayL objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d",[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceDate:_targetDate WithInterval:_changeWeek + i - chooseInt]]] forState:UIControlStateNormal];
        }
        else
        {
            [[_changeBtnArrayL objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d",[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:_changeWeek + i - chooseInt]]] forState:UIControlStateNormal];
        }
        
        UIButton* tmpBtn = [_changeBtnArrayL objectAtIndex:i];
        [tmpBtn setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if (_btnSelectDate == i)
        {
            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tmpBtn setBackgroundImage:[UIImage imageNamed:@"scanning_icon"] forState:UIControlStateNormal];
            _btnSelectDate = i;
        }
    }
}

- (void)selectData:(id)sender
{
    UIButton* sendBtn = sender;
    
    for (int i = 0; i < [_btnArray count]; i++)
    {
        UIButton* tmpBtn = [_btnArray objectAtIndex:i];
        [tmpBtn setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        NSInteger chooseInt = [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]] - 1;
        NSDate *date = [CalendarDateUtil dateSinceNowWithInterval:_changeWeek + i - chooseInt];
        
        if ([tmpBtn.titleLabel.text isEqualToString:sendBtn.titleLabel.text])
        {
            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tmpBtn setBackgroundImage:[UIImage imageNamed:@"scanning_icon"] forState:UIControlStateNormal];
            _btnSelectDate = i;
        }
        else if ([CalendarDateUtil isEquleDate:date other:[NSDate date]])
        {
            [tmpBtn setTitleColor:CD_MainColor forState:UIControlStateNormal];
        }
        
        
        
        
//        NSLog(@"%@",date);
    }
    
    
    
    
    /*
    if ([sendBtn.titleLabel.text isEqualToString:@"29"])
    {
        _bsLable.text = @"0";
        _bpLable.text = @"0";
    }
    else
    {
        _bsLable.text = @"0";
        _bpLable.text = @"0";
    }
    */
    
    _btnDate = (int)sendBtn.tag;
    
    //按日期确定星期
    
    if (_targetDate != nil)
    {
        [self weekDate:[CalendarDateUtil dateSinceDate:_targetDate WithInterval:_btnDate]];
    }
    else
    {
        [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate]];
    }
    
    [self setRedPoint];
    
//    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
//    [dateformat setDateFormat:@"yyyyMMdd"];
//    _timeString = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]]; // _scrollDate
    
    [self httpFuction];
}

- (void)httpFuction
{
//    NSLog(@"%@",_selectedDate);
    
    if (delegate && [delegate respondsToSelector:@selector(calendar:didSelectDate:)])
    {
        [delegate calendar:self didSelectDate:_selectedDate];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
