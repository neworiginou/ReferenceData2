//
//  HWProvinceViewController.h
//  HaoWu_4.0
//
//  Created by zhuming on 14-5-31.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWProvinceViewController : UITableViewController
@property(nonatomic,copy)void (^Province)(NSDictionary*dic);
@end
