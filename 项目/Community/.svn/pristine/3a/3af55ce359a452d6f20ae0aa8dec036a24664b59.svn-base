//
//  HWOpenTimeViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-9-7.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWOpenTimeViewController.h"
#import "HWInputBackView.h"
#define kOpenFlag  6000
#define kCloseFlag 6001
@interface HWOpenTimeViewController ()
{
    UIDatePicker *_datePicker;
    UIButton *_operateBtn;
}
@end

@implementation HWOpenTimeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Utility navTitleView:@"营业时间"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"提交" action:@selector(toConfirm:)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 22, 200, 27)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = THEME_COLOR_TEXT;
    label.font = [UIFont fontWithName:FONTNAME size:15.0f];
    label.text = @"营业时间";
    [self.view addSubview:label];
    
    HWInputBackView *backView = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), kScreenWidth, 45.0f) withLineCount:1];
    [self.view addSubview:backView];
    
    UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(backView.frame), 0, 0.5f, 45.0f)];
    verticalLine.backgroundColor = THEME_COLOR_LINE;
    [backView addSubview:verticalLine];
    
    UILabel *openLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 7.5f, 40, 30)];
    openLab.backgroundColor = [UIColor clearColor];
    openLab.font = [UIFont fontWithName:FONTNAME size:15.0f];
    openLab.text = @"开门";
    [backView addSubview:openLab];
    
    UIButton *openTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //openTimeBtn.frame = CGRectMake(CGRectGetMinX(verticalLine.frame) - 60, 7.5f, 60, 30);
    openTimeBtn.frame = CGRectMake(0, 7.5f, 160, 30);
    openTimeBtn.backgroundColor = [UIColor clearColor];
    openTimeBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:15.0f];
    [openTimeBtn setTitle:@"09:00" forState:UIControlStateNormal];
    [openTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [openTimeBtn addTarget:self action:@selector(toSetOpenTime:) forControlEvents:UIControlEventTouchUpInside];
    openTimeBtn.tag = kOpenFlag;
    [backView addSubview:openTimeBtn];
    
    UILabel *closeLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(verticalLine.frame) + 15, 7.5f, 40, 30)];
    closeLab.backgroundColor = [UIColor clearColor];
    closeLab.font = [UIFont fontWithName:FONTNAME size:15.0f];
    closeLab.text = @"关门";
    [backView addSubview:closeLab];
    
    UIButton *closeTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    closeTimeBtn.frame = CGRectMake(kScreenWidth - 60, 7.5f, 60, 30);
    closeTimeBtn.frame = CGRectMake(kScreenWidth - 160, 7.5f, 160, 30);
    closeTimeBtn.backgroundColor = [UIColor clearColor];
    closeTimeBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:15.0f];
    [closeTimeBtn setTitle:@"22:00" forState:UIControlStateNormal];
    [closeTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeTimeBtn addTarget:self action:@selector(toSetCloseTime:) forControlEvents:UIControlEventTouchUpInside];
    closeTimeBtn.tag = kCloseFlag;
    [backView addSubview:closeTimeBtn];
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _datePicker.datePickerMode = UIDatePickerModeTime;
    [_datePicker addTarget:self action:@selector(changeTime:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_datePicker];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    _datePicker.date = [formatter dateFromString:@"09:00"];
    
    _datePicker.frame = CGRectMake(0, CONTENT_HEIGHT - _datePicker.frame.size.height, 0, 0);
    
    _operateBtn = openTimeBtn;
//    openTimeStr = [self convertDate:@"09:00"];
//    closeTimeStr = [self convertDate:@"22:00"];
    openTimeStr = @"09:00";
    closeTimeStr = @"22:00";
    
}

#pragma mark -
#pragma mark Private method

- (void)toConfirm:(id)sender
{
    if (!openTimeStr) {
        NSLog(@"请选择开门时间");
        [Utility showToastWithMessage:@"请选择开门时间" inView:self.view];
        return;
    }
    if (!closeTimeStr) {
        NSLog(@"请选择关门时间");
        [Utility showToastWithMessage:@"请选择关门时间" inView:self.view];
        return;
    }
    if (_selectTime) {
        _selectTime(openTimeStr,closeTimeStr);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)toSetOpenTime:(UIButton *)sender
{
    NSString *dateStr = [sender titleForState:UIControlStateNormal];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"]; // 这里是用大写的 H
    NSDate *date = [dateFormatter dateFromString:dateStr];
    _datePicker.date = date;
    _operateBtn = sender;
}

- (void)toSetCloseTime:(id)sender
{
    NSString *dateStr = [sender titleForState:UIControlStateNormal];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"]; // 这里是用大写的 H
    NSDate *date = [dateFormatter dateFromString:dateStr];
    _datePicker.date = date;
    _operateBtn = sender;
}
//转换字符串格式为上午/下午 16：40
- (NSMutableString *)convertDate:(NSString *)dateStrTemp
{
    NSMutableString *dateStr;
    NSString *date = [dateStrTemp substringFromIndex:([dateStrTemp length]-2)];
    if([date isEqualToString:@"AM"]||[date isEqualToString:@"上午"])
    {
        dateStr = [NSMutableString stringWithString:@"上午"];
        [dateStr appendString:[dateStrTemp substringToIndex:([dateStrTemp length]-2)]];
    }
    else
    {
        dateStr = [NSMutableString stringWithString:@"下午"];
        [dateStr appendString:[dateStrTemp substringToIndex:([dateStrTemp length]-2)]];

    }
   return dateStr;
}
- (void)changeTime:(id)sender
{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate *date = control.date;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"]; // 这里是用大写的 H
    
    NSDateFormatter* dateFormatterOne = [[NSDateFormatter alloc] init];
    [dateFormatterOne setDateFormat:@"HH:mmaa"]; // 这里是用大写的 H
    
    NSString* dateStr = [dateFormatter stringFromDate:date];
//    NSString* dateStrOne = [dateFormatterOne stringFromDate:date];
    [_operateBtn setTitle:dateStr forState:UIControlStateNormal];
    if (_operateBtn.tag == kOpenFlag)
    {
        openTimeStr = dateStr;
//        openTimeStr = [self convertDate:dateStrOne];
    }
    else if(_operateBtn.tag == kCloseFlag)
    {
        closeTimeStr = dateStr;
//        closeTimeStr = [self convertDate:dateStrOne];
    }
    NSLog(@"%@",dateStr);
}

#pragma mark -
#pragma mark System method

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
