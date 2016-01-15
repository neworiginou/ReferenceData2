//
//  HWFangGongJiJin.h
//  UtilityDemo
//
//  Created by lizhongqiang on 15/7/3.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HWFangGongSelectedVC.h"

#import "HWFangResultViewController.h"

@protocol HWFangGongJiJinDelegate <NSObject>

- (void)turnToResultVC:(HWFangResultViewController *)resultVC;

@end

@interface HWFangGongJiJin : UIView


@property (nonatomic, copy)void(^turnToResultVC)(HWFangResultViewController *resultVC);

@property (nonatomic, copy)void(^turnToNextVC)(NSInteger temp, NSInteger row);

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic, retain)HWFangGongSelectedVC *cellSelectedVC;

@property (nonatomic, copy)NSString *resultType;

@property (nonatomic, copy)NSString *zongEValue;

@property (nonatomic, copy)NSString *danJiaValue;

@property (nonatomic, copy)NSString *mianJiValue;


@end
