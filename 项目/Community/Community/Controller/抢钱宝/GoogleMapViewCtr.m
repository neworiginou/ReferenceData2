//
//  GoogleMapViewCtr.m
//  Haowu_3.0
//
//  Created by PengHuang on 14-4-14.
//  Copyright (c) 2014年 PengHuang. All rights reserved.
//

#import "GoogleMapViewCtr.h"
//#import <GoogleMaps/GoogleMaps.h>
#import <MapKit/MapKit.h>

@interface GoogleMapViewCtr () {
//    GMSMapView *mapView_;
    MKMapView *_mapView;
    
}

@end

@implementation GoogleMapViewCtr
@synthesize annotationTitle,address,coordinate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.titleView = [Utility navTitleView:@"地图"];
        self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backBtnClick)];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [mapView_ startRendering];
}

- (void)viewWillDisappear:(BOOL)animated {
//    [mapView_ stopRendering];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    _mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
//    mapView.scrollEnabled=NO;
//    [mapView setDelegate:self];
    //设置地图中心
//    CLLocationCoordinate2D coor;
//    coor.latitude = coordinate.longitude;
//    coor.longitude = coordinate.latitude;
//    //NSLog(@"---l :%f  l:%f",coor.latitude,coor.longitude);
    MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
    ann.coordinate = coordinate;
    [ann setTitle:annotationTitle];
    [ann setSubtitle:address];
    //触发viewForAnnotation
    [_mapView addAnnotation:ann];
    //添加多个
    //[mapView addAnnotations]
    
    
    
    
//    //设置显示范围
//    MKCoordinateRegion region;
//    region.span.latitudeDelta = 0.1;
//    region.span.longitudeDelta = 0.1;
//    region.center = coordinate;
    
    // 设置地图显示的类型及根据范围进行显示
    
    
    
    [self.view addSubview:_mapView];
    
    
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-22.86 longitude:151.20 zoom:3];
//    //    GMSCamera camera = GMSCameraMake(-33.8683, 151.2086, 6);
//    mapView_ = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
//    mapView_.mapType = kGMSTypeSatellite;
//    [self.view addSubview:mapView_];
    // Do any additional setup after loading the view.
    // 创建一个GMSCameraPosition,告诉map在指定的zoom level下显示指定的点
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-22.86 longitude:151.20 zoom:6];
//    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) camera:camera];
//    [self.view addSubview:mapView_];
//    
//    // 在map中间做一个标记
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(-22.86, 151.20);
//    marker.title = @"Sydney";
//    marker.snippet = @"Australia";
//    marker.map = mapView_;
//    
}
- (void)viewDidAppear:(BOOL)animated
{
    float zoomLevel = 0.02;
    // 设置显示位置(动画)
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(zoomLevel, zoomLevel));
    [_mapView setRegion:region animated:YES];
    [_mapView regionThatFits:region];
}

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

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
