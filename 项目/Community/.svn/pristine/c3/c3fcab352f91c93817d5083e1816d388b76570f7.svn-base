//
//  MineExtendDetailViewController.h
//  TEST
//
//  Created by gusheng on 14-8-29.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWRefreshBaseViewController.h"
#import "MineExtendHeaderView.h"
typedef  enum{
    MINEEXTENDKEY=0,
    ERVERYDAYRECORD=1,
    ACTIVEANDSCANNUM=2
} extendRecord;
@interface MineExtendDetailViewController : HWRefreshBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    MineExtendHeaderView *tableHeaderView;
    NSInteger questType;
    NSInteger flag;//标示是不是发送获取扫码和激活数请求0-代表发送请求，1-代表不发送请求
}
@property(nonatomic,assign)NSInteger questType;
@end
