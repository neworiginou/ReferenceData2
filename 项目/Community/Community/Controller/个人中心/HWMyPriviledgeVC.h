//
//  HWMyPriviledgeVC.h
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWBaseViewController.h"
#import "HWRefreshBaseViewController.h"

@interface HWMyPriviledgeVC : HWRefreshBaseViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableDelegate>
{
    UITableView *_myPriviledgeTableView;

}
@end
