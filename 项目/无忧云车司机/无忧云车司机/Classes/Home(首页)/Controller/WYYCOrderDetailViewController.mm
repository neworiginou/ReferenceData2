//
//  WYYCOrderDetailViewController.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/24.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCOrderDetailViewController.h"
#import "UIImage+Rotate.h"
#import "WYYC.h"
#import "WYYCConst.h"
#import "HCSStarRatingView.h"

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
    int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end


@interface WYYCOrderDetailViewController ()<BMKMapViewDelegate,BMKRouteSearchDelegate,BMKLocationServiceDelegate>

@property (strong ,nonatomic) BMKRouteSearch *routesearch;
@property (strong ,nonatomic) BMKLocationService *locService;
//客户头像
@property (weak, nonatomic) IBOutlet UIImageView *customerIcon;
//预约次数
@property (weak, nonatomic) IBOutlet UILabel *preOrderCount;
//评分view
@property (weak, nonatomic) IBOutlet HCSStarRatingView *ratingStarView;
//出发地
@property (weak, nonatomic) IBOutlet UILabel *startPlace;
//等待时间Label
@property (weak, nonatomic) IBOutlet UILabel *waitingTimeLable;
//等待时间
@property (weak, nonatomic) IBOutlet UILabel *waitingTime;
//底部按钮
@property (weak,nonatomic) UIButton *buttomBtn;

/**
 *  订单状态 1 已到达 2开始代驾 3到达终点
 */
@property (nonatomic,assign) NSUInteger *orderStatus;

/**
 *  百度地图
 */
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (strong,nonatomic) BMKUserLocation *userLocation;
//地图展示为当前位置
@property (nonatomic, assign) BOOL isLocated;
@end



@implementation WYYCOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    [self setup];
    
    [WYYCNOTIFICATION addObserver:self selector:@selector(updateUserLocation:) name:WYYCLocationDidUpdateNotification object:nil];

     self.routesearch = [[BMKRouteSearch alloc]init];
    
    self.mapView.zoomLevel = 13;


}

- (void)updateUserLocation:(NSNotification *) notification
{
    BMKUserLocation *userLocation = notification.userInfo[WYYCUserLocationKey];
    NSLog(@"updateUserLocation lat %f,long %f,%@,%@",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude,userLocation.title,userLocation.subtitle);
    self.userLocation = userLocation;

    CLLocation *end =[[CLLocation alloc]initWithLatitude:31.200852 longitude:121.681871];
    if (!_isLocated) {
            [self.mapView setCenterCoordinate:self.userLocation.location.coordinate];
        _isLocated = YES;
    }
   // [self.locService stopUserLocationService];
    [self driveSearchWithStartLocation:userLocation.location endLocation:end];
    
}

- (void) setup
{
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    [self.waitingTime setTextColor:BLUE_COLOR];
    
    [self.ratingStarView setTintColor:ORANGE_COLOR];
    
    self.navigationItem.title = @"申代驾";
    UIButton *buttomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttomBtn setTitle:@"开始代驾" forState:UIControlStateNormal];
    [buttomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttomBtn addTarget:self action:@selector(stratDriving) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *window =  [[UIApplication sharedApplication] keyWindow] ;
    [window addSubview:buttomBtn];
    buttomBtn.frame = CGRectMake(0,CGRectGetMaxY(window.frame)-49, window.frame.size.width, 49);
    [buttomBtn setBackgroundColor:BLUE_COLOR];
    [window addSubview:buttomBtn];
    self.buttomBtn =  buttomBtn;
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigation_back"]style:UIBarButtonItemStylePlain target:self action:@selector(popViewController) ];
    
}

- (void)popViewController
{
    if (_popSourceType ==creatOrderSourceType) {
        [self.navigationController popToRootViewControllerAnimated:YES ];
       
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)stratDriving
{

}


/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
   // NSLog(@"start locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
  //  NSLog(@"location error:%@",error);
}

-(void)driveSearchWithStartLocation:(CLLocation *)startLocation endLocation:(CLLocation *)endLocation
{
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.pt=startLocation.coordinate;
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.pt=endLocation.coordinate;
    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
    drivingRouteSearchOption.from = start;
    drivingRouteSearchOption.to = end;
    BOOL flag = [_routesearch drivingSearch:drivingRouteSearchOption];
    if(flag)
    {
        NSLog(@"car检索发送成功");
    }
    else
    {
        NSLog(@"car检索发送失败");
    }
    
}

- (NSString*)getMyBundlePath1:(NSString *)filename
{
    
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}


- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    //NSLog(@"error: %d",error);
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            //添加途径标注
          //  [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [_mapView addAnnotation:item];
            }
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
    
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        
        
    }
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
    }
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
    BMKAnnotationView* view = nil;
    switch (routeAnnotation.type) {
        case 0:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
              
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 1:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 2:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 3:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 4:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
           
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
            
        }
            break;
        case 5:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
        }
            break;
        default:
            break;
    }
    
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _routesearch.delegate = self; // 此处记得不用的时候需要
    NSLog(@"self.view.frame: %@",NSStringFromCGRect(self.view.frame));
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _routesearch.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    if (self.buttomBtn) {
        [self.buttomBtn removeFromSuperview] ;
    }
}
- (void)dealloc {
    
    if (_routesearch != nil) {
        _routesearch = nil;
    }
    if (_locService != nil) {
        _locService = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
    
    
}



//- (IBAction)arriveCustomerPlace:(id)sender {
//    [UIView animateWithDuration:0.25 animations:^{
//        [self.beforeArrivingView setTransform:CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.width)];
//        self.beforeArrivingView.hidden = YES;
//        self.arrivedView.hidden = 0;
//        
//    }];
//    
//}

@end
