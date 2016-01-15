//
//  AppDelegate.h
//  VideoTest
//
//  Created by lkk on 13-11-25.
//  Copyright (c) 2013年 lkk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HTTPServer;
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    HTTPServer *httpServer;
}

@property (strong, nonatomic) UIWindow *window;

@end
