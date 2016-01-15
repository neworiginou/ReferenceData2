//
//  HWCityViewController.h
//  HaoWu_4.0
//
//  Created by zhuming on 14-6-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWCityListViewController : UITableViewController

@property(nonatomic,copy)void (^City)(NSDictionary*dic);

@property(nonatomic, strong)NSString *province_id;



@end
