//
//  HWFangDaiBusiness.h
//  UtilityDemo
//
//  Created by lizhongqiang on 15/7/2.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HWFangSelectVC.h"

#import "HWFangResultViewController.h"

@protocol HWFangDaiBusinessDelegate <NSObject>

- (void)turnToResultVC:(HWFangResultViewController *)resultVC;

@end

@interface HWFangDaiBusiness : UIView


@property (nonatomic, copy)void(^turnToResultVC)(HWFangResultViewController *resultVC);

@property (nonatomic, copy)void(^turnToNextVC)(NSInteger temp, NSInteger row);

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic, retain)HWFangSelectVC *cellSelectedVC;

@property (nonatomic, copy)NSString *resultType;

@property (nonatomic, copy)NSString *zongEValue;

@property (nonatomic, copy)NSString *danJiaValue;

@property (nonatomic, copy)NSString *mianJiValue;

@end
