//
//  HWDetailBaseInfoViewController.h
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-22.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWDetailBaseInfoCell.h"

@interface HWDetailBaseInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,HWDetailBaseInfoCellDelegate>

@property (nonatomic,strong) NSDictionary *baseInfo;

@end
