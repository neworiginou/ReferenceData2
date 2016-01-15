//
//  HWRentsPeopleInfoVC.h
//  Community
//
//  Created by lizhongqiang on 14-9-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  租售人信息

#import "HWBaseViewController.h"
#import "HWRentsAddressVC.h"
#import "HWRentsData.h"
#import "HWInputBackView.h"
@protocol HWRentsPeopleInfoVCDelegate <NSObject>

- (void)getRentsPeopleInfo;

@end

@interface HWRentsPeopleInfoVC : HWBaseViewController<UITextFieldDelegate>
@property (nonatomic, assign)id<HWRentsPeopleInfoVCDelegate>delegate;
@property (nonatomic, weak)UIViewController *superVC;                   //上级视图
@property (nonatomic, weak)UIViewController *rootVC;                    //出售托管根视图
@property (nonatomic, strong) NSString *phoneHistoryId;
@end
