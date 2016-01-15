//
//  HWRentsHuXingVC.h
//  Community
//
//  Created by lizhongqiang on 14-9-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  选择户型

#import "HWBaseViewController.h"
#import "HWHouseSaleRentsVC.h"
#import "HWNumberButton.h"
#import "HWRentsData.h"


@protocol HWRentsHuXingVCDelegate <NSObject>

- (void)getRentsHuXing;

@end

@interface HWRentsHuXingVC : HWBaseViewController

@property (nonatomic, assign)id<HWRentsHuXingVCDelegate>delegate;
@property (nonatomic, weak)UIViewController *superVC;                   //上级视图
@property (nonatomic, weak)UIViewController *rootVC;                    //出售托管根视图
@property (nonatomic, strong) NSString *phoneHistoryId;
@end
