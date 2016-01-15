//
//  InformationView.h
//  PUClient
//
//  Created by RRLhy on 15/7/30.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationView : UIView
@property (nonatomic,retain)UIViewController * controller;
- (void)reloadinformation:(RrmjUser*)user;
@end
