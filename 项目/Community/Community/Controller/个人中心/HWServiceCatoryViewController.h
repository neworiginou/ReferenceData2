//
//  HWServiceCatoryViewController.h
//  Community
//
//  Created by gusheng on 14-9-15.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWBaseViewController.h"
@interface HWServiceCatoryViewController : HWBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *serviceCatoryTableView;
@property(nonatomic,strong)NSMutableArray *catoryArry;
@property(nonatomic,copy)void(^selectCatory)(NSString *serviceCatory,NSString* index,NSURL *catoryImage);
@end
