//
//  WYYCHomeViewController.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/18.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//


#import "WYYC.h"
#import "WYYCConst.h"
#import "WYYCHomeViewController.h"
#import "WYYCOrderDetailViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "WYYCCreatOrderViewController.h"
#import "WYYCOrderWaitingAndProcesingViewController.h"
#import "WYYCOrderPayViewController.h"
#import "AppDelegate.h"
@interface WYYCHomeViewController ()<BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate>
//当前地理位置
@property (weak, nonatomic) IBOutlet UILabel *currentAddress;
//小时－－－在线时长
@property (weak, nonatomic) IBOutlet UIButton *hours;
//分钟
@property (weak, nonatomic) IBOutlet UIButton *minutes;
//秒
@property (weak, nonatomic) IBOutlet UIButton *seconds;
//创建订单按钮
@property (weak, nonatomic) IBOutlet UIButton *creatOrderBtn;
//今日代驾订单数量
@property (weak, nonatomic) IBOutlet UILabel *todayOrderCount;
//今日收入
@property (weak, nonatomic) IBOutlet UILabel *todayIncome;
//结束工作按钮
@property (weak, nonatomic) IBOutlet UIButton *endWorkBtn;
//创建订单
- (IBAction)creatOrder:(id)sender;
//结束工作
- (IBAction)endWork:(id)sender;
//代驾客户姓名
@property (weak, nonatomic) IBOutlet UILabel *customerName;
//代驾出发地点
@property (weak, nonatomic) IBOutlet UILabel *startPlace;
//当前订单所在的View
@property (weak, nonatomic) IBOutlet UIView *currentOrderView;
//一键订单所在的View
@property (weak, nonatomic) IBOutlet UIView *creatOrderView;



//定位点
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;


@property (nonatomic ,strong) NSTimer *timer;
@property (copy,nonatomic) NSString * city ;
@property (copy,nonatomic) NSString * detailAddress ;
@property (nonatomic,strong)  AFHTTPRequestOperationManager *manager ;

@property (strong,nonatomic) BMKUserLocation *userLocation;
@property (strong,nonatomic) WYYCOrder * order;
@property (nonatomic ,assign) BOOL hasOrder;
@property (nonatomic,strong) AppDelegate *appDelegate ;
@end
 static BMKLocationService *locService;
static BMKGeoCodeSearch  * geocodesearch;
@implementation WYYCHomeViewController
  static NSDate * startWorkDate;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [ self setUp];
    //设置10米更新位置
    // [BMKLocationService setLocationDistanceFilter:1.0];
    //定位服务
    locService = [[BMKLocationService alloc]init];
    geocodesearch = [[BMKGeoCodeSearch alloc]init];
    [locService startUserLocationService];
     [MBProgressHUD showMessage:nil];
    //在线时长
    [self updateWorkingTimer];
    //每隔几秒钟 将当前位置发送给服务器。
    [self updateTimer:3];
    
    self.manager = [AFHTTPRequestOperationManager manager];

    //接受订单通知。
    [WYYCNOTIFICATION addObserver:self selector:@selector(acceptedOrder:) name:WYYCDidAcceptedOrderNotification object:nil];
    //完成订单通知。
    [WYYCNOTIFICATION addObserver:self selector:@selector(finishedOrder:) name:WYYCDidFinishedOrderNotification object:nil];
    
    
}

- (AppDelegate *)appDelegate
{
    return  [[UIApplication sharedApplication]delegate];
}
- (WYYCOrder *)order
{
    if (_order==nil) {
        self.order = [[WYYCOrder alloc]init];
    }
    return  _order;
}

- (void) acceptedOrder:(NSNotification *) notification
{
    WYYCOrder *order= [notification userInfo][WYYCAcceptedOrderKey];
    self.order = order ;
    self.hasOrder = YES ;
}

- (void)finishedOrder:(NSNotification *)notification
{
    self.hasOrder =NO ;
}

- (void)setUp {
    
    self.navigationItem.title=@"申代驾";
    self.edgesForExtendedLayout =  UIRectEdgeNone ;
    
    [self.hours setTitleColor:ORANGE_COLOR forState:UIControlStateNormal];
    [self.minutes setTitleColor:ORANGE_COLOR  forState:UIControlStateNormal];
    [self.seconds setTitleColor:ORANGE_COLOR  forState:UIControlStateNormal];
    self.hours.enabled = NO ;
    self.minutes.enabled = NO ;
    self.seconds.enabled = NO ;
    self.creatOrderBtn.layer.cornerRadius = 5;
    self.endWorkBtn.layer.cornerRadius = 5;
    
    
    self.todayIncome.textColor = ORANGE_COLOR;
    self.todayOrderCount.textColor = ORANGE_COLOR ;
    
    self.currentAddress.numberOfLines=0;
    
    [self.creatOrderBtn setBackgroundColor:BLUE_COLOR];
    [self.endWorkBtn setBackgroundColor:BLUE_COLOR];




}


/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f,%@,%@",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude,userLocation.title,userLocation.subtitle);
    self.coordinate = userLocation.location.coordinate;
    self.userLocation = userLocation ;
    [self reverseGeocode:userLocation.location.coordinate];

    
   // [self.locService stopUserLocationService];
}

