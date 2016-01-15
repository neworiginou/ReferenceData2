//
//  HWRentsIntentionVC.h
//  Community
//
//  Created by lizhongqiang on 14-9-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  租售意向

#import "HWBaseViewController.h"
#import "HWRentsPeopleInfoVC.h"
#import "HWRentsData.h"

@protocol HWRentsIntentionVCDelegate <NSObject>

- (void)getRentsIntention;

@end


@interface HWRentsIntentionVC : HWBaseViewController
@property (nonatomic, assign) id <HWRentsIntentionVCDelegate> delegate;
@property (nonatomic, weak)UIViewController *superVC;                   //上级视图
@property (nonatomic, weak)UIViewController *rootVC;                    //出售托管根视图

@property (nonatomic,strong)NSString *phoneHistoryId;

@end
