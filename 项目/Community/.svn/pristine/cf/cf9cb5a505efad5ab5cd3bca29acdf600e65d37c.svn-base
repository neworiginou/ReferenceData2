//
//  HWGameSpreadRecordTableView.h
//  Community
//
//  Created by niedi on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWGameSpreadRecordCell.h"
#import "HWGameSpreadRecordModel.h"

@protocol HWGameSpreadRecordDelegate <NSObject>

@optional
- (void)popViewController;
- (void)pushToYongJinDescriptionViewController;
- (void)pushToGameDetailViewController:(HWGameSpreadRecordModel *)model;

@end



@interface HWGameSpreadRecordTableView : HWBaseRefreshView
{
    UIView *_tableViewHeadView;
    UIView *_rmbHeadView;
    UIView *_KoalaCoinHeadView;
    
    UILabel *_moneyAmountsLab;
    UILabel *_koalaCoinAmountsLab;
    
}


@property (nonatomic, weak) id<HWGameSpreadRecordDelegate> delegate;

@end
