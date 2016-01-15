//
//  MapLocationViewController.m
//  Community
//
//  Created by gusheng on 14-9-4.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "MapLocationViewController.h"

@interface MapLocationViewController ()

@end

@implementation MapLocationViewController
@synthesize mapViewTemp,latituduText,longitudeText,posizitionText;
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
    
    self.navigationItem.titleView = [Utility navTitleView:@"定位小区"];
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    mapViewTemp = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    mapViewTemp.mapType = MKMapTypeStandard;
    mapViewTemp.delegate = self;
    MKCoordinateSpan span ;//缩放比例
    span.latitudeDelta = 0.05;//经度
    span.longitudeDelta = 0.05;
    MKCoordinateRegion region=self.mapViewTemp.region;//坐标显示范围
    region.span = span;
    self.mapViewTemp.region = region;
//    [self.mapViewTemp setCenterCoordinate:otherCoordinate animated:YES];
    self.mapViewTemp.showsUserLocation = YES;
    isOffFlag = YES;
    [self.view addSubview:mapViewTemp];
    
    annotionView = [[CALayer alloc]init];
    [annotionView setFrame:CGRectMake(mapViewTemp.frame.size.width/2-44/2+7, mapViewTemp.frame.size.height/2-44, 44, 44)];
    annotionView.contents = (id)[UIImage imageNamed:@"map22"].CGImage;
    
    UIImageView *dotLayer = [[UIImageView alloc]init];
    dotLayer.backgroundColor = [UIColor clearColor];
    dotLayer.layer.masksToBounds = YES;
    dotLayer.layer.cornerRadius = 4;
    [dotLayer setFrame:CGRectMake(mapViewTemp.frame.size.width/2-4/2, mapViewTemp.frame.size.height/2-4/2+44/2, 4, 4)];
    [mapViewTemp addSubview:dotLayer];
    [mapViewTemp.layer addSublayer:annotionView];
    gps = [[CLLocationManager alloc] init];
    gps.delegate = self;
    gps.desiredAccuracy = kCLLocationAccuracyBest;
//    gps.distanceFilter = kCLDistanceFilterNone;
    if (IOS8)
    {
        [gps requestWhenInUseAuthorization];
//        [gps requestAlwaysAuthorization];
    }
    
    gps.distanceFilter = 50000.0f;
    [gps startUpdatingLocation];
    //添加展示和点击返回地址信息的按钮
    [self createReturnLocationBtn];
    // Do any additional setup after loading the view from its nib.
}
//返回上一级页面
- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  创建按钮
 *
 *  @param degrees
 *
 *  @return
 */