#pragma - mark reverseGeocode 反地理编码
-(void)reverseGeocode:(CLLocationCoordinate2D)location
{
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    
    reverseGeocodeSearchOption.reverseGeoPoint = location;
    BOOL flag = [geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
       
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}

#pragma - mark BMKGeoCodeSearchDelegate
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
        self.currentAddress.text = result.address;
        self.detailAddress = result.address ;
        self.city =  result.addressDetail.city;
        NSLog(@"result.address :%@",result.address );
        [WYYCNOTIFICATION postNotificationName:WYYCLocationDidUpdateNotification object:nil userInfo:@{WYYCUserLocationKey:self.userLocation,WYYCCurrentDetailAddressKey:self.detailAddress}];
       
  
        
        [MBProgressHUD hideHUD];
    }else{
        self.currentAddress.text = @"定位失败";
    }
}

#pragma - mark 定时将当前位置发送给服务器
- (void)updateTimer:(double) timeStep
{
    double tempTimeStep=3;
    if (timeStep!=0) {
        tempTimeStep=timeStep;
    }
    
    if (_timer ==nil) {
        __weak typeof(self) weakself=self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            weakself.timer=[NSTimer scheduledTimerWithTimeInterval:tempTimeStep
                                                            target:weakself
                                                          selector:@selector(updateCurrentLocation)
                                                          userInfo:nil
                                                           repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:weakself.timer forMode:NSRunLoopCommonModes];
            [[NSRunLoop currentRunLoop]run];
        });
        
        
    }
}


#pragma 显示用户在线时长
- (void )updateWorkingTimer
{

    __weak typeof(self) weakself = self;
    startWorkDate = [NSDate date];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
       NSTimer *timer =[NSTimer timerWithTimeInterval:1.0 target:weakself selector:@selector(showTime:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop]run];
    });
    
}

- (void)showTime:(int)time
{
    NSDate *now = [NSDate date];
    int totalWorkTime= (int)[now timeIntervalSinceDate:startWorkDate];
    int hours =  totalWorkTime / 3600;
    int minutes = ( totalWorkTime - hours * 3600 ) / 60;
    int seconds = totalWorkTime - hours * 3600 - minutes * 60;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hours setTitle:[NSString stringWithFormat:@"%.2d",hours] forState:UIControlStateNormal] ;
        [self.minutes setTitle:[NSString stringWithFormat:@"%.2d",minutes] forState:UIControlStateNormal] ;
        [self.seconds setTitle:[NSString stringWithFormat:@"%.2d",seconds] forState:UIControlStateNormal] ;
    });


    
}



- (void) updateCurrentLocation{

    NSNumber *latitude=@(self.coordinate.latitude);
    NSNumber *longitude=@(self.coordinate.longitude);
    NSDictionary *parameters = @{@"doid": @"9a864580-1a68-11e5-b305-c417feef5224",@"x":longitude,@"y":latitude};
    
    NSString *url = [NSString stringWithFormat:@"%@%@",WYYC_PREFIX,DRIVER_STATE_SYNCHRONOUS];
    NSLog(@"para: %@",parameters);
    
     [self.manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"JSON: %@", responseObject);
     
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
     }];
    
}





- (void)handletapGesture:(UIGestureRecognizer *)sender
{
    WYYCOrderDetailViewController *orderDetailVC=[[WYYCOrderDetailViewController alloc]init];
    [self.navigationController pushViewController:orderDetailVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    locService.delegate = self;
    geocodesearch.delegate = self;
    self.tabBarController.tabBar.hidden = NO ;
    if(self.hasOrder){
        self.currentOrderView.hidden = NO ;
        self.creatOrderView.hidden = YES ;
    }else{
        self.currentOrderView.hidden = YES ;
        self.creatOrderView.hidden = NO ;
    }

}
- (void)viewWillDisappear:(BOOL)animated
{

}
- (void)dealloc {

}


- (IBAction)clicktoCurrentOrder:(UIButton *)sender {
    UIViewController *viewVC = nil ;
    NSLog(@"++++++++++++++ %d",self.appDelegate.order.orderStatusCode);
    if (self.appDelegate.order.orderStatusCode ==orderContinuedDrivingStatus |
        self.appDelegate.order.orderStatusCode ==orderDuringDrivingStatus|
        self.appDelegate.order.orderStatusCode ==orderHalfwayWaitingStatus) {
            viewVC =[[WYYCOrderWaitingAndProcesingViewController alloc]init];
    }else if(self.appDelegate.order.orderStatusCode ==orderFinishedNotPayStatus){
        viewVC = [[WYYCOrderPayViewController alloc]init];
    }
    
    [self.navigationController pushViewController:viewVC animated:YES];
}

- (IBAction)creatOrder:(id)sender {
    
    WYYCCreatOrderViewController *creatOrderVC = [[WYYCCreatOrderViewController alloc]init];

    
    self.order.startPlace = self.detailAddress;
    self.order.orderCity =self.city;
    self.order.latitude = @(self.coordinate.latitude);
    self.order.longitude = @(self.coordinate.longitude) ;
    self.appDelegate.order = self.order ;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:creatOrderVC animated:YES];
}

- (IBAction)endWork:(id)sender {
}



- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [NSPropertyListSerialization
                     propertyListWithData:tempData
                     options:NSPropertyListImmutable
                     format:NULL
                     error:NULL];
    return str;
}




@end
