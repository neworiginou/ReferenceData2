//
//  HWRentsAreaVC.h
//  Community
//
//  Created by lizhongqiang on 14-9-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  租售面积

#import "HWBaseViewController.h"
#import "HWRentsHuXingVC.h"
#import "HWRentsData.h"
#import "HWInputBackView.h"

@protocol HWRentsAreaVCDelegate <NSObject>

- (void)getRentsArea;

@end


@interface HWRentsAreaVC : HWBaseViewController

@property (nonatomic, assign)id<HWRentsAreaVCDelegate>delegate;
@property (nonatomic, weak)UIViewController *superVC;                   //上级视图
@property (nonatomic, weak)UIViewController *rootVC;                    //出售托管根视图
@property (nonatomic, strong) NSString *phoneHistoryId;
@end
