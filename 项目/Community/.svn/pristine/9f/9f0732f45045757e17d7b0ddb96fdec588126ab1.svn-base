//
//  HWRentsAddressVC.h
//  Community
//
//  Created by lizhongqiang on 14-9-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  租售地址

#import "HWBaseViewController.h"
#import "HWRentsAreaVC.h"
#import "HWRentsData.h"
#import "HWInputBackView.h"
#import "HWLocationChangeViewController.h"

@protocol HWRentsAddressVCDelegate <NSObject>

- (void)getRentsAddress;

@end


@interface HWRentsAddressVC : HWBaseViewController<UITextFieldDelegate,HWLocationChangeOtherDelegate>

@property (nonatomic, assign)id<HWRentsAddressVCDelegate>delegate;
@property (nonatomic, weak)UIViewController *superVC;                   //上级视图
@property (nonatomic, weak)UIViewController *rootVC;                    //出售托管根视图
@property (nonatomic, strong) NSString *phoneHistoryId;
@end
