//
//  HWMyCardDetailController.h
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-7-8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseViewControllerOC.h"

@interface HWMyCardDetailController : HWBaseViewControllerOC<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *cardInfo;
@property (nonatomic, strong) UIViewController *popToViewController;

@end
