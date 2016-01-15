//
//  HWFangeZuHeView.h
//  UtilityDemo
//
//  Created by lizhongqiang on 15/7/6.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWFangResultViewController.h"

#import "HWFangZuHeVC.h"

@protocol HWFangeZuHeViewDelegate<NSObject>

- (void)turnToResultVC:(HWFangResultViewController *)resultVC;

@end

@interface HWFangeZuHeView : UIView

@property (nonatomic, assign)id<HWFangeZuHeViewDelegate> delegate;

@property (nonatomic, copy)void(^turnToResultVC)(HWFangResultViewController *resultVC);

@property (nonatomic, copy)void(^turnToNextVC)(NSInteger temp, NSInteger row);

@property (nonatomic, strong)HWFangZuHeVC *cellSelectedVC;

@property (nonatomic, copy)NSString *resultType;

@end
