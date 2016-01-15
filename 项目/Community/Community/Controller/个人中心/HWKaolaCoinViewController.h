//
//  HWKaolaCoinViewController.h
//  Community
//
//  Created by gusheng on 14-12-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWRefreshBaseViewController.h"

@interface HWKaolaCoinViewController : HWRefreshBaseViewController<UITableViewDataSource,UITableViewDelegate, UIActionSheetDelegate>
{
    UILabel *_moneyLabel;
    UITableView *_selectTableView;
    NSTimer *_timer;
    
    NSArray *_totalArray;
    UIView *_redPacketView;
    
    
    float _addMoney;
    UIImageView *_backIV;
    
    NSArray *_selectArray;
    NSString *_cashType;
    
    
    NSMutableArray *_returnCellArray;
    UILabel *_tableHV;
    
    //是否第一次加载页面，如果不是资产数字将不再有动画效果
    BOOL _isFirstTime;
    //    DRNRealTimeBlurView *_blurView;
    
}

@property (nonatomic, strong)NSString *totalMoney;
@end
