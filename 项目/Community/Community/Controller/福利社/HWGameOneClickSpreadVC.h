//
//  HWGameOneClickSpreadVC.h
//  Community
//
//  Created by WeiYuanlin on 15/1/16.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//


#import "HWBaseViewController.h"
#import "HWGameNameTableView.h"
#import "HWShareView.h"
#import "HWGameDetailViewController.h"

@interface HWGameOneClickSpreadVC : HWBaseViewController <HWGameNameTableViewDelegate>

@property (nonatomic, strong) NSString *gameName;

@end
