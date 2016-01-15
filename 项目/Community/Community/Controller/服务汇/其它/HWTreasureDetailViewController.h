//
//  HWTreasureDetailViewController.h
//  Community
//
//  Created by caijingpeng.haowu on 14-12-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWRefreshBaseViewController.h"
#import "HWJoinedActivityModel.h"

typedef enum
{
//    NoStart = 0,    // 未开始
    ProceedMode = 0,    // 进行中
    EndMode,         // 结束 流标
    PrizeMode,        // 结束 已中奖
    NormalEndMode       // 结束 已开奖
    
}ActivityMode;

@interface HWTreasureDetailViewController : HWRefreshBaseViewController

@property (nonatomic, strong)HWJoinedActivityModel *joinedItem;

//@property (nonatomic, strong) NSString *productId;

@property (nonatomic, strong)UIViewController *popToViewController;

@property (nonatomic, strong) NSString *wuDiXianChannelId;

@end
