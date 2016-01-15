//
//  HWMapViewController.m
//  MoreHouse
//
//  Created by zhangxun on 14/12/30.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//

#import "HWMapViewController.h"

#import "WXAnation.h"

@interface HWMapViewController ()

@end

@implementation HWMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [Utility_OC navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.titleView = [Utility_OC navTitleView:@"查看地图"];
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [UIScreen mainScreen].bounds.size.height - 64)];
    mapView.mapType = MKMapTypeStandard;
    
//    float latitude = [self.lo floatValue];
//    float longitude = [self.la floatValue];
//    
//    
//    
//    NSString *lat = [[addressArray pObjectAtIndex:indexPath.row-1] numberObjectForKey:@"latitude"]; // 纬度
//    NSString *lon = [[addressArray pObjectAtIndex:indexPath.row-1] numberObjectForKey:@"longitude"]; // 经度
    
    float fLat = [self.la floatValue];
    float fLon = [self.lo floatValue];
    BOOL isTrue = YES;
    if (fLat >= 90 || fLat <= -90)
    {
        isTrue = NO;
    }
    if (fLon >= 180 || fLon <= -180)
    {
        isTrue = NO;
    }
    CLLocationCoordinate2D coord;
    if (!isTrue)
    {
        coord = CLLocationCoordinate2DMake(0, 0);
    }
    else
    {
        coord = CLLocationCoordinate2DMake(fLat, fLon);
    }
    
//    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(fLon, fLat);
    MKCoordinateSpan span = {0.1,0.1};
    MKCoordinateRegion region = {coord,span};
    [mapView setRegion:region animated:YES];
    mapView.zoomEnabled = YES;
    mapView.delegate = self;
    mapView.scrollEnabled = YES;
    [self.view addSubview:mapView];
    //创建anation对象
    WXAnation *anation = [[WXAnation alloc] initWithCoordinate2D:coord];
    
    [mapView addAnnotation:anation];
    
    
    
}

#pragma mark - MKAnnotationView delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation {
    
    //判断是否为当前设备位置的annotation
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        //返回nil，就使用默认的标注视图
        return nil;
    }
    
    //-------------------创建大头针视图---------------------
    
    static NSString *identifier = @"Annotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        
        //MKPinAnnotationView 是大头针视图
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        //设置是否显示标题视图
        annotationView.canShowCallout = NO;
        }
    
    annotationView.annotation = annotation;
    
    //设置大头针的颜色
    annotationView.pinColor = MKPinAnnotationColorRed;
    //从天上落下的动画
    annotationView.animatesDrop = YES;
    
    return annotationView;
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
