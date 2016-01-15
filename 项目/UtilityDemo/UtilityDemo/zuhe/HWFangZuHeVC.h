//
//  HWFangZuHeVC.h
//  UtilityDemo
//
//  Created by lizhongqiang on 15/7/6.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWFangZuHeVC : UIViewController

@property (nonatomic, assign)NSInteger paymentIndex;

@property (nonatomic, assign)NSInteger anjieYearIndex;

@property (nonatomic, assign)NSInteger rateIndex;

@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic, assign)NSInteger selectedRow;

@property (nonatomic, copy)void(^reloadForTableView)();

@end
