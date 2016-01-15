//
//  AppDelegate.h
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWBaseNavigationController.h"
#import "HWTabBarViewController.h"
#import "Reachability.h"
#import "WXApi.h"
#import "HWCheckForceUpdateWidget.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,UIAlertViewDelegate,WXApiDelegate>
{
    UILabel *_infoLabel;
    UILabel *_udidLabel;
    NSDictionary *pushInfo;
    NSString *_isForceUpdate;
    NSString *_forceUpdateMsg;
}
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) CLLocationManager *manager;
@property (nonatomic, strong) HWTabBarViewController *tabBarVC;
@property (nonatomic, strong) Reachability *reachabiltiy;
@property (nonatomic, strong) NSString *activeURL;
@property (nonatomic, strong) NSString *wxAuthCode;  // 微信授权码
@property (nonatomic, strong) NSString *gameBanner;  // 是否显示游戏推广
@property (nonatomic, strong) HWCheckForceUpdateWidget *checkUpdateWidget;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
