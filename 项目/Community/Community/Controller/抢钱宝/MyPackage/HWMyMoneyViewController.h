//
//  HWMoneyViewController.h
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-20.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FiltButton.h"
#import "HWRefreshBaseViewController.h"

@interface HWMyMoneyViewController : HWRefreshBaseViewController<UITableViewDataSource,UITableViewDelegate, UIActionSheetDelegate>
{
    UILabel *_moneyLabel;
    UITableView *_selectTableView;
    NSTimer *_timer;
    
    NSArray *_totalArray;
    UIView *_redPacketView;

    
    float _addMoney;
    FiltButton *_selectButton;
    UIImageView *_backIV;
    
    NSArray *_selectArray;
    NSString *_cashType;
    
    
    NSMutableArray *_returnCellArray;
    NSMutableArray *_yearArray;
    NSArray *_fillArray;
    UILabel *_tableHV;
    
    //是否第一次加载页面，如果不是资产数字将不再有动画效果
    BOOL _isFirstTime;
//    DRNRealTimeBlurView *_blurView;
    
}

@property (nonatomic, strong)NSString *totalMoney;

@end
