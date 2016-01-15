//
//  WYYCOrderWaitingAndProcesingViewController.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/7/3.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCOrderWaitingAndProcesingViewController.h"
#import "WYYC.h"
#import "WYYCOrderPayViewController.h"
#import "WYYCConst.h"
#import "AppDelegate.h"
@interface WYYCOrderWaitingAndProcesingViewController ()
//等待时长
@property (weak, nonatomic) IBOutlet UILabel *waitingTimerInterval;
//代驾时长
@property (weak, nonatomic) IBOutlet UILabel *DrivingTimeInterval;
//代驾里程


@property (weak, nonatomic) IBOutlet UIButton *currentDrivingDistance;
//代驾费用
@property (weak, nonatomic) IBOutlet UIButton *currentDrivingCost;
@property (weak, nonatomic) IBOutlet UIButton *waitingBtn;
@property (weak, nonatomic) UIButton * arriveButton ;

@property (strong ,nonatomic) AppDelegate *appDelegate;
@end
static BOOL isDriving = YES;
static NSTimer *timer;
@implementation WYYCOrderWaitingAndProcesingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    self.waitingTimerInterval.text = [self showTime:waitingTimeCount];
    self.DrivingTimeInterval.text =  [self showTime:drivingTimeCount];
    if (timer){
        [timer invalidate];
        timer =nil;
        [self startWatingTimer];
    }else{
        [self startWatingTimer];
    }
    
    //获得目的地地址－－ 当前地址
    [WYYCNOTIFICATION addObserver:self selector:@selector(currentAddress:) name:WYYCLocationDidUpdateNotification object:nil];

}

- (AppDelegate *)appDelegate
{
      _appDelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    return _appDelegate;
}

- (void)setup
{
    self.navigationItem.title = @"申代驾";
    
    self.waitingTimerInterval.textColor = BLUE_COLOR ;
    self.DrivingTimeInterval.textColor = BLUE_COLOR ;
    
    [self.currentDrivingCost setTitleColor:ORANGE_COLOR forState:UIControlStateNormal];
    [self.currentDrivingDistance setTitleColor:ORANGE_COLOR forState:UIControlStateNormal];
    
    [self.waitingBtn setBackgroundColor:BLUE_COLOR];
    self.waitingBtn.layer.cornerRadius = 5;
    UIButton *arriveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [arriveBtn setTitle:@"到达终点" forState:UIControlStateNormal];
    [arriveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [arriveBtn addTarget:self action:@selector(arriveDestination) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *window =  [[UIApplication sharedApplication] keyWindow] ;
    [window addSubview:arriveBtn];
    arriveBtn.frame = CGRectMake(0,CGRectGetMaxY(window.frame)-49, window.frame.size.width, 49);
    [arriveBtn setBackgroundColor:BLUE_COLOR];
    self.arriveButton = arriveBtn;
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigation_back"]style:UIBarButtonItemStylePlain target:self action:@selector(popViewController) ];
}

-(void)currentAddress:(NSNotification *)notification
{
    NSString *destinationAddress = [notification userInfo][WYYCCurrentDetailAddressKey];

    self.appDelegate.order.destination = destinationAddress ;
}
- (void)popViewController
{
     
    [self.navigationController popToRootViewControllerAnimated:YES ];
}

#pragma  - mark 到达现场
- (void)arriveDestination
{
 
    [timer invalidate];
     timer = nil ;
    waitingTimeCount = 0;
    drivingTimeCount = 0;

    self.appDelegate.order.orderStatusCode =orderFinishedNotPayStatus;
    NSLog(@"orderFinishedNotPayStatus: %d",self.appDelegate.order.orderStatusCode);
    WYYCOrderPayViewController *orderPayVC = [[WYYCOrderPayViewController alloc]init];
    
    [self.navigationController pushViewController:orderPayVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 中途等待 ，继续代驾
- (IBAction)clickBtn:(UIButton *)sender {
    if (isDriving) {
        [self.waitingBtn setTitle:@"继续代驾" forState:UIControlStateNormal];
        self.appDelegate.order.orderStatusCode = orderHalfwayWaitingStatus;
        isDriving = NO ;
    }else{
        [self.waitingBtn setTitle:@"中途等待" forState:UIControlStateNormal];
        self.appDelegate.order.orderStatusCode = orderContinuedDrivingStatus ;
        isDriving = YES ;
    }
}


- (void)startWatingTimer
{
    if (timer==nil) {
        __weak typeof(self) weakself = self;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
           timer =[NSTimer timerWithTimeInterval:1.0 target:weakself selector:@selector(updateTime) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            [[NSRunLoop currentRunLoop]run];
        });
    }

}
static int waitingTimeCount =0;
static int drivingTimeCount =0;

- (void) updateTime{
    int totalTime;
    if (isDriving) {
        totalTime = ++drivingTimeCount ;
    }else{
        totalTime = ++waitingTimeCount ;
    }
   __weak NSString *totalCount= [self showTime:totalTime];
    dispatch_sync(dispatch_get_main_queue(), ^{
        if (isDriving) {

            self.DrivingTimeInterval.text = totalCount;
            NSLog(@"self.DrivingTimeInterver.text:%@",self.DrivingTimeInterval.text);
            NSLog(@"totalCount: %@",totalCount);
  
        }else{
         
            self.waitingTimerInterval.text = totalCount;
        }
        
    });

    
}
- (NSString *)showTime:(int)timeCount
{

    NSLog(@"waitingTimeCount:%d",waitingTimeCount);
    NSLog(@"drivingTimeCount:%d",drivingTimeCount);
    int hours =  timeCount / 3600;
    int minutes = ( timeCount - hours * 3600 ) / 60;
    int seconds = timeCount - hours * 3600 - minutes * 60;
   
    return [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hours,minutes,seconds];
    
    //    NSLog(@"-->  %d : %d :%d",hours,minutes,seconds);
    
}







- (void)viewWillDisappear:(BOOL)animated
{
    if (self.arriveButton) {
        [self.arriveButton removeFromSuperview];
    }

}
@end
