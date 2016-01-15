//
//  MapLocationViewController.h
//  Community
//
//  Created by gusheng on 14-9-4.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface MapLocationViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
    CALayer *annotionView;
    CLLocationManager* gps;
    UIButton *locationBtn;
    CLLocationCoordinate2D otherCoordinate;
    CLLocationCoordinate2D myCoordinate;
    BOOL isOffFlag;
}
@property (strong, nonatomic)    CLLocationManager* locationManager;
@property (retain, nonatomic) NSString *longitudeText;
@property (retain, nonatomic) NSString *latituduText;
@property (retain, nonatomic) NSString *posizitionText;
@property (retain, nonatomic) IBOutlet MKMapView *mapViewTemp;
@property (nonatomic,copy) void(^clickReturnLocation)(NSString *posizition,NSString *latitude,NSString *longtitude);
-(void)clickLocation;
@end
