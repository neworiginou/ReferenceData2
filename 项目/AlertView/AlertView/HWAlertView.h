//
//  HWAlertView.h
//  AlertView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWAlertView : UIView


@property (nonatomic, copy)NSString *tipNumber;

@property (nonatomic, copy)NSString *projectName;

@property (nonatomic, copy)NSString *perpoleName;

@property (nonatomic, copy)NSString *telephone;

@property (nonatomic, copy)NSString *context;

@property (nonatomic, copy)NSString *money;

@property (nonatomic, strong)NSArray *numberArr;

@property (nonatomic, copy)NSString *getTime;



- (void)show;

- (void)hide;

@end
