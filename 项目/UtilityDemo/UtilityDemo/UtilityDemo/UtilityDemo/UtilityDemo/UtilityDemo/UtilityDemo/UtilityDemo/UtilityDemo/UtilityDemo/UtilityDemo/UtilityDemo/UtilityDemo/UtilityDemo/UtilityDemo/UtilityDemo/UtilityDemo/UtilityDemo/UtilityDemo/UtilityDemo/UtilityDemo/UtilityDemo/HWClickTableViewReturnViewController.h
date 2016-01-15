//
//  HWClickTableViewReturnViewController.h
//  HaoWuAgenciesEdition
//
//  Created by gusheng on 14-7-11.
//  Copyright (c) 2014年 ZhuMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWClickTableViewReturnViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, copy)void(^returnSelectedResult)(NSString *reslut,NSInteger index);
@property(nonatomic, strong)NSArray *dataArry;
@property(nonatomic, strong)NSString *typeStr;
@end
