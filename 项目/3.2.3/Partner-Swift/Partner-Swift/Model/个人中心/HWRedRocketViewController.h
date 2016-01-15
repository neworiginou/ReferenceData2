//
//  HWRedRocketViewController.h
//  Partner-Swift
//
//  Created by gusheng on 15/5/24.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "STScratchView.h"
#import "HWBaseViewControllerOC.h"
@interface HWRedRocketViewController : HWBaseViewControllerOC<STScratchViewDelegate>
@property(nonatomic,strong)NSString * sourceStr;//“1”代表从房源过来的
@property(nonatomic,strong)NSString * redIdStr;//红包Id
@property(nonatomic,strong)NSString * moneyStr;//红包金额
@property(nonatomic,copy)void(^refershRedList)();
@end