-(void)createReturnLocationBtn
{
    locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[locationBtn setFrame:CGRectMake(0, mapViewTemp.frame.size.height/2-44-30, 320, 30)];
    locationBtn.backgroundColor = [UIColor whiteColor] ;
    [locationBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [locationBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [locationBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [locationBtn addTarget:self action:@selector(clickLocation) forControlEvents:UIControlEventTouchUpInside];
    [mapViewTemp addSubview:locationBtn];
}
//点击展示地址按钮
-(void)clickLocation
{
    posizitionText = locationBtn.titleLabel.text;
    if ([latituduText isEqualToString:@""]) {
        NSLog(@"经度为空");
        return;
    }
    else if([longitudeText isEqualToString:@""])
    {
        NSLog(@"维度为空");
        return;
    }
    else if([posizitionText isEqualToString:@""])
    {
        NSLog(@"位置为空");
        return;
    }
    if (_clickReturnLocation) {
        _clickReturnLocation(posizitionText,latituduText,longitudeText);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    CLLocationCoordinate2D locationTemp =  [mapView convertPoint:CGPointMake(mapViewTemp.frame.size.width/2-10/2, mapViewTemp.frame.size.height/2-10/2) toCoordinateFromView:mapViewTemp];
        NSLog(@"地图经度是%f,维度是%f",locationTemp.latitude,locationTemp.longitude);
    [self reverseGeocodeLocation:locationTemp];
    [self animationDownAndUp];


}

/**
 *  经纬度反向编码解析出地理信息
 *
 *  @param location
 */
-(void)reverseGeocodeLocation:(CLLocationCoordinate2D )location
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *locationTemp1 = [[CLLocation alloc]initWithLatitude:location.latitude longitude:location.longitude];
    [geocoder reverseGeocodeLocation: locationTemp1 completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            
            CLPlacemark *placemark = [array objectAtIndex:0];
//            NSString *country = placemark.ISOcountryCode;
//           NSString *city = placemark.locality;
             NSDictionary *dic = placemark.addressDictionary;
//            NSLog(@"---%@..........%@..cout:%d",country,city,[array count]);
//            // NSLog(@"info is %@",placemark.addressDictionary);
//           
//            
//            NSLog(@"the city is %@",[dic objectForKey:@"City"]);
//            NSLog(@"the Country is %@",[dic objectForKey:@"Country"]);
//            NSLog(@"the CountryCode is %@",[dic objectForKey:@"CountryCode"]);
//            NSLog(@"the FormattedAddressLines is %@",[dic objectForKey:@"FormattedAddressLines"]);
//            NSLog(@"the Name is %@",[dic objectForKey:@"Name"]);
//            NSLog(@"the State is %@",[dic objectForKey:@"State"]);
//            NSLog(@"the SubLocality is %@",[dic objectForKey:@"SubLocality"]);
            [locationBtn setTitle:[dic objectForKey:@"Name"] forState:UIControlStateNormal];
            [locationBtn sizeToFit];
            locationBtn.layer.cornerRadius = 3.0;
            locationBtn.layer.masksToBounds = YES;
            [locationBtn setFrame:CGRectMake(160-locationBtn.frame.size.width/2-5, mapViewTemp.frame.size.height/2-44-30, locationBtn.frame.size.width+10, 30)];
            
        }
    }];

}
/**
 *  上下跳动的动画
 */
-(void)animationDownAndUp
{
    CABasicAnimation *theAnimation2;    //定义动画
    theAnimation2=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];//定义沿y轴移动，transform.translation.x即为沿x轴移动
    theAnimation2.fromValue=[NSNumber numberWithFloat:0];//以当前位置为基准出发
    theAnimation2.toValue=[NSNumber numberWithFloat:-10];//以当前位置为基准向上移动10个像素
    theAnimation2.duration = 0.5f;//动画持续时间
    theAnimation2.repeatCount = 2;//动画重复次数
    theAnimation2.autoreverses = YES;//是否自动重复
    theAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [annotionView addAnimation:theAnimation2 forKey:@"animateLayer"];
    [locationBtn.layer addAnimation:theAnimation2 forKey:@"animateLayer"];
    //animationImage就是移动的图片
}
//当前坐标

-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"yyyyyyyyyyyyy");
    if (isOffFlag) {
        myCoordinate.latitude = userLocation.coordinate.latitude;
        myCoordinate.longitude = userLocation.coordinate.longitude;
        mapViewTemp.centerCoordinate = myCoordinate;
        MKCoordinateRegion region = MKCoordinateRegionMake(myCoordinate, MKCoordinateSpanMake(0.05, 0.05));
        [mapViewTemp setRegion:[mapViewTemp regionThatFits:region] animated:YES];
        isOffFlag = NO;
    }
}
- (void)locationManager:(CLLocationManager *)locationManager didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *) oldLocation;
{
	NSString *locationStr =  [NSString stringWithFormat:@"%f,%f",newLocation.coordinate.latitude, newLocation.coordinate.longitude];
    NSLog(@"the location is %@",locationStr);
	CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [gps stopUpdatingLocation];
    [geocoder reverseGeocodeLocation: newLocation completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            
            CLPlacemark *placemark = [array objectAtIndex:0];
             NSDictionary *dic = placemark.addressDictionary;
            NSString *country = placemark.ISOcountryCode;
            NSString *city = placemark.locality;
            NSLog(@"the location is %@",[dic objectForKey:@"Name"]);
            [locationBtn setTitle:[dic objectForKey:@"Name"] forState:UIControlStateNormal];
            NSLog(@"---%@..........%@..cout:%d",country,city,[array count]);
            CLLocationCoordinate2D currentLocation;
            currentLocation.latitude = newLocation.coordinate.latitude;
            currentLocation.longitude = newLocation.coordinate.longitude;
            latituduText = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
            longitudeText = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
            //mapViewTemp.centerCoordinate = currentLocation;
            [locationManager stopUpdatingLocation];
        }
    }];
    

}
// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
